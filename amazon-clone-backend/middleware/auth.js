const jwt = require('jsonwebtoken')
const auth = async (req,res, next)=>{
    try{
        const token = req.header("x-auth-token")
        if(!token){
            return res.status(401).json({msg: 'No auth token. Access denied,'})
        }
        const isVerified = jwt.verify(token, 'passkey')
        if(!isVerified) return res.status(401).json({msg: 'Token Verification Failed'})
        req.user = isVerified.id;
        req.token = token
        next();
        
    } catch(err){
        res.status(500).json({error: err.message})
    }
}
module.exports = auth