// Current route: /api/chargers
// Test example: /api/chargers?topLeftBounds=-1.00,1.00&bottomRightBounds=1.00,-1.00
require('express');

function getChargers() {
  const router = express.Router()
  router.get('', chargersInBounds(req, res))

  return router
}

async function chargersInBounds(req, res) {
  const boundingCoords = {
    topLeftBounds: req.query.topLeftBounds,
    bottomRightBounds: req.query.bottomRightBounds
  }

  // Perform Geospatial query for chargers in this rectangular bounds from MongoDB

  // Put chargers in array

  // Send chargers back



  res.send(sum.toString())
}

// export { getMathRoutes }