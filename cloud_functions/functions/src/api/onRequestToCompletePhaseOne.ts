import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

export const onRequestToCompletePhaseOne = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        if (request.method === 'POST') {
            if(requestData?.projectID){
                const db = admin.firestore();
                db.collection('projects')
                    .doc(requestData?.projectID)
                    .get()
                    .then((doc) => {
                        if (doc.exists) {
                            const projectData : any = doc.data();
                            projectData.initialization.purchaseStatus = true;
                            db.collection('projects').doc(requestData?.projectID).update(projectData).then(() => {

                                response.status(200).send({
                                    actionStatus : true,
                                    place: projectData.initialization.place
                                });

                            }).catch((error) => {
                                console.error('Failed to update document from project collection. Error => %s', error);
                                response.status(500).send({
                                    actionStatus : false,
                                    error: "Failed to update document from project collection",
                                    result: "Server error occurred Code 500"
                                });
                            });
                        } else {
                            response.status(400).send({
                                actionStatus : false,
                                error: "Failed to update document, Document does not exist",
                                result: "Bad request document does not exist Code 400"});
                        }

                    }).catch((error) => {
                    console.error('Failed to retrieve documents from project collection. Error => %s', error);
                    response.status(500).send({
                        actionStatus : false,
                        error: "Failed to retrieve documents from project collection",
                        result: "Server error occurred Code 500"});
                });
            }else{
                console.error('Failed to retrieve documents from project collection. Error => No projectID found');
                response.status(500).send({
                    actionStatus : false,
                    error: "Failed to retrieve documents from project collection for Update",
                    result: "Server error occurred Code 500"});
            }
        }else{
            response.status(400).send({
                actionStatus : false,
                error: "Bad Request, Requires POST Request",
                result: "Bad request Code 400"});
        }

        }
);