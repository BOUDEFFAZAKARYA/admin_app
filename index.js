const db = require ('./config/db');
const express = require('express');
const app = express();
var cors = require('cors');  // Flutter Web
var path = require('path');

app.use(express.urlencoded({ extended: true })); 
app.use(express.json());  
app.use(cors());

app.use(express.static(path.join(__dirname, 'assets')));

const apiRoutes = require('./api');
app.use('/api', apiRoutes);

// CONNECTION WITH DATABASE
db.authenticate().then(() => {
    console.log('Database connected ...');
 }).catch((error) => {
    console.error('Unable to connect to the database: ', error);
 });
 
// LISTEN TO PORT 
const server = app.listen(4000, () => {
    console.log(`The application started on port ${server.address().port}`);
});