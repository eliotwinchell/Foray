const mongoose = require('mongoose');

const chargerSchema = new mongoose.Schema({
  id: Number,
  name: String,
  status: String,
  location: {
    type: { type: String },
    coordinates: []
   },
  stallCount: Number,
  powerKilowatt: Number
})

chargerSchema.index({ location: "2dsphere" });

module.exports = chargerSchema;