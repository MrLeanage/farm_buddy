// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";
//
// export const onProjectCreation1 = functions.firestore.document('projects/{projectID}')
//     .onUpdate((change, context) => {
//     return new Promise<void>((resolve, reject) => {
//         const db = admin.firestore();
//         const after = change.after.data();
//
//         let nextDate = new Date();
//         const weather_forecasts: any = {};
//         for (let i = 0; i < 60; i++) {
//             weather_forecasts[nextDate.getFullYear() + '-' + (nextDate.getMonth() + 1) + '-' + ((nextDate.getDate() < 10) ? '0' + nextDate.getDate() : nextDate.getDate())] = {
//                 humidity: 1 + '%',
//                 temperature: 1 * 10 + '%',
//                 wind_speed: 1 * 20,
//                 wind_direction: 'Noth-east',
//                 rainfall: 1 * 0.5
//             }
//             nextDate.setDate(nextDate.getDate() + 1);
//         };
//
//         docData.weather_forecasts = weather_forecasts;
//         docData.id = projectId;
//
//         db.collection('projects').doc(projectId).set(docData, { merge: true })
//             .then(() => resolve())
//             .catch((error) => {
//                 console.error('Failed to set weather forecasts map to %s document. Error => %s', projectId, error);
//                 reject();
//             });
//     });
// });