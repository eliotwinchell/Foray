const express = require('express');
const dotenv = require('dotenv');
const routes = require('./routes/index');
const app = express();

dotenv.config();

const port = process.env.PORT;

app.use('/api', routes.getRoutes());

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
