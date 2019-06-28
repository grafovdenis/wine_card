/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('places', {
    place_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false
    },
    address: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    rating: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    average_bill: {
      type: DataTypes.DOUBLE,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'places'
  });
};
