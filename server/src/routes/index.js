const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv')
const { getChargers } = require('./chargers');

dotenv.config();

if (process.env.NODE_ENV == 'production') {
  mongoose.connect(process.env.MONGO_URL)
} else {
  mongoose.connect('mongodb://127.0.0.1:27017/foray')
}

const db = mongoose.connection;

function getRoutes() {
  const router = express.Router()

  router.use('/chargersWithinBounds', getChargers())

  return router
}

module.exports.getRoutes = getRoutes;
