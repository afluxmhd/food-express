const {userDb} = require('../database/database')


exports.getUserInfo = async(req,res)=>{
    const userId = req.query.userId
    try{
        const userInfo = await userDb.getUserInfo(userId)
        res.status(200).json(userInfo)
    }catch(error){
        res.status(500).json({ error: `No user Found: ${error}` });
    }
}


exports.updateUserInfo=async(req,res)=>{
    const user = req.body
    const userId = req.params.id
    try{
        const updateUser = await userDb.updateUserInfo(userId,user)
        res.status(200).json(updateUser)
    }catch(error){
        res.status(500).json({error: `Failed to update an user:  ${error}`})
    }
}