const express = require('express')
const adminRouter = express.Router();
const admin = require('../middleware/admin')
const {Product} = require('../models/product')
const Order = require('../models/order')
adminRouter.post('/admin/add-product',admin, async (req,res)=>{
    try {
        const {name, description, images, quantity, price, category} = req.body
        let product =new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        })
        product = await product.save()
        res.json(product)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})
adminRouter.get('/admin/get-product', admin, async (req,res)=>{
    try {
        const products = await Product.find({})
        res.json(products)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})
adminRouter.post('/admin/delete-product', admin , async(req,res)=>{
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id)
        res.json(product)
    } catch (e) {
        console.log(e.message);
        res.status(500).json({error: e.message})
    }
})
adminRouter.get('/admin/get-orders', admin, async (req,res)=>{
    try {
        const orders = await Order.find({})
        res.json(orders)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})
adminRouter.post('/admin/change-order-status', admin, async (req,res)=>{
    try {
        const {id, status} = req.body
        let order = await Order.findById(id)
        order.status = status
        order = await order.save()
        res.json(order)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})
adminRouter.get('/admin/analytics', admin, async (req,res)=>{
    try {
        const orders = await Order.find({})
        let totalEarnings = 0;
        for (let i = 0; i < orders.length; i++) {
            for (let l = 0; l < orders[i].products.length; l++) {
                totalEarnings += orders[i].products[l].quantity * orders[i].products[l].product.price
            }
        }
        let mobileEarnings = await fetchCategoryWiseProducts('Mobiles')
        let essentialsEarnings = await fetchCategoryWiseProducts('Essentials')
        let appliancesEarnings = await fetchCategoryWiseProducts('Appliances')
        let booksEarnings = await fetchCategoryWiseProducts('Books')
        let fashionEarnings = await fetchCategoryWiseProducts('Fashion')
        let earnings = {
            totalEarnings,mobileEarnings,essentialsEarnings,appliancesEarnings,booksEarnings,fashionEarnings
        }
        res.json(earnings)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})
async function fetchCategoryWiseProducts(category){
    let earnings = 0
    let categoryOrders = await Order.find({'products.product.category': category})
    for (let i = 0; i < categoryOrders.length; i++) {
        for (let l = 0; l < categoryOrders[i].products.length; l++) {
            earnings += categoryOrders[i].products[l].quantity*categoryOrders[i].products[l].product.price
        }
    }
    return earnings
}
module.exports = adminRouter