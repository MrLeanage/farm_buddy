import * as admin from "firebase-admin";

admin.initializeApp();

export {onRequestViableCropList} from "./api/onRequestViableCropList";
export {onRequestAllCropList} from "./api/onRequestAllCropList";
export {onProjectCreation} from "./firestore/onProjectCreation";
export {onRequestWeather} from "./api/onRequestWeather";