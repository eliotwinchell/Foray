const axios = require('axios')
const mongoose = require('mongoose')
const dotenv = require('dotenv')
const ChargerModel = mongoose.model('ChargerModel')

dotenv.config()

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

db.on('error', console.error.bind(console, 'connection error:'))
db.once('open', function callback() {
  console.log('connected')
  deleteExistingChargers().then(() => {
    fetchNewChargersAndInsert()
  });
});

async function deleteExistingChargers() {
  try {
      await ChargerModel.deleteMany({});
      console.log('All Data successfully deleted');
      
      return Promise.resolve(1)
    } catch (err) {
      console.log(err);
      return Promise.resolve(0)
  }
}

function fetchNewChargersAndInsert() {
  axios.get('https://supercharge.info/service/supercharge/sites', {
    params: {
      length: 4000
    }
  })
  .then(function (response) {
    const chargers = [];
    console.log("get request was successful")
    // handle success
    response.data.results.map(charger => {
      //console.log("Charger Coords (Lat/Long): " + charger.gps.latitude + ", " + charger.gps.longitude)
      const newCharger = new ChargerModel({
        id: charger.id,
        name: charger.name,
        status: charger.status, 
        gps: {
          latitude: charger.gps.latitude,
          longitude: charger.gps.longitude
        },
        stallCount: charger.stallCount,
        powerKilowatt: charger.powerKilowatt
      });

      chargers.push(newCharger);
    });

    ChargerModel.insertMany(chargers)
    .then(function() {
      console.log("inserted data!");

      process.exit();
    })
    .catch(function(error) {
      console.log("error! " + error);
    });
  })
  .catch(function (error) {
    // handle error
    console.log(error)
  })
  .then(function () {
    // always executed
  });

}



