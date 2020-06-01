/* jshint indent: 2 */
const { DataTypes, Model } = require('sequelize');

module.exports = (sequelize) => {
  class RefreshToken extends Model {}

  RefreshToken.init({
    fbId: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      primaryKey: true,
      field: 'fb_id'
    },
    tokenHash: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: 'null',
      primaryKey: true,
      field: 'token_hash'
    },
    deviceId: {
      type: DataTypes.STRING,
      allowNull: true,
      comment: 'null',
      field: 'device_id'
    },
    dateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.fn('now'),
      comment: 'null',
      field: 'date_created'
    }
  }, {
    sequelize,
    tableName: 'refresh_tokens',
    modelName: 'RefreshToken'
  });

  return RefreshToken;
};
