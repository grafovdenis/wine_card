/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('discounts', {
    discount_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    place_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'places',
        key: 'place_id'
      }
    },
    drink_type: {
      type: DataTypes.ENUM("пиво и сидр","водка и настойки","ром","текила","виски","биттеры","вино","бренди и коньяк","шоты","коктейли","безалкогольные"),
      allowNull: false
    },
    amount: {
      type: DataTypes.DOUBLE,
      allowNull: false
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    weekday: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    time_start: {
      type: DataTypes.TIME,
      allowNull: true
    },
    time_end: {
      type: DataTypes.TIME,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'discounts'
  });
};
