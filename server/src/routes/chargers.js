// Current route: /api/chargers
// Test example: /api/chargers?topLeftBounds=-1.00,1.00&bottomRightBounds=1.00,-1.00
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const chargerSchema = require('../models/charger');

dotenv.config();

const ChargerModel = mongoose.model('Charger', chargerSchema);

function getChargers() {
  const router = express.Router()
  router.get('', chargersInBounds);

  return router
}

// POST: 123.09.420.101:8000/api/chargersWithinBounds
async function chargersInBounds(req, res) {
  const bottomLeftCoords = [req.query.bottomLeftLong, req.query.bottomLeftLat];
  const topRightCoords = [req.query.topRightLong, req.query.topRightLat];

  ChargerModel.find({
    location:{
      $geoWithin:{
        $box: [
          bottomLeftCoords,
          topRightCoords
        ]
      }
    }
  })
  .exec((err, data) => {
      if (err) console.log(err);
      res.send(data);
  });
}

module.exports.getChargers = getChargers;