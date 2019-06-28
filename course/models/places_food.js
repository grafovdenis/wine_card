/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('places_food', {
    place_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'places',
        key: 'place_id'
      }
    },
    food_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'food',
        key: 'food_id'
      }
    },
    price: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    amount: {
      type: DataTypes.INTEGER,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'places_food'
  });
};
