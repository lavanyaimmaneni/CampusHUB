const express = require('express')
const mongoose = require('mongoose')
const app = express()
const cors = require('cors')
require('dotenv').config()

const authrouter = require('./routes/auth')
const postsrouter = require('./routes/posts')
const commentsrouter = require('./routes/comments')
app.listen(5000 , () => console.log('api started'))
app.use(express.urlencoded({extended:false}))
// app.use(errorHandler);
url = process.env.DATABASE_URL
console.log(url)
mongoose.set('strictQuery', false)
app.use(express.json())
try{
    mongoose.connect(url , {useNewUrlParser : true})
}catch(e){
    console.log("error at connecting to dataase")
}
app.use(cors())
const db = mongoose.connection

db.on('error' , (error) => console.error(error))

db.once('open' , () => console.log('connected to db'))
app.get('/' , (req,res) => {
    res.send("Hello bro")
})
app.use('/auth' , authrouter)
app.use('/post' , postsrouter)
app.use('/comment' , commentsrouter)