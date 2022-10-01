const express = require('express');
const mongoose = require('mongoose');
const { getChargers } = require('./chargers');

if (process.env.NODE_ENV == 'production') {
  mongoose.connect(
    'mongodb+srv://doadmin:736c0q2X814bZSFw@statistics-mongodb-9e65cf54.mongo.ondigitalocean.com/keychainfortesla?authSource=admin&replicaSet=statistics-mongodb&tls=true&tlsCAFile=' + process.env.CA_MONGO_CERT
  )
} else {
  mongoose.connect(
    'mongodb://127.0.0.1:27017/keychainfortesla'
  )
}

const db = mongoose.connection;

function getRoutes() {
  const router = express.Router()

  router.use('/chargers', getChargers())

  return router
}

exports.getRoutes = getRoutes;
