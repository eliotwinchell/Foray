// Current route: /api/chargers
// Test example: /api/chargers?topLeftBounds=-1.00,1.00&bottomRightBounds=1.00,-1.00
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const chargerSchema = require('../models/charger');
const {Client} = require("@googlemaps/google-maps-services-js");
const { response } = require('express');


dotenv.config();

const ChargerModel = mongoose.model('Charger', chargerSchema);

function getRoute() {
  const router = express.Router()
  router.post('', chargersInBounds);

  return router
}

// POST: 123.09.420.101:8000/api/mapRoute?start=0.0,0.0&?end=1.0,1.0&?batteryRangeLeft
async function chargersInBounds(req, res) {
  const startCoords = req.body.startCoords;
  const endCoords = req.body.endCoords;
  const batteryRange = req.body.batteryRange;
 
  const service = new google.maps.DistanceMatrixService();
  const matrixOptions = {
    origins: [startCoords[0].toString() + "," + startCoords[1].toString()], //Accepts String of coords
    destinations: [endCoords[0].toString() + "," + endCoords[1].toString()], 
    travelMode: 'DRIVING',
    unitSystem: google.maps.UnitSystem.IMPERIAL
  };

  service.getDistanceMatrix(matrixOptions, callback);

  function callback(response, status) {
    if (status !== "OK") {
      alert("Error with distance matrix");
      return;
    }
    console.log(response);     
    
    if (response.distance < batteryRange) {
      //res.send(polyline);

    }
  }



  
  // Call Google Maps Platform, check distance with Maps Distance Matrix API
  
  // if distance (endCoords - startCoords) < batteryRange {
  //   return path, which we get from google maps again
  //} else {
  //   findChargersWithinBox (startCoords, endCoords) are bounds
  //}
  
  console.log("endpoint hit");
  console.log(topRightCoords);

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
      if 
      //findRoute(data)
  });
}

async function findRoute(chargers) {

}

module.exports.getChargers = getChargers;