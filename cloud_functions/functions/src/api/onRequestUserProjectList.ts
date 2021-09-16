import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
// import {PlantProjectHandler} from "../model/plant/PlantProjectHandler";
// import * as Utility from "../utils/Utility";
import {PlantProjectHandler} from "../model/plant/PlantProjectHandler";
// import * as rainPredictionReport from "../model/weather/RainPredictionReport";

export const onRequestUserProjectList = functions.https.onRequest(
    (request, response) => {
        const requestData = request.body;

        if (request.method === 'POST' && requestData?.uID) {
            const projectList: {}[] = [];
            const db = admin.firestore();
            db.collection('projects')
                .where('uID', '==', requestData?.uID)
                .get()
                .then((snap) => {
                    snap.forEach((doc) => {
                        const projectData: any = doc.data();
                        let plantProjectHandler: PlantProjectHandler = new PlantProjectHandler(projectData, {})
                        projectList.push(plantProjectHandler.plantProjectData);
                        // Utility.getPredictionData(projectData.projectID).then((report) => {
                        //
                        //
                        // }).catch((error) => {
                        //     response.status(500).send({
                        //         actionStatus: false,
                        //         originatedFrom: 'rain prediction',
                        //         result: error
                        //     });
                        // });

                    });
                    response.status(200).send(projectList);
                    console.log("Item Total Count " + projectList.length)
                }).catch((error) => {
                console.error('Failed to retrieve documents from crops collection. Error => %s', error);
                response.status(500).send({
                    actionStatus: false,
                    result: "Server error occurred"
                });
            });
        } else {
            response.status(400).send({
                actionStatus: false,
                result: "Bad request"
            });
        }
    }
);

// function getPlantProjectData(projectData: any): Promise<any> {
//     return new Promise<any>((reject, resolve) => {
//         rainPredictionReport.rainPredictionForPlantSelection(projectData?.geoLocation?.longitude, projectData?.geoLocation?.latitude, 5)
//             .then((predictionReport) => {
//                 const plantProjectHandler: PlantProjectHandler = new PlantProjectHandler(projectData, predictionReport);
//                 resolve(plantProjectHandler.plantProjectData());
//             }).catch((error) => reject(error))
//     });
// }