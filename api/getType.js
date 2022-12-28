const express = require("express");
const router = express.Router();

const TypePeau = require("../models/TypePeau");

router.get('/', async(req,res) =>  { 
    const typepeau = await TypePeau.findAll();
    if (typepeau === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(typepeau);
      }
});

module.exports = router;