var OrderModel = require('../model/order_model')
var productModel = require('../model/product_model')
var UserModel = require('../model/user_model')
var PromoModel = require('../model/promo_model')


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

async function updateUserInfo(userId,user){
    try{
       const existingUser = await UserModel.findOne({ _id: userId });

       if(!existingUser){
         return { message: 'User is not exist'}
       }else{
            const updateUser = await UserModel.findOneAndUpdate({_id: userId},{$set: user},{new: true})
            
            if(updateUser){
                return updateUser
            }else{
                return {message: 'Error updating user'}
            }
       }
    }catch(err){
        throw err
    }
}

async function createPromo(promo){
    try{
        const newPromo =  new PromoModel(promo)
        const savedPromo = await newPromo.save()
        return savedPromo
    }catch(err){
        throw err
    }
}

async function updatePromo(promoCode,promo){
    try{

       const existingPromo = await PromoModel.findOne({code: promoCode})

       if(!existingPromo){
            return { message: 'Promo code not exist!'}
       }else{
        const updatedPromo = await PromoModel.findOneAndUpdate({code: promo.code},promo,{new: true})
        return updatedPromo;
       }
    }catch(err){
        throw err
    }
}

async function deletePromo(promoCode){
    try{
        const existingPromo = await PromoModel.findOne({code: promoCode})

        if(!existingPromo){
            return { message: 'Promo code not exist!'}
        }else{
            const deletedPromo = await PromoModel.findOneAndDelete({code: promoCode})
            return { message: 'Promo Code succesfully deleted!', code: deletedPromo.code}
        }
    }catch(err){
        throw err
    }
}


const promoDb={
    createPromo,
    updatePromo,
    deletePromo
}

const userDb={
    registerUser,
    loginUser,
    getUserInfo,
    updateUserInfo
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
    userDb,
    promoDb
};
