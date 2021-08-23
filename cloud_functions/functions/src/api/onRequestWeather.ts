import * as functions from 'firebase-functions';
import * as utility from '../utils/utility'
//import * as rainPredictionReport from '../prediction/RainPredictionReport';
// const axios = require('axios');

export const onRequestWeather = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        if(requestData?.longitude && requestData?.latitude){
            utility.getWeatherData(requestData?.longitude, requestData?.latitude, 5)
                .then((weatherObj) => response.status(200).send(weatherObj.data))
                .catch((error) => response.status(500).send(error))
        }else {
            response.status(400).send({result: "Bad request"});
        }
        // const baseURL: string = 'https://atlas.microsoft.com/weather/forecast/daily/json?api-version=1.0&';
        // const query: string = 'query=' + '47.641268' + '%2C' + '-122.125679' + '&duration=' + 5 + '&';
        // const subscription_key: string = 'subscription-key=ETPQmOJLe4eyTAzAM7UZiSiD2LI6w-45cfguWFdMUSI'
        // axios.get(baseURL + query + subscription_key).then()
    });