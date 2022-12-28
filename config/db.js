const {Sequelize, DataTypes} = require('sequelize');
module.exports = new Sequelize(
  'testApp',
  'postgres',
  '1111',
  {
    host: 'localhost',
    port: 5433,
    dialect: 'postgres'
  }
)
