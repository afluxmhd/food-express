const express = require('express')
const controller = require('../controller/controller.js')

const route = express.Router()

//API
/**
 * @description Root Route
 * @method GET/
 */
route.get('/',controller.homeRoute)

/**
 * @description Add Popular Food
 * @method POST/
 */
route.post('/api/products/popular',controller.addPopularProduct)

/**
 * @description Delete Popular Food
 * @method DELETE/
 */
route.delete('/api/products/popular/:productId',controller.deletePopularProduct)

/**
 * @description Retrieve all Popular Foods
 * @method GET/
 */
route.get('/api/products/popular',(controller.getPopularProductList))

/**
 * @description Register a new user
 * @method POST/
 */
route.post('/api/auth/register',controller.registerUser)

/**
 * @description Login a new user
 * @method POST/
 */
route.post('/api/auth/login',controller.loginUser)

/**
 * @description Retrieve a user info
 * @method GET/
 */
route.get('/api/user/info',controller.getUserInfo)

module.exports = route;





