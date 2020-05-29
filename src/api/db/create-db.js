const { Pool } = require('pg');
const pgtools = require('pgtools');
const debug = require('debug')('log');
const fs = require('fs').promises;
const path = require('path');

// if DB exists
const createDB = (dbConfig) => {
  const pool = new Pool({
    user: dbConfig.user,
    host: dbConfig.host,
    database: dbConfig.database,
    password: dbConfig.password,
    port: dbConfig.port
  });

  const migrateFn = async () => {
    let migrationClient;
    try {
      debug('Running migration ...');
      const sql = await fs.readFile(path.join(__dirname, './sql/db-create.sql'), 'utf8');
      debug('read sql file');

      // reconnect client first
      migrationClient = await pool.connect();

      await migrationClient.query(sql);
      await migrationClient.query(`
        INSERT INTO DB_VERSION (ID, VERSION)
        VALUES (1, 1.0)
        ON CONFLICT (ID) DO UPDATE SET VERSION = EXCLUDED.VERSION
      `);

      debug('Migration run succesfully');
      migrationClient.release();
    } catch (err) {
      debug(err.message);
      debug('An error occured executing SQL file');
    }
  };

  debug('Checking for database ...');
  (async () => {
    let client;
    try {
      client = await pool.connect();
      debug('Database found!');

      try {
        debug('Checking for initial migration ....');

        const result = await client.query('select exists(select version from db_version where version >= 1) as migrated');
        if (result.rows[0].migrated) {
          debug('Database has been migrated');
          return 'migrated';
        }
      } catch (error) {
        if (error.message.includes('relation "db_version" does not exist')) {
          debug('Migration has not run yet. Attempting to run ...');
          migrateFn();
        }
      }

      client.release();
    } catch (error) {
      debug(error.message);

      if (error.message.includes(`database "${dbConfig.database}" does not exist`)) {
        debug('Database not found!');
        debug('Attempting to create DB ...');

        try {
          await pgtools.createdb(
            {
              user: dbConfig.user,
              host: dbConfig.host,
              password: dbConfig.password,
              port: dbConfig.port
            },
            dbConfig.database
          );

          debug(`Database - ${dbConfig.database} created successfully`);

          // run migration
          migrateFn();
        } catch (err) {
          debug(err.message);
          process.exit(-1);
        }
      }
    }

    return 'not migrated';
  })(pool);
};

export default createDB;
