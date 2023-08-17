const mongoose = require('mongoose');
const { Schema } = mongoose;

const OrderSchema = new Schema({
  orderId:{type: String, required: true},
  userId: { type: mongoose.Types.ObjectId, ref: 'User', required: true },
  products: [
    {
      productId: { type: mongoose.Types.ObjectId, ref: 'Product', required: true },
      quantity: { type: Number, required: true }
    }
  ],
  totalAmount: { type: Number, required: true },
  totalQuantity: { type: Number, required: true },
  status: { type: String, required: true },
  createdAt: { type: String, required: true },
  updatedAt: { type: String, },
});

const OrderModel = mongoose.model('Order', OrderSchema);

module.exports = OrderModel;