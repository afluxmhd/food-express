var OrderModel = require('../model/order_model')
var productModel = require('../model/product_model')
const UserModel = require('../model/user_model')


async function addPopularProduct (product){
    try{
        const newProduct = new productModel(product)
        const savedProduct = await newProduct.save() 
        return savedProduct
    }catch(err){
        throw err
    }
}

async function deletePopularProduct (productId){
    try{
        const deletedProduct =  productModel.findByIdAndDelete(productId)
        return deletedProduct
    }catch(err){
        throw err
    }
}

async function getPopularProductList (){
    try{
        const products = productModel.find()
        return products
    }catch(err){
        throw err
    }
}

async function addOrder(order){
    try {
        const newOrder = new OrderModel(order);
        const savedOrder = await newOrder.save();
        return savedOrder;
    } catch (err) {
        throw err;
    }
}

async function updateOrder(orderId,newStatus){
    try{
        const existingOrder = await OrderModel.findOne({orderId : orderId})

        if(!existingOrder){
            return { message: 'Order ID with this Order is not exist' }
        }
        if(existingOrder.status==newStatus){
            return { message: `Order status is already ${newStatus}` };
        }

        existingOrder.status=newStatus
        await existingOrder.save()

        return { message: `Order status updated to ${newStatus} successfully` };
    }catch(err){
        throw err
    }
}

async function getOrders(userId){
    try{
        const orders = OrderModel.find({userId : userId}).populate('products.productId').exec();
        return orders
    }catch(err){
        throw err
    }

}

async function registerUser(user){
    try{
        const existingUser = await UserModel.findOne({ email: user.email });

        if(existingUser){
            return { message: 'User with this email already exists.' }
        }
        const newUser = new UserModel(user)
        const savedUser = await newUser.save()
        return savedUser
    }catch(err){
        throw err
    }
}

async function loginUser(existingUser){
    try{
        const user = await UserModel.findOne({ email: existingUser.email });
       
        if(!user){
            return { message: 'User with this email not exist.' }
        }else{
           if(existingUser.password == user.password ){

            if(existingUser.fcmToken) {
                user.fcmToken = existingUser.fcmToken;
                await user.save(); // Save the updated user with the new fcmToken
            }

            return { message: 'Login successful' ,token: 'FX012323hGhd#24', userId : user._id,fcmToken : user.fcmToken};
           }else{
            return { message: 'Incorrect password' };
           }
        }

    }catch(err){
        throw err
    }
}


async function getUserInfo(userId){
    try{
        const userInfo = await UserModel.findOne({ _id: userId });
       return userInfo
    }catch(err){
        throw err
    }
}

const userDb={
    registerUser,
    loginUser,
    getUserInfo,
}

const orderDb={
    addOrder,
    getOrders,
    updateOrder,
}

const productDb = {
    addPopularProduct,
    getPopularProductList,
    deletePopularProduct
  };

module.exports = {
    orderDb,
    productDb,
    userDb
};
