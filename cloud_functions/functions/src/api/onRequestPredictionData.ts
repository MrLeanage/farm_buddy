import * as functions from 'firebase-functions';
import * as rainPredictionReport from '../model/weather/RainPredictionReport';

export const onRequestPredictionData = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        let weatherPredictionForCrops: any;
        if (request.method === 'POST' && requestData?.geoLocation?.longitude && requestData?.geoLocation?.latitude) {

            rainPredictionReport.rainPredictionForPlantSelection(requestData?.geoLocation?.longitude, requestData?.geoLocation?.latitude, 5)
                .then((predictionReport) => {
                    weatherPredictionForCrops = predictionReport;
                    response.status(200).send(weatherPredictionForCrops);


                }).catch((error) => {
                response.status(500).send({
                    actionStatus : false,
                    originatedFrom: 'rain prediction',
                    result: error});
            })
        } else {
            response.status(400).send({
                actionStatus : false,
                result: "Bad request"});
        }
    }
);