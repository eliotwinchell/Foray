// 'use strict';

// require('dotenv').config();

// const fs = require('fs');
// const join = require('path').join;
// const express = require('express');
// const mongoose = require('mongoose');
// const passport = require('passport');

// const models = join(__dirname, 'src/models');
// const port = process.env.PORT || 3000;
// const app = express();

// /**
//  * Expose
//  */

// module.exports = app;

// // Bootstrap models
// fs.readdirSync(models)
//   .filter(file => ~file.search(/^[^.].*\.js$/))
//   .forEach(file => require(join(models, file)));

// connect();

// function listen() {
//   if (app.get('env') === 'test') return;
//   app.listen(port);
//   console.log('Express app started on port ' + port);
// }

// function connect() {
//   mongoose.connection
//     .on('error', console.log)
//     .on('disconnected', connect)
//     .once('open', listen);
//   return mongoose.connect(process.env.MONGO_URL, {
//     keepAlive: 1,
//     useNewUrlParser: true,
//     useUnifiedTopology: true 
//   });
// }