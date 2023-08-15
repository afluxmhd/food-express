const {productDb}=  require('../database/database')



exports.addPopularProduct = async(req,res)=>{
    const productData = req.body
    try {
        const savedProduct = await productDb.addPopularProduct(productData);
        // Send success response
        res.status(201).json(savedProduct);
      } catch (error) {
     
       res.status(500).json({ error: `Failed to add product: ${error}` });
      }

}

exports.deletePopularProduct = async(req,res)=>{
    const productId = req.params.productId;
    try {
        const deletedProduct = await productDb.deletePopularProduct(productId);
        // Send success response
        res.status(200).json({ message: 'Product deleted successfully.', deletedProduct });
      } catch (error) {
     
       res.status(500).json({ error: `Failed to add product: ${error}` });
      }

}

exports.getPopularProductList = async(req,res)=>{
    try{
        const products = await productDb.getPopularProductList()
        res.status(200).json(products)
    }catch(error){
        res.status(500).json({ error: `Failed to add product: ${error}` });
    }
    
}