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

async function getOrders(userId){


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

        console.log(existingUser.password)
        console.log(existingUser.password)

       
        if(!user){
            return { message: 'User with this email not exist.' }
        }else{
           if(existingUser.password == user.password ){
            return { message: 'Login successful' ,token: 'FX012323hGhd#24'};
           }else{
            return { message: 'Incorrect password' };
           }
        }

    }catch(err){
        throw err
    }
}

const userDb={
    registerUser,
    loginUser
}

const orderDb={
    addOrder,
    getOrders,
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
