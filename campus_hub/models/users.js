const mongoose = require('mongoose')

const users = mongoose.Schema({
    username : {
        type : String,
        required : true
    },
    password : {
        type : String,
        required : true
    },
    email : {
        type : String,
        required : true
    },
    profilepic : {
        type : String,
        required : true
    },
    role : {
        type : String,
        required : true
    },
    upvotes : {
        type : mongoose.Schema.Types.Number,
        default : 0
    }
})

module.exports = mongoose.model('Users' , users)