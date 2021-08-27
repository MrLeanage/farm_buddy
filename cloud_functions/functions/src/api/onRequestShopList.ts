import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

export const onRequestAllShopList = functions.https.onRequest(
    (request, response) => {
        let shopList: any = {};

        if (request.method === 'POST') {
            const db = admin.firestore();
            db.collection('shops')
                .where('status', '==', true)
                .get()
                .then((snap) => {
                    snap.forEach((doc) => {
                        const shopData: any = doc.data();
                        shopList = shopData
                    });
                    response.status(200).send(shopList);
                }).catch((error) => {
                console.error('Failed to retrieve documents from Shops collection. Error => %s', error);
                response.status(500).send({result: "Server error occurred"});
            });
        } else {
            response.status(400).send({result: "Bad request"});
        }
    }
);