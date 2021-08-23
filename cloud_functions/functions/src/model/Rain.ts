export class Rain {

    _date: String = "";
    _dayRainfall: number = 0;
    _nightRainfall: number = 0;
    _rainProbability: number = 0;
    _totalRain: number = 0;

    public constructor(date: Date, dayRainfall: number, nightRainfall: number, dayRainProbability: number, nightRainProbability: number) {
        this._date = (date.getMonth() + 1) + '-' + date.getDate() + '-' + date.getFullYear();
        this._dayRainfall = dayRainfall;
        this._nightRainfall = nightRainfall;
        this._rainProbability = (dayRainProbability + nightRainProbability) / 2;
        this._totalRain = dayRainfall + nightRainfall;
    }

    get date(): String {
        return this._date;
    }

    set date(value: String) {
        this._date = value;
    }

    get dayRainfall(): number {
        return this._dayRainfall;
    }

    set dayRainfall(value: number) {
        this._dayRainfall = value;
    }

    get nightRainfall(): number {
        return this._nightRainfall;
    }

    set nightRainfall(value: number) {
        this._nightRainfall = value;
    }

    get rainProbability(): number {
        return this._rainProbability;
    }

    set rainProbability(value: number) {
        this._rainProbability = value;
    }

    get totalRain(): number {
        return this.dayRainfall + this.nightRainfall;
    }

    getForecast(): {} {
        return {
            date: this.date,
            dayRainfall: this.dayRainfall,
            nightRainfall: this.nightRainfall,
            rainProbability: this.rainProbability,
            totalRain: this.totalRain,
        }
    }

    getTest(): string {
        return 'testData';
    }
}