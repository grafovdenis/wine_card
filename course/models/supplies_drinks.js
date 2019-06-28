/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('supplies_drinks', {
    supplies_drinks_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    place_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'places',
        key: 'place_id'
      }
    },
    drink_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'drinks',
        key: 'drink_id'
      }
    },
    amount: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    price_per_item: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    date: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'supplies_drinks'
  });
};
