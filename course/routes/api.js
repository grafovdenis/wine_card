const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');
const sequelize = require('sequelize');
const db = new sequelize(
    'wine_card', 'postgres', '1234', {
        host: 'localhost',
        dialect: 'postgres'
    }
);

const models = "../models";
const root = path.dirname(require.main.filename);
fs.readdirSync(`${root}/${models}`).forEach((model) => global[model.substr(0, model.length - 3)] = db.import(`${root}/${models}/${model}`));
console.log("Models imported successfully!");

/* GET users listing. */
router.get('/', function (req, res, next) {
    res.send('respond with a resource');
});

router.get('/all_drinks', async function (req, res, next) {
    const result = await drinks.findAll(
        {order: ['drink_id']}
    );
    res.set('Access-Control-Allow-Origin', '*');
    res.json(result);
});

router.get('/components', async function (req, res, next) {
    const drink_id = req.query.drink_id;
    const result = await db.query(`select c.*
                                   from components c
                                            join components_drinks cd on cd.component_id = c.component_id
    where cd.drink_id = '${drink_id}'`);
    res.set('Access-Control-Allow-Origin', '*');
    res.json(result[0]);
});

router.get('/places', async function (req, res, next) {
    const drink_id = req.query.drink_id;
    const result = await db.query(`select p.*
                                   from places p
                                            join places_drinks pd on pd.place_id = p.place_id
    where pd.drink_id = '${drink_id}'`);
    res.set('Access-Control-Allow-Origin', '*');
    res.json(result[0]);
});

router.post('/edit_drink', async function (req, res) {
    const title = req.query.title;
    const volume = req.query.volume;
    const rating = req.query.rating;
    const alcohol = req.query.alcohol;
    const average_price = req.query.average_price;
    const drink_type = req.query.drink_type;

    drinks.update({
        title: title,
        volume: volume,
        rating: rating,
        alcohol: alcohol,
        average_price: average_price,
        drink_type: drink_type
    }, {
        returning: true,
        where: {drink_id: req.query.drink_id}
    }).then(res.end("Update successful!")).catch(function (err) {
        res.end("Update failed!")
    });
});

router.delete('/delete_drink', async function (req, res) {
    drinks.destroy({
        where: {drink_id: req.query.drink_id}
    }).then(res.end("Delete successful!")).catch(function (err) {
        res.end("Delete failed!")
    })
});

router.post('/new_drink', async function (req, res) {
    const title = req.query.title;
    const volume = req.query.volume;
    const rating = req.query.rating;
    const alcohol = req.query.alcohol;
    const average_price = req.query.average_price;
    const drink_type = req.query.drink_type;

    drinks.create({
        title: title,
        volume: volume,
        rating: rating,
        alcohol: alcohol,
        average_price: average_price,
        drink_type: drink_type
    }).then(res.end("Insert successful!")).catch(function (err) {
        res.end("Insert failed!")
    });
});

module.exports = router;