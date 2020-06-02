/* jshint indent: 2 */
const { DataTypes, Model } = require('sequelize');

module.exports = (sequelize) => {
  class Reporter extends Model {}
  Reporter.init({
    reporterId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      comment: 'null',
      primaryKey: true,
      autoIncrement: true,
      field: 'reporter_id'
    },
    firstName: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      field: 'first_name'
    },
    lastName: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      field: 'last_name'
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      field: 'phone_number'
    },
    fbId: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'firebase UID',
      unique: true,
      field: 'fb_id'
    },
    lastActive: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.fn('now'),
      comment: 'null',
      field: 'last_active'
    },
    activeStatus: {
      type: DataTypes.ENUM('ACTIVE', 'SUSPENDEDED', 'BLOCKED', 'INVALID', 'DISABLED'),
      allowNull: false,
      defaultValue: 'ACTIVE',
      comment: 'null',
      field: 'active_status'
    }
  }, {
    sequelize,
    tableName: 'reporters',
    modelName: 'Reporter'
  });

  return Reporter;
};
