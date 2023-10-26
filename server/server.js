const express = require('express')
const dotenv = require('dotenv')
const morgan = require('morgan')
const bodyparser = require('body-parser')
const connectDB = require('./database/connection')
const initializeFirebase = require('./config/firebase_config')

dotenv.config({path:'config/config.env'})
const app = express()

initializeFirebase()


const PORT = process.env.PORT
app.use(morgan('tiny'))
connectDB()


app.use(bodyparser.json())

app.use('/',require('./routes/router.js'))

app.listen(PORT,()=>{
    console.log("Server is running on https://food-express-server-ndhc.onrender.com")
})

