/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('food', {
    food_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    rating: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    volume: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    average_price: {
      type: DataTypes.DOUBLE,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'food'
  });
};
