// Current route: /api/chargers
// Test example: /api/chargers?topLeftBounds=-1.00,1.00&bottomRightBounds=1.00,-1.00
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv')
dotenv.config();

function getChargers() {
  const router = express.Router()
  router.get('', chargersInBounds);

  return router
}

async function chargersInBounds(req, res) {
  const lat = req.query.lat;
  const lng = req.query.lng;

  // Perform Geospatial query for chargers in this rectangular bounds from MongoDB

  // Put chargers in array

  // Send chargers back



  res.send("hey there")
}

module.exports.getChargers = getChargers;