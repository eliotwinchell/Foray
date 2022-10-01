const mongoose = require('mongoose');

const chargerSchema = new mongoose.Schema({
  id: Number,
  name: String,
  status: String,
  gps: {
    latitude: Number,
    longitude: Number
  },
  stallCount: Number,
  powerKilowatt: Number
})

module.exports = chargerSchema;