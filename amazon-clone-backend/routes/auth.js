const express = require('express')
const User = require('../models/user')
const auth = require('../middleware/auth')
const authRouter = express.Router()
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
authRouter.post('/api/signup', async (req,res)=>{
    try{
        const {name, email, password} = req.body
    const existingUser = await User.findOne({ email })
    if(existingUser){
        return res.status(400).json({msg : 'User with same email already exits'})
    }
    const hashedPassword = await bcryptjs.hash(password, 8)
    let user = new User({
        email,
        password: hashedPassword,
        name
    })
    user = await user.save()
    res.json(user)
    } catch(e){
        res.status(500).json({error : e.message})
    }
    
})

authRouter.post('/api/signin', async (req,res)=>{
    try{
        const {email, password} = req.body
        const user = await User.findOne({email})
        if(!user){
            return res.status(400).json({message: 'No user exists with this email'})
        }
        const isMatch = await bcryptjs.compare(password,user.password)
        if(!isMatch){
            return res.status(400).json({message: 'Incorrect Password'})
        }
        const token = jwt.sign({id: user._id}, "passkey")
        res.json({token,...user._doc})
        console.log("logged in");
    } catch(e){
        res.status(500).json({error: e.message})
    }
})

authRouter.post('/tokenisValid', async (req,res)=>{
    try{
        const token = req.header("x-auth-token")
        if(!token) return res.json(false)
        const isVerified = jwt.verify(token, 'passkey')
        if(!isVerified) return res.json(false)
        const user = await User.findById(isVerified.id)
        if(!user) return res.json(false)
        res.json(true)
    } catch(e){
        res.status(500).json({error: e.message})
    }
})

authRouter.get('/', auth, async (req,res) => {
    const user = await User.findById(req.user)
    res.json({...user._doc, token: req.token})
})


module.exports = authRouter
