const { query } = require('express')
const {productDb,orderDb,userDb} = require('../database/database')

exports.homeRoute = (req,res)=>{
    res.send('Welcome to Backend of Food Express')
}


