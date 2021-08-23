import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onProjectCreation = functions.firestore.document('projects/{projectId}').onCreate((snap, context) => {
    return new Promise<void>((resolve, reject) => {
        const db = admin.firestore();
        const projectData: any = snap.data();
        projectData.projectId = context.params.projectId;
        projectData['startDate'] = new Date();
        projectData['endDate'] = null;
        projectData['lastUpdatedOn'] = new Date();

        db.collection('crops').doc(projectData.cropId).get()
            .then((doc) => {
                if (doc.exists) {
                    const cropData: any = doc.data();
                    delete projectData['cropId'];
                    projectData['cropInfo'] = { // Creating crop info object from relevant crop document
                        cropId: cropData.cropId,
                        name: cropData.name,
                        imageURL: cropData.imageURL,
                        description: cropData.description,
                        lifeSpan: cropData.lifeSpan
                    };

                    // Stage 2
                    projectData['stage2'] = cropData.stage2;
                    projectData.stage2.completed = false;

                    const vegetationQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage2.vegetatingQuestionList.length; i++) {
                        vegetationQuestionList.push({
                            question: cropData.stage2.vegetatingQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage2.vegetatingQuestionList = vegetationQuestionList;

                    const floweringQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage2.floweringQuestionList.length; i++) {
                        floweringQuestionList.push({
                            question: cropData.stage2.floweringQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage2.floweringQuestionList = floweringQuestionList;

                    const stage2DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage2.diseaseQuestionList.length; i++) {
                        stage2DiseaseQuestionList.push({
                            question: cropData.stage2.diseaseQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage2.diseaseQuestionList = stage2DiseaseQuestionList;

                    // Stage 3
                    projectData['stage3'] = cropData.stage3;
                    projectData.stage3.completed = false;

                    const ripeningQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage3.ripeningQuestionList.length; i++) {
                        ripeningQuestionList.push({
                            question: cropData.stage3.ripeningQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage3.ripeningQuestionList = ripeningQuestionList;

                    const harvestingQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage3.harvestingQuestionList.length; i++) {
                        harvestingQuestionList.push({
                            question: cropData.stage3.harvestingQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage3.harvestingQuestionList = harvestingQuestionList;

                    const stage3DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage3.diseaseQuestionList.length; i++) {
                        stage3DiseaseQuestionList.push({
                            question: cropData.stage3.diseaseQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage3.diseaseQuestionList = stage3DiseaseQuestionList;

                    //Stage 4
                    projectData['stage4'] = cropData.stage4;
                    projectData.stage4.completed = false;

                    const decomposeQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage4.decomposeQuestionList.length; i++) {
                        decomposeQuestionList.push({
                            question: cropData.stage4.decomposeQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage4.decomposeQuestionList = decomposeQuestionList;

                    // Stage 1
                    projectData['stage1'] = cropData.stage1;
                    projectData.stage1.completed = false;

                    const stage1DiseaseQuestionList: {}[] = [];
                    for (let i = 0; i < cropData.stage1.diseaseQuestionList.length; i++) {
                        stage1DiseaseQuestionList.push({
                            question: cropData.stage1.diseaseQuestionList[i],
                            answer: false
                        });
                    }
                    projectData.stage1.diseaseQuestionList = stage1DiseaseQuestionList;

                    const seedlingQuestionList: {}[] = [];
                    for (let i = 0; i < cropData['stage1']['seedlingQuestionList']; i++) {
                        seedlingQuestionList.push({
                            question: cropData['stage1']['seedlingQuestionList'][i],
                            answer: false
                        });
                    }

                    db.collection('gardens').doc(cropData.type).get()
                        .then((gardenDoc) => {
                            if (gardenDoc.exists) {
                                projectData.stage1.gardening = gardenDoc.data();
                                db.collection('projects').doc(projectData.projectId).set(projectData, {merge: true})
                                    .then(() => resolve())
                                    .catch((error) => {
                                        console.error('Failed to set crop data to %s document. Error => %s', projectData.projectId, error);
                                        reject();
                                    });
                            } else {
                                console.error('%s document does not exist on gardens collection', cropData.type);
                            }
                        }).catch((error) => {
                        console.error('Failed to retrieve %s document from gardens collection. Error => %s', cropData.type, error);
                        reject();
                    })
                } else {
                    console.error('%s document does not exist on crops collection', projectData.cropId);
                }
            }).catch((error) => {
            console.error('Failed to retrieve %s document from crops collection. Error => %s', projectData.cropId, error);
            reject();
        });
    });
});