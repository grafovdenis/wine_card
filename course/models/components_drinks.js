/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('components_drinks', {
    component_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'components',
        key: 'component_id'
      }
    },
    drink_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'drinks',
        key: 'drink_id'
      }
    },
    quantity: {
      type: DataTypes.DOUBLE,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'components_drinks'
  });
};
