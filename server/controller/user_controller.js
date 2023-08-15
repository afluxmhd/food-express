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

