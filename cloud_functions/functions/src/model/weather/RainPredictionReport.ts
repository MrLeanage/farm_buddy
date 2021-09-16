import * as utility from "../../utils/Utility";
import {Rain} from "./Rain";
import {RainPredictionHandler} from "./RainPredictionHandler";

export function rainPredictionForPlantSelection(longitudes: string, latitudes: string, duration: number): Promise<any> {
    return new Promise<any>((resolve, reject) => {
        const rainDataList: any[] = [];

        utility.getWeatherData(longitudes, latitudes, duration)
            .then((weatherForecast) => {
                const weatherReports: {}[] = weatherForecast.data.forecasts;
                weatherReports.forEach((weatherData: any) => {
                    const rain: Rain = new Rain(new Date(weatherData.date), weatherData.day.rain.value, weatherData.night.rain.value, weatherData.day.rainProbability, weatherData.night.rainProbability);
                    rainDataList.push(rain)
                });

                const rainPrediction: RainPredictionHandler = new RainPredictionHandler(rainDataList);
                const rainPredictionReport = {
                    duration: rainPrediction.duration,
                    predictionStatus: rainPrediction.predictionStatus,
                    averageRainfall: rainPrediction.averageRainfall,
                    predictionInfo: rainPrediction.predictionInfo,
                    wateringLevel: rainPrediction.wateringLevel,
                    isGoodToSeeding: rainPrediction.isGoodToSeeding,
                    isGoodToFertilizer: rainPrediction.isGoodToFertilizer,
                };
                resolve(rainPredictionReport);
            }).catch((error) => reject(error));
    });
}


