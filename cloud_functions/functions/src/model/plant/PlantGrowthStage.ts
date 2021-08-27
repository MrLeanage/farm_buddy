import {Question} from "../common/Question";
import * as Utility from "../../utils/Utility";

export class PlantGrowthStage{
    private readonly _stageID: string = "";
    private readonly _stageName: string = "";
    private readonly _stageStartDate: string = "";
    private readonly _completed: boolean = false;
    private readonly _dailyWater: string = "0 mm";
    private readonly _stageLifeSpan: number = 0;
    private readonly _stageDayCounter: number = 0;
    private readonly _growthQuestionList : Question[] = [];
    private readonly _diseaseQuestionList : Question[] = [];


    constructor(stageID: string, stageName: string, stageStartDate: number, completed: boolean, dailyWater: string, stageLifeSpan: number,  growthQuestionList: Question[], diseaseQuestionList: Question[]) {
        this._stageID = stageID;
        this._stageName = stageName;
        this._stageStartDate = Utility.convertTimeStampToDate(stageStartDate);
        this._completed = this.stageCompleteStatus(Utility.convertQuestionJsonDataToArrayList(growthQuestionList), completed);
        this._dailyWater = dailyWater;
        this._stageLifeSpan = stageLifeSpan;
        this._stageDayCounter = Utility.GetNoOfDaysBetweenTwoDates(new Date(stageStartDate), new Date());
        this._growthQuestionList = this.filteredGrowthQuestionList(Utility.convertQuestionJsonDataToArrayList(growthQuestionList));
        this._diseaseQuestionList = this.filteredDiseaseQuestionList(Utility.convertQuestionJsonDataToArrayList(diseaseQuestionList));
    }


    get stageID(): string {
        return this._stageID;
    }

    get stageName(): string {
        return this._stageName;
    }

    get stageStartDate(): string {
        return this._stageStartDate;
    }

    get completed(): boolean {
        return this._completed;
    }

    stageCompleteStatus(questionList : Question[], currentStatus : boolean) : boolean{
        let status :boolean = true;
        if(!currentStatus){
            questionList.forEach((question)=>{
                if(!question.answer){
                    status = false;
                }
            });
        }
        return status;
    }

    get dailyWater(): string {
        return this._dailyWater;
    }

    get stageLifeSpan(): number {
        return this._stageLifeSpan;
    }

    get stageDayCounter(): number {
        return this._stageDayCounter;
    }

    get growthQuestionList(): Question[] {
        return this._growthQuestionList;
    }

    private filteredGrowthQuestionList(unFilteredGrowthQuestionList : Question[]): Question[] {
        const _filteredGrowthQuestionList : Question[] = [];
        let counter : number = 0;
        let maxMoveCount : number = 1;
        for(counter; counter < unFilteredGrowthQuestionList.length;){


            if(!unFilteredGrowthQuestionList[counter].answer){
                if(unFilteredGrowthQuestionList[counter].moveCount == 1){
                    _filteredGrowthQuestionList.push(unFilteredGrowthQuestionList[counter])
                    break;
                }else{
                    _filteredGrowthQuestionList.push(unFilteredGrowthQuestionList[counter]);
                    maxMoveCount += unFilteredGrowthQuestionList[counter].moveCount;
                    counter += maxMoveCount;
                    maxMoveCount --;
                }
            }else{
                counter++;
            }
        }
        return _filteredGrowthQuestionList;
    }

    get diseaseQuestionList(): Question[] {
        return this._diseaseQuestionList;
    }

    private filteredDiseaseQuestionList(unFilteredDiseaseQuestionList : Question[]): Question[] {

        const _filteredDiseaseQuestionList : Question[] = [];
        let counter : number = 0;
        let maxMoveCount : number = 1;
        for(counter; counter < unFilteredDiseaseQuestionList.length;){


            if(!unFilteredDiseaseQuestionList[counter].answer){
                if(unFilteredDiseaseQuestionList[counter].moveCount == 1){
                    _filteredDiseaseQuestionList.push(unFilteredDiseaseQuestionList[counter])
                    break;
                }else{
                    _filteredDiseaseQuestionList.push(unFilteredDiseaseQuestionList[counter]);
                    maxMoveCount += unFilteredDiseaseQuestionList[counter].moveCount;
                    counter += maxMoveCount;
                    maxMoveCount --;
                }
            }else{
                counter++;
            }
        }
        return _filteredDiseaseQuestionList;
    }
}