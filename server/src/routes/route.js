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
  router.post('', route);

  return router
}

// POST: 123.09.420.101:8000/api/mapRoute?start=0.0,0.0&?end=1.0,1.0&?batteryRangeLeft
async function route(req, res) {
  const startCoords = req.body.startCoords;
  const endCoords = req.body.endCoords;
  const batteryRange = req.body.batteryRange;
  const dotenv = require('dotenv')

  dotenv.config()
 
  const client = new Client({})

  client
    .distancematrix({
        params: {
            origins: [startCoords[0].toString() + "," + startCoords[1].toString()], //Accepts String of coords
            destinations: [endCoords[0].toString() + "," + endCoords[1].toString()], 
            travelMode: 'DRIVING',
            unitSystem: google.maps.UnitSystem.IMPERIAL
            // is the key include with with the dotenv.config() call? Can't find Monogo URL example
        }
    })

    .then((r) => {
        console.log(r.data.results[0].distancematrix); // what is this indexing?
      })
      .catch((e) => {
        console.log(e.response.data.error_message);
      });    
    
    if (response.distance < batteryRange) { // Does this need to move into the above function?
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
      // if {}
      //findRoute(data)
  });


async function findRoute(chargers) {

}

module.exports.getRoute = getRoute;