import {PlantGrowthStage} from "./PlantGrowthStage";
import * as Utility from "../../utils/Utility";
import {Question} from "../common/Question";

export class PlantProjectHandler{
    private readonly _projectID : string = "";
    private readonly _projectName : string = "";
    private readonly _uuID : string = "";
    private readonly _cropInfo : any = {};
    private readonly _initialization : any = {};
    private readonly _plantStage : any = null;
    private readonly _projectStatus : any = null;
    private readonly _currentStageCompletion : number = 0;
    private readonly _completionPercentage : number = 0;
    private readonly _geoLocation : any = {};
    private readonly _prediction : any = {};

    private readonly _plantStageList : PlantGrowthStage[] = [];



    constructor(projectData : any, predictionReport : any) {

        const plantStage1 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage1.stageID,
            projectData.stage1.name,
            projectData.stage1.startDate?._seconds,
            projectData.stage1.completed,
            projectData.stage1.dailyWater,
            Utility.getDailyWateringAmount(predictionReport.wateringLevel, projectData.stage1.dailyWater),
            projectData.stage1.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage1.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage1.diseaseQuestionList));
        const plantStage2 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage2.stageID,
            projectData.stage2.name,
            projectData.stage2.startDate?._seconds,
            projectData.stage2.completed,
            projectData.stage2.dailyWater,
            Utility.getDailyWateringAmount(predictionReport.wateringLevel, projectData.stage2.dailyWater),
            projectData.stage2.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.diseaseQuestionList));
        const plantStage3 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage3.stageID,
            projectData.stage3.name,
            projectData.stage3.startDate?._seconds,
            projectData.stage3.completed,
            projectData.stage3.dailyWater,
            Utility.getDailyWateringAmount(predictionReport.wateringLevel, projectData.stage3.dailyWater),
            projectData.stage3.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.diseaseQuestionList));
        const plantStage4 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage4.stageID,
            projectData.stage4.name,
            projectData.stage4.startDate?._seconds,
            projectData.stage4.completed,
            projectData.stage4.dailyWater,
            Utility.getDailyWateringAmount(predictionReport.wateringLevel, projectData.stage4.dailyWater),
            projectData.stage4.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.diseaseQuestionList));
        this._plantStageList = [plantStage1, plantStage2, plantStage3, plantStage4];


        this._projectID = projectData.projectID;
        this._projectName = projectData.projectName;
        this._uuID = projectData.uuID;
        this._initialization = projectData.initialization;
        this._cropInfo = projectData.cropInfo;
        this._plantStage = this.currentPlantStage(this._plantStageList);
        this._projectStatus = projectData.projectStatus;
        this._currentStageCompletion = this.currentStageCompletionPercentage(this._plantStage,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage1.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.growthQuestionList));
        this._completionPercentage = this.projectCompletionPercentage(Utility.convertQuestionJsonDataToArrayList(projectData.stage1.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.growthQuestionList));
        this._geoLocation = projectData.geoLocation;
        console.log("Log value :" +predictionReport)
        if(predictionReport == ""){
            this._prediction = predictionReport;
            this._prediction['predictionStatus'] = "false";
        }else{
            this._prediction = predictionReport;
        }

    }



    get plantProjectData() : any{
        return {
            "projectID" : this._projectID,
            "uuID" : this._uuID,
            "projectName" : this._projectName,
            "geoLocation": this._geoLocation,
            "cropInfo" : {
                "cropID": this._cropInfo.cropID,
                "name": this._cropInfo.name,
                "imageURL": this._cropInfo.imageURL,
                "description": this._cropInfo.description,
                "lifeSpan": this._cropInfo.lifeSpan,
                "cropNote": {
                    "noteStatus": this._prediction.predictionStatus,
                    "noteMessage": "From "+this._prediction.duration+" "+this._prediction.predictionInfo+ " "+Utility.getWateringLevelMessage(this._prediction.wateringLevel),
                },

            },
            "initialization" : this._initialization,
            "plantStage" : {
                "stageID": this._plantStage.stageID,
                "stageName": this._plantStage.stageName,
                "stageStartDate": this._plantStage.stageStartDate,
                "completed": this._plantStage.completed,
                "stageWater" : this._plantStage.stageWater,
                "dailyWater": this._plantStage.dailyWater,
                "stageLifeSpan": this._plantStage.stageLifeSpan,
                "stageDayCounter": this._plantStage.stageDayCounter,
                "growthQuestionList": this._plantStage.growthQuestionList,
                "diseaseQuestionList": this._plantStage.diseaseQuestionList
            },
            "projectStatus" : {
                "status": this._projectStatus['status'],
                "startDate": this._projectStatus['startDate'],
                "lastUpdatedOn" : this._projectStatus['lastUpdatedOn'],
                "endDate": this._projectStatus['endDate'],
                "completionLevel": this._completionPercentage,
                "currentStage": this.currentProjectStage(this._projectStatus['status'], this._initialization),
                "currentStageCompletion": this._currentStageCompletion
            }

        };
    }
    currentProjectStage(projectStatus : string, initialization : any) : string{
        if(!initialization['purchaseStatus'])
            return "Purchase Stage";
        else if(!initialization['place_selectionStatus'])
            return "Place Selection Stage";
        else if(projectStatus === "Started")
            return this._plantStage.stageName;
        else
            return "Finished";
    }
    currentPlantStage(plantStageList : PlantGrowthStage[]) : PlantGrowthStage {
        let currentPlantStage : any
        for(let i = 0; i < plantStageList.length; i++){
            if(plantStageList[plantStageList.length -1].completed){
                currentPlantStage = plantStageList[plantStageList.length -1];
            }else{
                if(!plantStageList[i].completed){
                    currentPlantStage = plantStageList[i];
                    break;
                }
            }
        }
        return currentPlantStage;

    }
    projectCompletionPercentage(stage1ArrayQuestionList : Question[], stage2ArrayQuestionList : Question[], stage3ArrayQuestionList : Question[], stage4ArrayQuestionList : Question[] ) : number{
        let completion : number = 0;
        let total : number = 0;


        for(let counter : number = 0; counter < stage1ArrayQuestionList.length;  counter++){
            total++;
            if(stage1ArrayQuestionList[counter].answer){
                completion ++
            }
        }
        for(let counter : number = 0; counter < stage2ArrayQuestionList.length;  counter++){
            total++;
            if(stage2ArrayQuestionList[counter].answer){
                completion ++
            }
        }
        for(let counter : number = 0; counter < stage3ArrayQuestionList.length;  counter++){
            total++;
            if(stage3ArrayQuestionList[counter].answer){
                completion ++
            }
        }
        for(let counter : number = 0; counter < stage4ArrayQuestionList.length;  counter++){
            total++;
            if(stage4ArrayQuestionList[counter].answer){
                completion ++
            }
        }

        return Math.round((completion / total * 100));

    }
    currentStageCompletionPercentage(plantStage : any, stage1ArrayQuestionList : Question[], stage2ArrayQuestionList : Question[], stage3ArrayQuestionList : Question[], stage4ArrayQuestionList : Question[] ) : number{
        let completion : number = 0;
        let total : number = 0;
        let currentStageCompletionPercentage : number = 0;

        switch(plantStage.stageID) {
            case "seeding_stage": {
                for(let counter : number = 0; counter < stage1ArrayQuestionList.length;  counter++){
                    total++;
                    if(stage1ArrayQuestionList[counter].answer){
                        completion ++
                    }
                }
                currentStageCompletionPercentage = Math.round((completion / total * 100))
                break;
            }
            case "germination_stage": {
                for(let counter : number = 0; counter < stage2ArrayQuestionList.length;  counter++){
                    total++;
                    if(stage2ArrayQuestionList[counter].answer){
                        completion ++
                    }
                }
                currentStageCompletionPercentage = Math.round((completion / total * 100));
                break;
            }
            case "harvesting_stage": {
                for(let counter : number = 0; counter < stage3ArrayQuestionList.length;  counter++){
                    total++;
                    if(stage3ArrayQuestionList[counter].answer){
                        completion ++
                    }
                }
                currentStageCompletionPercentage = Math.round((completion / total * 100));
                break;
            }
            case "decomposing_stage": {
                for(let counter : number = 0; counter < stage4ArrayQuestionList.length;  counter++){
                    total++;
                    if(stage4ArrayQuestionList[counter].answer){
                        completion ++
                    }
                }
                currentStageCompletionPercentage = Math.round((completion / total * 100));
                break;
            }
            default: {
                currentStageCompletionPercentage = 0;
                break;
            }
        }
        return currentStageCompletionPercentage;

    }
    isStageNotMarkedComplete() : any {
        //check whether are there any stage which finished all trace activities but not marked as completed
        const plantStageList : PlantGrowthStage[] = this._plantStageList;
        let incompleteStageID : string = "";
        let currentStageID : string = "";
        let waitingStagePassStatus : boolean = false;
        let completedStageCount : number = 0;
        let projectFinishStatus : boolean = false;
        for(let i = 0; i < plantStageList.length; i++){

            if(!plantStageList[plantStageList.length -1].completed){
                let completionCount : number = 0;
                const growthQuestionList : Question[] = Utility.convertQuestionJsonDataToArrayList(plantStageList[plantStageList.length -1].growthQuestionList)
                for(let j = 0; j < growthQuestionList.length; j++){
                    if(growthQuestionList[j].answer){
                        completionCount++;
                    }
                }
                if(completionCount === growthQuestionList.length){
                    waitingStagePassStatus = true;
                    incompleteStageID = plantStageList[plantStageList.length -1].stageID;

                }else{
                    currentStageID = plantStageList[plantStageList.length -1].stageID;
                    break;
                }
                // waitingStagePassStatus = true;
                //
                // const growthQuestionList : Question[] = Utility.convertQuestionJsonDataToArrayList(plantStageList[plantStageList.length -1].growthQuestionList);
                // for(let j = 0; j < growthQuestionList.length; j++){
                //     if(!growthQuestionList[j].answer){
                //         waitingStagePassStatus = false;
                //         currentStageID
                //         break;
                //     }
                //
                // }
            }else{
                completedStageCount++
                if(completedStageCount === plantStageList.length){
                    projectFinishStatus = true;
                    break;
                }
            }
        }
        return {
            "incompleteStageID" : Utility.getStageFromStageID(incompleteStageID),
            "waitingStagePassStatus" : waitingStagePassStatus,
            "currentStageID" : Utility.getStageFromStageID(currentStageID),
            "projectFinishStatus" : projectFinishStatus
        };

    }
}