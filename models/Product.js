const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const TypePeau = require('./TypePeau');
const Category = require('./Category');

const Product = db.define('products' ,{
    barCode :{
        type:DataTypes.BIGINT,
        primaryKey: true,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    nameProduct :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    descProduct:{
        type:DataTypes.TEXT,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    pathimage:{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    }
});


TypePeau.hasOne(Product);
Product.belongsTo(TypePeau)


Category.hasOne(Product);
Product.belongsTo(Category)


Product.sync().then(() => {
    console.log('Product table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : ', error);
 });
 
module.exports = Product;