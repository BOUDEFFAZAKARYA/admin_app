const express = require("express");

const router = express.Router();

const categoryRouter = require('./getCategory');
router.use('/getCategory', categoryRouter);

const typeRouter = require('./getType');
router.use('/getType', typeRouter);


const productRouter = require('./postProduct');
router.use('/postProduct', productRouter);

const adminRouter = require('./getAdmin');
router.use('/getAdmin', adminRouter);

module.exports = router;