const express = require('express')
const mongoose = require('mongoose')
const users = require('../models/users')
const posts = require('../models/post')

// const { route } = require('express/lib/application')

const router = express.Router()

router.post('/newpost' , async(req,res) => {
    try{
        newpost = new posts({
            postdesc : req.body.postdesc,
            postowner : req.body.username,
            mode  : req.body.mode,
            ownerprofile : req.body.ownerprofile
        })
        newpost = await newpost.save()
        res.status(201).json({
            msg : "successfully posted",
            success : true
        })
    }catch(e){
        res.status(400).json({
            error : e,
            success : false
        })
    }
})

router.get('/allposts' , async(req,res) => {
    try{
        const post = await posts.find()
        res.status(200).json({
            "success" : true,
            "posts" : post
        })
    }catch(e){
        console.log(e)
        res.status(400).json({
            success : false,
            error : e
        })
    }
})

router.post('/myposts' , async (req,res) => {
    try{
        const data = await posts.find({
            postowner : req.body.postowner
        })
        res.status(200).json({
            "success" : true,
            "mag" : "reteived",
            data : data
        })
    }catch(e){
        console.log(e)
        res.status(400).json({
            "success" : false,
            "msg" : "error while retrieving", 
        })
    }
})

module.exports = router