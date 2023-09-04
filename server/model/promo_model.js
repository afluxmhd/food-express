const mongoose = require('mongoose')
const { Schema } = mongoose

const promoSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    code:{
        type: String,
        required: true,
        unique: true,
    },
    discountPercentage:{
        type: Number,
        required: true,
        min: 0,
        max: 100,
    },
    isActive:{
        type: Boolean,
        default: true
    }
})

const PromoModel = mongoose.model('Promo',promoSchema)

module.exports = PromoModel