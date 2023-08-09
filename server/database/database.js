var OrderModel = require('../model/order_model')
var productModel = require('../model/product_model')


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
        console.log('Received order:', order);
        const newOrder = new OrderModel(order);
        const savedOrder = await newOrder.save();
        console.log('Saved order:', savedOrder);
        return savedOrder;
    } catch (err) {
        throw err;
    }
}

async function getOrders(userId){

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
};
