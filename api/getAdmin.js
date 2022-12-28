const express = require("express");
const router = express.Router();

const Admin = require("../models/Admin");

/*Admin.create({
    "idAdmin" : 1,
    "emailAdmin" : 'meriem@meriem',
"passwordAdmin" : '1111'
})*/

router.post('/', async(req,res) =>  { 
    const email = req.body.emailAdmin;
    const password = req.body.passwordAdmin;
console.log(email,password);
    if(email && password){
        const admins = await Admin.findAll({
            where : {
                emailAdmin : email,
                passwordAdmin : password
            }
        });
        if(admins.length == 0){
            res.status(200).json(false);
        }else{
            res.status(200).json(true);
        }
    }else{
        console.log("All input are required");
        res.status(200).json(false);
    }
});


module.exports = router;