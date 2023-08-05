
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

const db = {
    addPopularProduct,
    getPopularProductList,
    deletePopularProduct
  };

module.exports = db