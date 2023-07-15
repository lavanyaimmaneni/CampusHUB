const mongoose = require('mongoose')

const posts = mongoose.Schema({
    postdesc : {
        type : String,
        required : true
    },
    postowner : {
        type : String,
        required : true
    },
    posteddate : {
        type : Date,
        default : Date.now()
    },
    ownerprofile : {
        type : String,
        required : true
    },
    mode : {
        type : String,
        required : true
    }
})

module.exports = mongoose.model('Posts' , posts)