import * as admin from "firebase-admin";

admin.initializeApp();

//API
export {onRequestViableCropList} from "./api/onRequestViableCropList";
export {onRequestAllCropList} from "./api/onRequestAllCropList";
export {onRequestToCreateProject} from "./api/onRequestToCreateProject";
export {onRequestAllShopList} from "./api/onRequestShopList";
export {onRequestToCompletePhaseOne} from "./api/onRequestToCompletePhaseOne";
export {onRequestToCompletePhaseTwo} from "./api/onRequestToCompletePhaseTwo";
export {onRequestToUpdateQuestionAnswer} from "./api/onRequestToUpdateQuestionAnswer";
export {onRequestUserProjectList} from "./api/onRequestUserProjectList";
export {onRequestPredictionData} from "./api/onRequestPredictionData";

export {onRequestWeather} from "./api/onRequestWeather";
export {onRequestSpecificProjectInfo} from "./api/onRequestSpecificProjectInfo";
export {onRequestSpecificProjectStageData} from "./api/onRequestSpecificProjectStageData";

//Firebase Events
export {onProjectCreation} from "./firestore/onProjectCreation";