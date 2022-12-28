const express = require("express");
const router = express.Router();
const Product= require('../models/Product');
const multer = require("multer");
var path = require('path');

const storage = multer.diskStorage({
    destination : 'assets/images',
    filename:(req,file,cb) => {
      var name = Math.floor(Math.random() * Math.floor(1522478996655)).toString();
      name += Date.now();
      name += path.extname(file.originalname);
      cb(null,name);
    }
    
})

const upload  = multer({
    storage: storage,
})


router.post("/add-product",upload.single('profile'),async(req,res) => {
    const bar = req.body.barCode;
    const name = req.body.nameProduct;
    const desc = req.body.descProduct;
    const idcat = req.body.categoryIdCategory;
    const idtyp = req.body.typepeauIdTypePeau;
if (bar && name && desc  && idcat && idtyp){
    if (!req.file) {
        console.log("No file received");
        return res.send(false);
      } else {
        const products = await Product.findAll(
            {
                where : {
                    barCode : bar,
                }
            }
        );
        if(products.length == 0){
            Product.create({
                "barCode" : bar,
                "nameProduct" : name,
                "descProduct": desc,
                "pathimage" : `/images/${req.file.filename}`,
                "typepeauIdTypePeau": idtyp,
                "categoryIdCategory": idcat,
            });
            return res.send(true);
        }else{
            return res.send(false);
        }
      }
    }else{
        console.log('All input are required');
    }

});//end of app.post()

module.exports = router;