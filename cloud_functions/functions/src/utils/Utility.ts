import {Question} from "../model/common/Question";

const axios = require('axios')
const moment = require('moment');

export function getSeasonalMonthNumber(monthNumber: number): number {

    if (monthNumber <= 6)
        return monthNumber;
    else
        return monthNumber - 6;
}

export function generateStageToken(value: string): string {
    let replaceValue = /\s/gi;
    console.log("generateStageToken income value"+value);
    return value.replace(replaceValue, "_").toLowerCase();
}

export async function getWeatherData(longitude: string, latitude: string, duration: number): Promise<any> {
    const baseURL: string = 'https://atlas.microsoft.com/weather/forecast/daily/json?api-version=1.0&';
    const query: string = 'query=' + longitude + '%2C' + latitude + '&duration=' + duration + '&';
    const subscription_key: string = 'subscription-key=ETPQmOJLe4eyTAzAM7UZiSiD2LI6w-45cfguWFdMUSI'
    return axios.get(baseURL + query + subscription_key);
}

export function GetNoOfDaysBetweenTwoDates(startDate: Date, endDate: Date): number {
    const start = moment(startDate);
    const end = moment(endDate);
    const duration = moment.duration(start.diff(end));
    return duration.asDays();
}

export function convertTimeStampToDate(timestampInSeconds: number): string {
    if (timestampInSeconds) {
        const date = new Date(timestampInSeconds * 1000).toDateString();
        return (moment(date)).format('DD-MM-YYYY')
    } else {
        return '';
    }
}

export function convertQuestionJsonDataToArrayList(jsonData: any): Question[] {
    const questionList: Question[] = [];
    for (let i = 0; i < jsonData.length; i++) {
        questionList.push(new Question(i, jsonData[i].question, jsonData[i].answer, jsonData[i].moveCount, jsonData[i].important));
    }
    return questionList;
}
