const { query } = require('express')
const {productDb,orderDb,userDb} = require('../database/database')

exports.homeRoute = (req,res)=>{
    res.send('Welcome to Backend of Food Express')
}

exports.addPopularProduct = async(req,res)=>{
    const productData = req.body
    try {
        const savedProduct = await productDb.addPopularProduct(productData);
        // Send success response
        res.status(201).json(savedProduct);
      } catch (error) {
     
       res.status(500).json({ error: `Failed to add product: ${error}` });
      }

}

exports.deletePopularProduct = async(req,res)=>{
    const productId = req.params.productId;
    try {
        const deletedProduct = await productDb.deletePopularProduct(productId);
        // Send success response
        res.status(200).json({ message: 'Product deleted successfully.', deletedProduct });
      } catch (error) {
     
       res.status(500).json({ error: `Failed to add product: ${error}` });
      }

}

exports.getPopularProductList = async(req,res)=>{
    try{
        const products = await productDb.getPopularProductList()
        res.status(200).json(products)
    }catch(error){
        res.status(500).json({ error: `Failed to add product: ${error}` });
    }
    
}

exports.createOrder = async(req,res)=>{
    const order = req.body
    try{
       const savedOrder = await orderDb.addOrder(order)
       res.status(200).json(savedOrder)
    }catch(error){
        res.status(500).json({ error: `Failed to create an order: ${error}`})
    }
}

exports.getOrders = async(req,res)=>{
    const userId = req.params.id
    try{
       const orders = await orderDb.getOrders(userId)
       res.status(200).json(orders)
    }catch(error){
        res.status(500).json({error : `Failed to retrieve orders: ${error}`})
    }
}

exports.registerUser = async(req,res)=>{
    const user = req.body
    console.log(user)
    try {
        const newUser = await userDb.registerUser(user);

        if (newUser && newUser.message) {
            res.status(409).json(newUser); 
        } else {
            res.status(200).json(newUser); // Registration successful
        }
    } catch (error) {
        res.status(500).json({ error: `Failed to create user: ${error}` });
    }
}

exports.loginUser = async(req,res)=>{
    const user = req.body
    console.log(user)
    try{
        const existingUser = await userDb.loginUser(user);
       
        if (existingUser.message === 'Login successful') {
            res.status(200).json(existingUser);
        } else {
            res.status(401).json(existingUser); // Unauthorized (incorrect password or user not found)
        }

    }catch(error){
        res.status(500).json({ error: `Failed to create user: ${error}` });
    }
    
}

exports.getUserInfo = async(req,res)=>{
    const userId = req.query.userId
    try{
        const userInfo = await userDb.getUserInfo(userId)
        res.status(200).json(userInfo)
    }catch(error){
        res.status(500).json({ error: `No user Found: ${error}` });
    }
    
}