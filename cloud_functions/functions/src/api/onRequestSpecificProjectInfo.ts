import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

export const onRequestSpecificProjectInfo = functions.https.onRequest(
    (request, response) => {
        let projectData: any = {};
        const requestData = request.body;

        if (request.method === 'POST') {
            if (requestData?.projectID) {
                const db = admin.firestore();
                db.collection('projects')
                    .doc(requestData?.projectID)
                    .get()
                    .then((doc) => {
                        projectData = doc.data();
                        response.status(200).send(projectData.plantProjectData);

                    }).catch((error) => {
                    console.error('Failed to retrieve documents from project collection. Error => %s', error);
                    response.status(500).send({result: "Server error occurred"});
                });

            } else {
                response.status(400).send({result: "Bad request"});
            }
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);