const mongoose = require('mongoose');
const { Schema } = mongoose;

const OrderSchema = new Schema({
  userId: { type: mongoose.Types.ObjectId, ref: 'User', required: true },
  popularFoods: [{ type: mongoose.Types.ObjectId, ref: 'PopularFood' }],
  totalAmount: { type: Number, required: true },
  totalQuantity: { type: Number, required: true },
  status: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

const OrderModel = mongoose.model('Order', OrderSchema);

module.exports = OrderModel;