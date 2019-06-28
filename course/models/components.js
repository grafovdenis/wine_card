/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('components', {
    component_id: {
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
    alcohol: {
      type: DataTypes.DOUBLE,
      allowNull: true
    }
  }, {
		timestamps: false,
		schema: "public",
    tableName: 'components'
  });
};
