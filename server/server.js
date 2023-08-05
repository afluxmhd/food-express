const express = require('express')
const dotenv = require('dotenv')
const morgan = require('morgan')
const bodyparser = require('body-parser')
const connectDB = require('./database/connection')

dotenv.config({path:'config.env'})
const app = express()


const PORT = process.env.PORT
app.use(morgan('tiny'))
connectDB()


app.use(bodyparser.json())

app.use('/',require('./routes/router.js'))

app.listen(PORT,()=>{
    console.log(`Server is running on http://localhost:${PORT}`)
})

