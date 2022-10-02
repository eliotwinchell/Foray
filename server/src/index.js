const express = require('express');
const dotenv = require('dotenv');
const routes = require('./routes/index');
const bodyParser = require('body-parser');
const app = express();

dotenv.config();

const port = process.env.PORT;
app.use(bodyParser.json());
app.use('/api', routes.getRoutes());

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
