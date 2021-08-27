import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

export const onAPITest = functions.https.onRequest(
    (request, response) => {
        const cropList: {}[] = [];

        if (request.method === 'POST') {
            const db = admin.firestore();
            db.collection('crops')
                .where('status', '==', true)
                .get()
                .then((snap) => {
                    snap.forEach((doc) => {
                        const cropData: any = doc.data();
                        cropList.push({
                            cropId: cropData.cropId,
                            name: cropData.name,
                            imageURL: cropData.imageURL,
                            description: cropData.description,
                            type: cropData.type,
                            lifeSpan: cropData.lifeSpan,
                            plantingStateList: cropData.plantingStateList,
                            seasonList: cropData.seasonList
                        });
                    });
                    response.status(200).send(cropList);
                }).catch((error) => {
                console.error('Failed to retrieve documents from crops collection. Error => %s', error);
                response.status(500).send({result: "Server error occurred"});
            });
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);