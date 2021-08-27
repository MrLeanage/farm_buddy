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
                    // .where('status', '==', true)
                    .get()
                    .then((doc) => {
                        projectData = doc.data();
                        response.status(200).send(projectData);


                        if (doc.exists) {
                            projectData = doc.data();
                            projectData.stage1.seedlingQuestionList = requestData.stage1.seedlingQuestionList;
                        db.collection('projects').doc(requestData?.projectID).update(projectData).then(() => {
                            response.status(200).send({result: 'Updated successfully'});
                        }).catch((error) => {
                            console.error('Failed to update document from project collection. Error => %s', error);
                            response.status(500).send({result: "Server error occurred"});
                        })
                        } else {
                            response.status(400).send({result: "Bad request"});
                        }

                    }).catch((error) => {
                    console.error('Failed to retrieve documents from project collection. Error => %s', error);
                    response.status(500).send({result: "Server error occurred"});
                });

                // db.collection('projects')
                //     .add(projectData)
                //     .then((docResponse) => {
                //     response.status(200).send({result : 'Project successfully created', docReference : docResponse});
                // }).catch((error) => {
                //     console.error('Failed to create document in project collection. Error => %s', error);
                //     response.status(500).send({result: "Server error occurred"});
                // })

            } else {
                response.status(400).send({result: "Bad request"});
            }
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);