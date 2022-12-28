const express = require("express");
const router = express.Router();

const Category = require("../models/Category");

router.get('/', async(req,res) =>  { 
    const category = await Category.findAll();
    if (category === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(category);
      }
});


module.exports = router;