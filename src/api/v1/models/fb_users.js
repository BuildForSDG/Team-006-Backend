/* jshint indent: 2 */
const { DataTypes, Model } = require('sequelize');

module.exports = (sequelize) => {
  class FbUsers extends Model {}
  FbUsers.init({
    userId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      comment: 'null',
      primaryKey: true,
      autoIncrement: true,
      field: 'user_id'
    },
    lastName: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      field: 'last_name'
    },
    firstName: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      field: 'first_name'
    },
    emailAddress: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      unique: true,
      field: 'email_address'
    },
    dateCreated: {
      type: DataTypes.TIME,
      allowNull: false,
      defaultValue: sequelize.fn('now'),
      comment: 'null',
      field: 'date_created'
    },
    activeStatus: {
      type: DataTypes.ENUM('ACTIVE', 'SUSPENDEDED', 'BLOCKED', 'INVALID', 'DISABLED'),
      allowNull: false,
      defaultValue: 'ACTIVE',
      comment: 'null',
      field: 'active_status'
    },
    fbId: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      unique: true,
      field: 'fb_id'
    }
  }, {
    sequelize,
    tableName: 'fb_users',
    modelName: 'FbUsers'
  });
};
