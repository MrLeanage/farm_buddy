import {Rain} from "./Rain";

export class RainPredictionHandler {
    _duration: string = "";
    _dayCounter: number = 0.0;
    _possibleRainyDays: number = 0.0;
    _possibleRainyDaysProbability: number = 0.0;
    _rainFallLevel: number = 0.0;
    _predictionStatus: boolean = false;
    _predictionInfo: string = "";
    _wateringLevel: number = 1.0;
    _averageRainFall: number = 0.0;

    _isGoodToSeeding: boolean = false;
    _isGoodToFertilizer: boolean = false;


    public constructor(dayList: Rain[]) {

        if (dayList.length > 1) {
            this._duration = dayList[0]?.date + " - " + dayList[dayList.length - 1]?.date;
            dayList.forEach((value) => {
                this._dayCounter++;
                if (value.rainProbability > 70) {
                    this._possibleRainyDays++;
                    this._rainFallLevel += value.totalRain;
                    this._possibleRainyDaysProbability += value.rainProbability;
                }
            });
            this._averageRainFall = this._rainFallLevel.valueOf()/ this._possibleRainyDays.valueOf();
            console.log("posible rain :"+ this._possibleRainyDays + " day counter : "+this._dayCounter  + " Rainy Date possibility: "+this._possibleRainyDaysProbability +" posible Rainy days :" +this._possibleRainyDays);
            // this._averageRainFall = (parseInt(String(this._rainFallLevel))/ parseInt(String(this._possibleRainyDays)));
            //((this._possibleRainyDays / this._dayCounter) * 100 > 25) && (this._possibleRainyDaysProbability / this._possibleRainyDays *100) > 60
            if (!(((this._possibleRainyDays / this._dayCounter) * 100 > 25) && (this._possibleRainyDaysProbability / this._possibleRainyDays *100) > 60)) {
                this._predictionStatus = true;
                if ((this._averageRainFall) > 10) {
                    this._predictionInfo = "You may have a Heavy Rainy climate in your area for coming days(" + this._duration + ")! Please be stick to the App's guide";
                    this._wateringLevel = 1;
                } else {
                    this._isGoodToSeeding = true;
                    this._isGoodToFertilizer = true;
                    this._predictionInfo = "You may have a Rainy climate in your area for coming days!";
                    this._wateringLevel = 0.75;
                }
            } else {
                this._predictionStatus = true;
                this._isGoodToSeeding = true;
                this._isGoodToFertilizer = true;
                this._predictionInfo = "You may have a dry climate in your area for coming days! Please be stick to the App's guide";
                this._wateringLevel = 1.5;
            }
        } else if (dayList.length == 1) {
            this._duration = dayList[0]?.date.toString();
            dayList.forEach((value) => {
                this._dayCounter++;
                if (value.rainProbability > 80) {
                    this._possibleRainyDays++;
                    this._rainFallLevel += value.totalRain;
                    this._possibleRainyDaysProbability += value.rainProbability;
                }
            });
            if (((this._possibleRainyDays / this._dayCounter) * 100 > 25) && (this._possibleRainyDaysProbability / this._possibleRainyDays) > 60) {
                this._predictionStatus = true;
                if ((this._averageRainFall) > 10) {
                    this._predictionInfo = "You may have a Heavy Rainy climate in your area for Today(" + this._duration + ")! Please be stick to the App's guide";
                    this._wateringLevel = 0;
                } else {
                    this._isGoodToSeeding = true;
                    this._isGoodToFertilizer = true;
                    this._predictionInfo = "You may have a Rainy climate in your area for Today!";
                    this._wateringLevel = 0.5;
                }
            } else {
                this._predictionStatus = true;
                this._isGoodToSeeding = true;
                this._isGoodToFertilizer = true;
                this._predictionInfo = "You may have a dry climate in your area for Today! Please be stick to the App's guide";
                this._wateringLevel = 1.5;
            }
        }

    }


    get duration(): string {
        return this._duration;
    }

    get predictionStatus(): boolean {
        return this._predictionStatus;
    }

    get predictionInfo(): string {
        return this._predictionInfo;
    }

    get wateringLevel(): number {
        return this._wateringLevel;
    }

    get averageRainfall(): string{
        return this._averageRainFall.toString() + " mm"
    }

    get isGoodToSeeding(): boolean {
        return this._isGoodToSeeding;
    }

    get isGoodToFertilizer(): boolean {
        return this._isGoodToFertilizer;
    }
}








