const mongoose = require('mongoose')

const { Schema } = mongoose

const UserSchema = new Schema({
    fullName: { type: String, required: true },
    phoneNumber: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    city: { type: String },
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now },
  });

  const UserModel = mongoose.model('User',UserSchema)
  module.exports=UserModel