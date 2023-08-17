const {userDb,orderDb}=require('../database/database')
const {sendPushNotification} = require('../services/notification_service')


exports.createOrder = async(req,res)=>{
    const order = req.body
    try{
       const savedOrder = await orderDb.addOrder(order)

       const userId = order.userId
       const userInfo = await userDb.getUserInfo(userId)
       const fcmToken = userInfo.fcmToken

       await sendPushNotification(fcmToken,'Order Placed!',`Your order (Order ID: ${savedOrder.orderId}) has been successfully placed`)

       res.status(200).json(savedOrder)
       
    }catch(error){
        res.status(500).json({ error: `Failed to create an order: ${error}`})
    }
}

exports.updateOrder=async(req,res)=>{
    const orderId = req.params.orderId
    const newStatus = req.body.status; 
    try{
        const updateOrder = await orderDb.updateOrder(orderId, newStatus);
        if (updateOrder.message.includes('successfully')) {

            const userId = '64dba34510c47f07d151b0c1'
            const userInfo = await userDb.getUserInfo(userId)
            const fcmToken = userInfo.fcmToken

            await sendPushNotification(fcmToken,'Order Delivered!',`Your order (Order ID: ${orderId}) has been delivered`)
            res.status(200).json(updateOrder);
        } else if (updateOrder.message.includes('already')) {
            res.status(400).json(updateOrder);
        } else {
            res.status(404).json(updateOrder);
        }
    }catch(error){
        res.status(500).json({error: `Failed to update an order: ${error}`})
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