const express = require('express')
const comments = require('../models/comment')
const mongoose = require('mongoose')
const router = express.Router()

router.post('/addcomment' , async(req,res)=>{
    // var postid = mongoose.Types.ObjectId(req.body.postid)
    // console.log(req.body.postid)
    try{
        newcomment = comments({
            commentdesc : req.body.commentdesc,
            commentowner : req.body.commentowner,
            ownerprofile : req.body.ownerprofile,
            postid       : mongoose.Types.ObjectId(req.body.postid)
        })
        newcomment = await newcomment.save()
        res.status(200).json({
            msg : "Comment added",
            success : true
        })
    }catch(e){
        console.log(e)
        res.status(400).json({
            success : "false",
            msg : "error try again"
        })
    }
})

router.post('/getcomments' , async (req,res)=>{
    try{
        data = await comments.find({postid : mongoose.Types.ObjectId(req.body.postid)})
        res.status(200).json({
            "msg" : "retrieved",
            "success" : true,
            "data" : data
        })
    }catch(e){
        res.status(400).json({
            "msg" : "error while retreiving",
            "success" : true
        })
    }
})

router.post('/like' , async(req,res) => {
    try{
        data = await comments.findByIdAndUpdate(
            {
                _id : mongoose.Types.ObjectId(req.body.commentid)
            },
            {
                $inc: {upvotes: 1} ,
            },
            {
                new : true
            }
        )
        res.status(200).json({
            "success" : true,
            "msg" : "Liked"
        })
    }catch(e){
        res.status(200).json({
            "success" : false,
            "msg" : "failed to like"
        })
    }
})

router.post('/dislike' , async(req,res) => {
    try{
        data = await comments.findByIdAndUpdate(
            {
                _id : mongoose.Types.ObjectId(req.body.commentid)
            },
            {
                $inc: {downvotes: 1} ,
            },
            {
                new : true
            }
        )
        res.status(200).json({
            "success" : true,
            "msg" : "disliked"
        })
    }catch(e){
        res.status(200).json({
            "success" : false,
            "msg" : "Failed to dislike"
        })
    }
})

module.exports = router