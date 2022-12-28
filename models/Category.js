const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const Category = db.define('categories' ,{
    idCategory :{
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        validate :{
            notEmpty : true
        }
    },
    nameCategory :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});

Category.sync().then(() => {
    console.log('Category table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : Category', error);
 });
 
module.exports = Category;