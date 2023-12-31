const mongoose = require('mongoose')

const { Schema } = mongoose

const UserSchema = new Schema({
    fullName: { type: String, required: true },
    phone: { type: String, required: true },
    password: {type: String,required: true},
    email: { type: String, required: true, unique: true },
    city: { type: String },
    fcmToken: {type: String,required: true},
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now },
  });

  const UserModel = mongoose.model('User',UserSchema)
  module.exports=UserModel