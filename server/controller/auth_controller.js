const {userDb}= require('../database/database')

exports.registerUser = async(req,res)=>{
    const user = req.body
    console.log(user)
    try {
        const newUser = await userDb.registerUser(user);

        if (newUser && newUser.message) {
            res.status(409).json(newUser); 
        } else {
            res.status(200).json(newUser); // Registration successful
        }
    } catch (error) {
        res.status(500).json({ error: `Failed to create user: ${error}` });
    }
}

exports.loginUser = async(req,res)=>{
    const user = req.body
    console.log(user)
    try{
        const existingUser = await userDb.loginUser(user);
       
        if (existingUser.message === 'Login successful') {
            res.status(200).json(existingUser);
        } else {
            res.status(401).json(existingUser); // Unauthorized (incorrect password or user not found)
        }

    }catch(error){
        res.status(500).json({ error: `Failed to create user: ${error}` });
    }
    
}