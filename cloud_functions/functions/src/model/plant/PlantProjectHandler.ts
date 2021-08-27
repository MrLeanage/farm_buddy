import {PlantGrowthStage} from "./PlantGrowthStage";
import * as Utility from "../../utils/Utility";

export class PlantProjectHandler{
    private readonly _projectID : string = "";
    private readonly _uuID : string = "";
    private readonly _cropID : string = "";
    private readonly _cropInfo : any = {};
    private readonly _plantStage : any = null;
    private readonly _projectStatus : string = "";


    constructor(projectData : any) {

        const plantStage1 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage1.stageID,
            projectData.stage1.stageName,
            projectData.stage1.startDate?._seconds,
            projectData.stage1.completed,
            projectData.stage1.dailyWater,
            projectData.stage1.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage1.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage1.diseaseQuestionList));
        const plantStage2 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage2.stageID,
            projectData.stage2.stageName,
            projectData.stage2.startDate?._seconds,
            projectData.stage2.completed,
            projectData.stage2.dailyWater,
            projectData.stage2.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage2.diseaseQuestionList));
        const plantStage3 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage3.stageID,
            projectData.stage3.stageName,
            projectData.stage3.startDate?._seconds,
            projectData.stage3.completed,
            projectData.stage3.dailyWater,
            projectData.stage3.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage3.diseaseQuestionList));
        const plantStage4 : PlantGrowthStage = new PlantGrowthStage(
            projectData.stage4.stageID,
            projectData.stage4.stageName,
            projectData.stage4.startDate?._seconds,
            projectData.stage4.completed,
            projectData.stage4.dailyWater,
            projectData.stage4.stageLifeSpan,
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.growthQuestionList),
            Utility.convertQuestionJsonDataToArrayList(projectData.stage4.diseaseQuestionList));
        const plantStageList : PlantGrowthStage[] = [plantStage1, plantStage2, plantStage3, plantStage4];


        this._projectID = projectData.projectID;
        this._uuID = projectData.uuID;
        this._cropID = projectData.cropID;
        this._cropInfo = projectData.cropInfo;
        this._plantStage = this.currentPlantStage(plantStageList);
        this._projectStatus = projectData.projectStatus;
    }



    get plantProjectData() : any{
        return {
            "projectID" : this._projectID,
            "uuID" : this._uuID,
            "cropID" : this._cropID,
            "cropInfo" : this._cropInfo,
            "plantStage" : {
                "stageID": this._plantStage.stageID,
                "stageName": this._plantStage.stageName,
                "stageStartDate": this._plantStage.stageStartDate,
                "completed": this._plantStage.completed,
                "dailyWater": this._plantStage.dailyWater,
                "stageLifeSpan": this._plantStage.stageLifeSpan,
                "stageDayCounter": this._plantStage.stageDayCounter,
                "growthQuestionList": this._plantStage.growthQuestionList,
                "diseaseQuestionList": this._plantStage.diseaseQuestionList
            },
            "projectStatus" : this._projectStatus

        };
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
}