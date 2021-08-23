import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import * as utility from '../utils/utility';
import * as rainPredictionReport from '../prediction/RainPredictionReport';

export const onRequestViableCropList = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        const yalaSeasonStartMonth: number = 1;
        const yalaSeasonEndMonth: number = 6;
        // const mahaSeasonStartMonth: number = 1;
        // const mahaSeasonEndMonth: number = 1;
        let currentSeason: string = 'MAHA';
        const viableCropList: {}[] = [];

        if (request.method === 'POST' && requestData?.geoLocation?.state && requestData?.geoLocation?.longitude && requestData?.geoLocation?.latitude && requestData?.monthOfYear >= 1 && requestData?.monthOfYear <= 12) {
            const deviceMonth = parseInt(requestData?.monthOfYear);
            if (deviceMonth >= yalaSeasonStartMonth && deviceMonth <= yalaSeasonEndMonth)
                currentSeason = 'YALA';

            rainPredictionReport.rainPredictionForPlantSelection(requestData?.geoLocation?.longitude, requestData?.geoLocation?.latitude, 5)
                .then((predictionReport) => {
                    viableCropList.push({
                        predictionReport: predictionReport
                    });

                    const db = admin.firestore();
                    db.collection('crops')
                        .where('plantingStateList', 'array-contains', requestData?.geoLocation?.state)
                        .where('seasonList.' + currentSeason, '==', true)
                        .where('status', '==', true)
                        .get()
                        .then((snap) => {
                            snap.forEach((doc) => {
                                const cropData: any = doc.data();
                                let noteStatus: boolean;
                                let noteMessage: String;
                                if (utility.getSeasonalMonthNumber(deviceMonth) <= 3) {
                                    noteStatus = true;
                                    noteMessage = "You can Start planting this crop"
                                } else {
                                    noteStatus = false;
                                    noteMessage = "You are already on late " + currentSeason + " season, cannot Start planting this crop!"
                                }
                                viableCropList.push({
                                    cropId: cropData.cropId,
                                    name: cropData.name,
                                    imageURL: cropData.imageURL,
                                    description: cropData.description,
                                    type: cropData.type,
                                    lifeSpan: cropData.lifeSpan,
                                    cropNote: {
                                        noteStatus: noteStatus,
                                        noteMessage: noteMessage
                                    },
                                    //predictionReport : predictionReport
                                });
                            });
                            response.status(200).send(viableCropList);
                        }).catch((error) => {
                        console.error('Failed to retrieve documents from crops collection. Error => %s', error);
                        response.status(500).send({result: "Server error occurred"});
                    });

                }).catch((error) => {
                response.status(500).send({originatedFrom: 'rain prediction', result: error});
            })
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);