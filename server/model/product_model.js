const mongoose = require('mongoose');
const { Schema } = mongoose;

const productSchema = new Schema({
  productId: { type: Number, required: true },
  name: { type: String, required: true },
  description: { type: String },
  price: { type: Number, required: true },
  img: { type: String },
  rating: { type: Number },
  stars: { type: Number },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

const ProductModel = mongoose.model('Product', productSchema);

module.exports = ProductModel;