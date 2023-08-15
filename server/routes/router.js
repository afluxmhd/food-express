const express = require('express')
const controller = require('../controller/controller.js')
const authController = require('../controller/auth_controller.js')
const orderController = require('../controller/order_controller.js')
const popularFoodController = require('../controller/popular_food_controller.js')
const userController = require('../controller/user_controller.js')

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
route.post('/api/products/popular',popularFoodController.addPopularProduct)

/**
 * @description Delete Popular Food
 * @method DELETE/
 */
route.delete('/api/products/popular/:productId',popularFoodController.deletePopularProduct)

/**
 * @description Retrieve all Popular Foods
 * @method GET/
 */
route.get('/api/products/popular',popularFoodController.getPopularProductList)

/**
 * @description Register a new user
 * @method POST/
 */
route.post('/api/auth/register',authController.registerUser)

/**
 * @description Login a new user
 * @method POST/
 */
route.post('/api/auth/login',authController.loginUser)

/**
 * @description Retrieve a user info
 * @method GET/
 */
route.get('/api/user/info',userController.getUserInfo)


/**
 * @description create a new order
 * @method POST/
 */
route.post('/api/orders',orderController.createOrder)


/**
 * @description Retrieve all orders of a user
 * @method GET/
 */
route.get('/api/orders/:id',orderController.getOrders)
module.exports = route;





