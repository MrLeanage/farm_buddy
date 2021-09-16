import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import * as utility from '../utils/Utility'

export const onRequestViableCropList = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        const yalaSeasonStartMonth: number = 1;
        const yalaSeasonEndMonth: number = 6;
        // const mahaSeasonStartMonth: number = 1;
        // const mahaSeasonEndMonth: number = 1;
        let currentSeason: string = 'MAHA';
        //let viableCropPrediction: any;
        const viableCropList: {}[] = [];

        if (request.method === 'POST' && requestData?.geoLocation?.state && requestData?.geoLocation?.longitude && requestData?.geoLocation?.latitude) {
            const deviceMonth = parseInt(utility.convertTimeStampToDate(new Date()));
            if (deviceMonth >= yalaSeasonStartMonth && deviceMonth <= yalaSeasonEndMonth)
                currentSeason = 'YALA';
                    const db = admin.firestore();
                    db.collection('crops')
                        .where('plantingStateList', 'array-contains', requestData?.geoLocation?.state)
                        .where('seasonList.' + currentSeason, '==', true)
                        .where('status', '==', true)
                        .get()
                        .then((snap) => {
                            snap.forEach((doc) => {
                                const cropData: any = doc.data();
                                console.log("Crop Object : "+cropData.cropID)
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
                                    cropID: cropData.cropID,
                                    name: cropData.name,
                                    imageURL: cropData.imageURL,
                                    description: cropData.description,
                                    initialization: {
                                        place :{
                                            id: cropData.placeSelection.pSID,
                                            name: cropData.placeSelection.pSName

                                        }
                                    },
                                    lifeSpan: cropData.lifeSpan,
                                    cropNote: {
                                        noteStatus: noteStatus,
                                        noteMessage: noteMessage
                                    },

                                });
                            });
                            response.status(200).send(viableCropList);
                        }).catch((error) => {
                        console.error('Failed to retrieve documents from crops collection. Error => %s', error);
                        response.status(500).send({
                            actionStatus : false,
                            result: "Server error occurred"});
                    });
        } else {
            response.status(400).send({
                actionStatus : false,
                result: "Bad request"});
        }
    }
);