import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {PlantProjectHandler} from "../model/plant/PlantProjectHandler";
import * as rainPredictionReport from "../model/weather/RainPredictionReport";

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
                        let plantProjectHandler: PlantProjectHandler;
                        rainPredictionReport.rainPredictionForPlantSelection(projectData.geoLocation.longitude, projectData.geoLocation.latitude, 5)
                            .then((predictionReport) => {
                                plantProjectHandler = new PlantProjectHandler(projectData, predictionReport)
                                if(projectData.projectStatus.status !== "Finished"){
                                    //checking unmarked stage complete values
                                    if(plantProjectHandler.isStageNotMarkedComplete()['waitingStagePassStatus']){
                                        projectData[plantProjectHandler.isStageNotMarkedComplete()['incompleteStageID']].completed = true;
                                        projectData.projectStatus.lastUpdatedOn = new Date();
                                    }
                                    //mark finish if not marked yet
                                    if(plantProjectHandler.isStageNotMarkedComplete()['projectFinishStatus']){
                                        projectData.projectStatus.lastUpdatedOn = new Date();
                                        projectData.projectStatus.endDate = new Date();
                                        projectData.projectStatus.status = "Finished";
                                    }
                                    //updating firestore values
                                    db.collection('projects').doc(requestData?.projectID).update(projectData).then(() => {
                                        console.log("Project stages Info Updated")
                                    }).catch((error) => {
                                        console.error('Failed to update document from project collection. Error => %s', error);
                                        response.status(500).send({
                                            actionStatus : false,
                                            error: "Failed to update document from project collection",
                                            result: "Server error occurred Code 500"
                                        });
                                    });
                                }
                                response.status(200).send(plantProjectHandler.plantProjectData);
                            }).catch((error) => {
                            response.status(500).send({
                                actionStatus: false,
                                originatedFrom: 'rain prediction',
                                result: error
                            });
                        })


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