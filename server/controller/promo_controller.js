const  { promoDb } = require('../database/database')


exports.createPromo = async (req,res)=>{
    const promo = req.body
    try{
        const savedPromo = await promoDb.createPromo(promo)
        res.status(200).json(savedPromo)
    }catch(error){
          res.status(500).json({ error: `Failed to create Promo code: ${error} `})  
    }
}

exports.getAllPromo=async (req,res)=>{
    try{
      const allPromocodes = await promoDb.getAllPromo()
      res.status(200).json(allPromocodes)
    }catch(error){
        res.status(500).json({error: `Failed to retrieve Promo code: ${error} `})
    }
}

exports.updatePromo = async (req,res)=>{
    const promo = req.body
    const promoCode = promo.code

    try{
        const updatedPromo = await promoDb.updatePromo(promoCode,promo)
        if(updatedPromo.message == 'Promo code not exist!'){
            res.status(404).json(updatedPromo)
        }else{
            res.status(200).json(updatedPromo)
        }
    }catch(error){
        res.status(500).json({ error: `Failed to update Promo Code: ${error} `})

    }
}

exports.deletePromo = async (req,res)=>{
    const promoCode = req.params.promoCode

    try{
        const deletedPromo = await promoDb.deletePromo(promoCode)

        if(deletedPromo.message == 'Promo code not exist!'){
            res.status(404).json(deletedPromo)
        }else{
            res.status(200).json(deletedPromo)
        }


    }catch(error){
        res.status(500).json({ error: `Failed to delete Promo Code: ${error}`})
    }

}