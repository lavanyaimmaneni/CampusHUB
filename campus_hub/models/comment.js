const mongoose = require('mongoose')

const comments = mongoose.Schema({
    commentdesc : {
        type : String,
        required : true
    },
    commentowner : {
        type : String,
        required : true
    },
    postid : {
        type : mongoose.Schema.Types.ObjectId,
        required : true
    },
    ownerprofile : {
        type : String,
        required : true
    },
    posteddate : {
        type : Date,
        default : Date.now()
    },
    upvotes : {
        type : Number,
        default : 0
    },
    downvotes : {
        type : Number,
        default : 0
    },
})

module.exports = mongoose.model('Comments' , comments)