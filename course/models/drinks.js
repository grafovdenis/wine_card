/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('drinks', {
    drink_id: {
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
    alcohol: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    average_price: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    drink_type: {
      type: DataTypes.ENUM("пиво и сидр","водка и настойки","ром","текила","виски","биттеры","вино","бренди и коньяк","шоты","коктейли","безалкогольные"),
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'drinks'
  });
};
