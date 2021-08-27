import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as Utility from "../utils/Utility";

export const onProjectCreation = functions.firestore.document('projects/{projectId}').onCreate((snap, context) => {
    return new Promise<void>((resolve, reject) => {
        const db = admin.firestore();
        const projectData: any = snap.data();
        projectData.projectID = context.params.projectId;
        projectData['projectStatus'] = {
            startDate: new Date(),
            endDate: null,
            lastUpdatedOn : new Date(),
            status: "Started"
        };
        db.collection('crops').doc(projectData.cropID).get()
            .then((cropDoc) => {

                if (cropDoc.exists) {
                    const cropData: any = cropDoc.data();
                    projectData['cropInfo'] = { // Creating crop info object from relevant crop document
                        cropID: cropData.cropID,
                        name: cropData.name,
                        imageURL: cropData.imageURL,
                        description: cropData.description,
                        lifeSpan: cropData.lifeSpan
                    };

                    // Stage 1
                    projectData['stage1'] = cropData.stage1;
                    projectData.stage1.ID = Utility.generateStageToken(cropData.stage1.name);
                    projectData.stage1.startDate = null;
                    projectData.stage1.completed = false;

                    const stage1DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage1.diseaseQuestionList.length; i++) {
                        stage1DiseaseQuestionList.push({
                            indexNo: "S1DQ"+ i,
                            question: cropData.stage1.diseaseQuestionList[i].question,
                            answer: false,
                            moveCount: cropData.stage1.diseaseQuestionList[i].moveCount,
                            important: cropData.stage1.diseaseQuestionList[i].important
                        });
                    }
                    projectData.stage1.diseaseQuestionList = stage1DiseaseQuestionList;

                    const stage1GrowthQuestionList: {}[] = [];
                    for (let i = 0; i < cropData['stage1']['growthQuestionList'].length; i++) {
                        stage1GrowthQuestionList.push({
                            indexNo: "S1GQ"+ i,
                            question: cropData['stage1']['growthQuestionList'][i],
                            answer: false,
                            oveCount: cropData.stage1.growthQuestionList[i].moveCount,
                            important: cropData.stage1.growthQuestionList[i].important
                        });
                    }
                    projectData.stage1.growthQuestionList = stage1GrowthQuestionList;
                    // Stage 2
                    projectData['stage2'] = cropData.stage2;
                    projectData.stage2.ID = Utility.generateStageToken(cropData.stage2.name);
                    projectData.stage2.startDate = null;
                    projectData.stage2.completed = false;

                    const stage2DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage2.diseaseQuestionList.length; i++) {
                        stage2DiseaseQuestionList.push({
                            indexNo: "S2DQ"+ i,
                            question: cropData.stage2.diseaseQuestionList[i].question,
                            answer: false,
                            moveCount: cropData.stage2.diseaseQuestionList[i].moveCount,
                            important: cropData.stage2.diseaseQuestionList[i].important
                        });
                    }
                    projectData.stage2.diseaseQuestionList = stage2DiseaseQuestionList;

                    const stage2GrowthQuestionList: {}[] = [];
                    for (let i = 0; i < cropData['stage2']['growthQuestionList'].length; i++) {
                        stage2GrowthQuestionList.push({
                            indexNo: "S2GQ"+ i,
                            question: cropData['stage2']['growthQuestionList'][i],
                            answer: false,
                            oveCount: cropData.stage2.growthQuestionList[i].moveCount,
                            important: cropData.stage2.growthQuestionList[i].important
                        });
                    }
                    projectData.stage2.growthQuestionList = stage2GrowthQuestionList;

                    // Stage 3
                    projectData['stage3'] = cropData.stage3;
                    projectData.stage3.ID = Utility.generateStageToken(cropData.stage3.name);
                    projectData.stage3.startDate = null;
                    projectData.stage3.completed = false;

                    const stage3DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage3.diseaseQuestionList.length; i++) {
                        stage3DiseaseQuestionList.push({
                            indexNo: "S3DQ"+ i,
                            question: cropData.stage3.diseaseQuestionList[i].question,
                            answer: false,
                            moveCount: cropData.stage3.diseaseQuestionList[i].moveCount,
                            important: cropData.stage3.diseaseQuestionList[i].important
                        });
                    }
                    projectData.stage3.diseaseQuestionList = stage3DiseaseQuestionList;

                    const stage3GrowthQuestionList: {}[] = [];
                    for (let i = 0; i < cropData['stage3']['growthQuestionList'].length; i++) {
                        stage3GrowthQuestionList.push({
                            indexNo: "S3GQ"+ i,
                            question: cropData['stage3']['growthQuestionList'][i],
                            answer: false,
                            oveCount: cropData.stage3.growthQuestionList[i].moveCount,
                            important: cropData.stage3.growthQuestionList[i].important
                        });
                    }
                    projectData.stage3.growthQuestionList = stage3GrowthQuestionList;

                    //Stage 4
                    projectData['stage4'] = cropData.stage4;
                    projectData.stage4.ID = Utility.generateStageToken(cropData.stage4.name);
                    projectData.stage4.startDate = null;
                    projectData.stage4.completed = false;

                    const stage4DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage4.diseaseQuestionList.length; i++) {
                        stage4DiseaseQuestionList.push({
                            indexNo: "S4DQ"+ i,
                            question: cropData.stage4.diseaseQuestionList[i].question,
                            answer: false,
                            moveCount: cropData.stage4.diseaseQuestionList[i].moveCount,
                            important: cropData.stage4.diseaseQuestionList[i].important
                        });
                    }
                    projectData.stage4.diseaseQuestionList = stage4DiseaseQuestionList;

                    const stage4GrowthQuestionList: {}[] = [];
                    for (let i = 0; i < cropData['stage4']['growthQuestionList'].length; i++) {
                        stage4GrowthQuestionList.push({
                            indexNo: "S4GQ"+ i,
                            question: cropData['stage4']['growthQuestionList'][i],
                            answer: false,
                            oveCount: cropData.stage4.growthQuestionList[i].moveCount,
                            important: cropData.stage4.growthQuestionList[i].important
                        });
                    }
                    projectData.stage4.growthQuestionList = stage4GrowthQuestionList;

                    //Initialization stage
                    db.collection('gardens').doc(cropData.placeSelection.pSID).get()
                        .then((gardenDoc) => {
                            if (gardenDoc.exists) {
                                const gardenData : any = gardenDoc.data()
                                projectData.initialization = {
                                    place:gardenData,
                                    place_selectionStatus: false,
                                    purchaseStatus : false
                                }
                                db.collection('projects').doc(projectData.projectID).set(projectData, {merge: true})
                                    .then(() => resolve())
                                    .catch((error) => {
                                        console.error('Failed to set crop data to %s document. Error => %s', projectData.projectID, error);
                                        reject();
                                    });
                            } else {
                                console.error('%s document does not exist on gardens collection', cropData.placeSelection.pSID);
                                reject();
                            }
                        }).catch((error) => {
                        console.error('Failed to retrieve %s document from gardens collection. Error => %s', cropData.placeSelection.pSID, error);
                        reject();
                    })
                } else {
                    console.error('%s document does not exist on crops collection', projectData.cropID);
                    reject();
                }
            })
            .catch((error) => {
            console.error('Failed to retrieve %s document from crops collection. Error => %s', projectData.cropID, error);
            reject();
        });
    });
});