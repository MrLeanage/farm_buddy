import {Question} from "../model/common/Question";
import {firestore} from "firebase-admin/lib/firestore";

const axios = require('axios')
const moment = require('moment');

export function getSeasonalMonthNumber(monthNumber: number): number {

    if (monthNumber <= 6)
        return monthNumber;
    else
        return monthNumber - 6;
}

export function getMonthNumberFromDate(monthNumber: number): number {

    if (monthNumber <= 6)
        return monthNumber;
    else
        return monthNumber - 6;
}

export function generateStageToken(value: string): string {
    let replaceValue = /\s/gi;
    console.log("generateStageToken income value" + value);
    return value.replace(replaceValue, "_").toLowerCase();
}

export function getWeatherData(longitude: string, latitude: string, duration: number): Promise<any> {
    const baseURL: string = 'https://atlas.microsoft.com/weather/forecast/daily/json?api-version=1.0&';
    const query: string = 'query=' + longitude + '%2C' + latitude + '&duration=' + duration + '&';
    const subscription_key: string = 'subscription-key=ETPQmOJLe4eyTAzAM7UZiSiD2LI6w-45cfguWFdMUSI'
    return axios.get(baseURL + query + subscription_key);
}

export function getPredictionData(projectID: string): Promise<any> {
    const baseURL: string = 'https://us-central1-farmbuddy-2021.cloudfunctions.net/onRequestSpecificProjectStageData';
    return axios.post(baseURL, {
        "projectID" : projectID
    });
}

export function GetNoOfDaysBetweenTwoDates(startDate: Date, endDate: Date): number {
    const start = moment(startDate);
    const end = moment(endDate);
    const duration = moment.duration(start.diff(end));
    return duration.asDays();
}

export function convertTimeStampToDate(date: Date): string {

    return moment(date).month() + 1;
}

export function convertFirebaseTimeStampToDate(json : any): string {
    const timestamp = firestore.Timestamp.fromMillis(json['seconds']);
    console.log("date from seconds :"+timestamp.toDate().toDateString())
    let initDate: any = "";
    if(Number.isInteger(json['seconds'])){
        initDate = json['seconds'].toDate().toDateString();
    }

    return initDate;
}

export function convertQuestionJsonDataToArrayList(jsonData: any): Question[] {
    const questionList: Question[] = [];
    for (let i = 0; i < jsonData.length; i++) {
        questionList.push(new Question(jsonData[i].indexNo, jsonData[i].question, jsonData[i].answer, jsonData[i].moveCount, jsonData[i].important));
    }
    return questionList;
}

export function getWateringLevelMessage(level: number): string {
    if (level < 1) {
        return "You need to decrease up to " + level * 100 + "% of your given watering scheme";
    } else if (level == 1) {
        return "You need to follow your given watering scheme";
    } else {
        return "You need to increase up to " + level * 100 + " of your given watering scheme";
    }
}

export function getDailyWateringAmount(predictionLevel: number, wateringLevel: string): string {
    const amount: number = +wateringLevel.replace(/[^0-9]/g, '');
    return amount * predictionLevel + " mm";
}

export function traceStageQuestion(tokenID : string) : any{
    const stage : string = "stage"+tokenID.charAt(1);
    const questionPrefix : string = tokenID.charAt(2);
    const questionID : string = tokenID.slice(4);

    let questionType : string = "";
    if(questionPrefix === "G"){
        questionType = "growthQuestionList"
    }else if (questionPrefix === "D"){
        questionType = "diseaseQuestionList"
    }
    return {
        "stage": stage,
        "questionType": questionType,
        "questionID": questionID
    };

}
export function getStageFromStageID(stageID : string) : string{
    let stage : string = "";
    switch (stageID) {
        case "seeding_stage": {
            stage = "stage1";
            break;
        }
        case "germination_stage": {
            stage = "stage2";
            break;
        }
        case "harvesting_stage": {
            stage = "stage3";
            break;
        }
        case "decomposing_stage": {
            stage = "stage4";
            break;
        }
        default :{
            break;
        }
    }
    return stage;

}
