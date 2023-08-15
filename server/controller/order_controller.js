const {userDb,orderDb}=require('../database/database')
const {sendPushNotification} = require('../services/notification_service')


exports.createOrder = async(req,res)=>{
    const order = req.body
    try{
       const savedOrder = await orderDb.addOrder(order)

       const userId = order.userId
       const userInfo = await userDb.getUserInfo(userId)
       const fcmToken = userInfo.fcmToken

       await sendPushNotification(fcmToken,'Order Placed!',`Your order (Order ID: ${savedOrder._id}) has been successfully placed`)

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