const express = require('express')
const mongoose = require('mongoose')
const users = require('../models/users')
const e = require('express')
// const { route } = require('express/lib/application')

const router = express.Router()

router.get('/users' , async (req,res) => {
    // console.log("request recvd")
    data = await users.find()
    res.send(data)
}),

router.post('/signin' , async(req,res) => {
    try
    {
        data = await users.find({username : req.body.username , password : req.body.password})
        // console.log(data)
        if(data.length == 0)
        {
            res.status(200).json({
                msg : "Invalid credentials",
                success : false
            })
        }
        else
        {
            res.status(200).json({
                msg : "Invalid credentials",
                success : true,
                data : data
            })
        }
    }catch(e){
        console.log(e)
        res.status(500).json({
            msg : "error while signing",
            success : true
        })
    }
})

router.post('/createuser' , async (req,res) => {
    // console.log("request received")
    try{
        data = await users.find({username : req.body.username})
        if(data.length != 0)
        {
            res.status(200).json({
                success : false,
                msg : "username already taken"
            })
        }
        else
        {
            newuser = new users({
                username : req.body.username,
                email    : req.body.email,
                password : req.body.password,
                role     : req.body.role,
                profilepic : req.body.profilepic
            })
            newuser = await newuser.save()
            res.status(200).json({
                success : true,
                msg : "signup done"
            })
        }
    }catch(e){
        console.log(e)
        res.status(200).json({
            success : false,
            msg : "error while signing up"
        })
    }
     
})

module.exports = router