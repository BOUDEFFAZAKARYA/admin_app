const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const TypePeau = db.define('typepeaus' ,{
    idTypePeau :{
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        validate :{
            notEmpty : true
        }
    },
    nameTypePeau :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});


TypePeau.sync().then(() => {
    console.log('TypePeau table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : TypePeau', error);
 });
 
module.exports = TypePeau;