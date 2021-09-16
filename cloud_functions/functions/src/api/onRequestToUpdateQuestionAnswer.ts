import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import * as utility from '../utils/Utility'

export const onRequestToUpdateQuestionAnswer = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;
        if (request.method === 'POST') {
            if(requestData?.projectID && requestData?.questionID){
                const db = admin.firestore();
                const stageQuestion = utility.traceStageQuestion(requestData?.questionID)
                db.collection('projects')
                    .doc(requestData?.projectID)
                    .get()
                    .then((doc) => {
                        if (doc.exists) {
                            const projectData : any = doc.data();

                            projectData[stageQuestion.stage][stageQuestion.questionType][stageQuestion.questionID].answer = true
                            projectData.projectStatus.lastUpdatedOn = new Date();
                            db.collection('projects').doc(requestData?.projectID).update(projectData).then(() => {
                                response.status(200).send({
                                    actionStatus : true,

                                });
                            }).catch((error) => {
                                response.status(500).send({
                                    actionStatus : false,
                                    result: error});

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
                console.error('Failed to retrieve documents from project collection. Error => Invalid Parameters found');
                response.status(500).send({
                    actionStatus : false,
                    error: "Failed to retrieve documents from project collection. Invalid Parameters found",
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