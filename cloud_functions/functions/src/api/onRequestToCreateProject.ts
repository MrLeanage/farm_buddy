import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

export const onRequestToCreateProject = functions.https.onRequest(
    (request, response) => {

        const requestData = request.body;
        let projectData: any = {
            "projectName": requestData.name,
            "cropID": requestData.cropID,
            "uID" : requestData.uID
        };
        if (request.method === 'POST') {
            if (requestData?.name && requestData?.cropID && requestData?.uID) {
                const db = admin.firestore();

                db.collection('projects')
                    .add(projectData)
                    .then((docResponse) => {
                        response.status(200).send({result : 'Project successfully created', docReference : docResponse});
                    }).catch((error) => {
                    console.error('Failed to create document in project collection. Error => %s', error);
                    response.status(500).send({result: "Server error occurred"});
                })

            } else {
                response.status(400).send({result: "Bad request"});
            }
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);