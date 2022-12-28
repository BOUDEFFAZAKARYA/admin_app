const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const Admin = db.define('admins' ,{
    idAdmin :{
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        validate :{
            notEmpty : true
        }
    },
    emailAdmin :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    passwordAdmin :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});

Admin.sync().then(() => {
    console.log('Admin table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : Admin', error);
 });
 
module.exports = Admin;