import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {PlantProjectHandler} from "../model/plant/PlantProjectHandler";

export const onRequestSpecificProjectStageData = functions.https.onRequest(
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
                        const plantProjectHandler : PlantProjectHandler = new PlantProjectHandler(projectData);
                        response.status(200).send(plantProjectHandler.plantProjectData);

                    }).catch((error) => {
                    console.error('Failed to retrieve documents from project Data Collection. Error => %s', error);
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