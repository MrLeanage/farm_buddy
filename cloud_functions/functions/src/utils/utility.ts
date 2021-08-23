const axios = require('axios')

export function getSeasonalMonthNumber(monthNumber: number): number {

    if (monthNumber <= 6)
        return monthNumber;
    else
        return monthNumber - 6;
}

export async function getWeatherData(longitude: string, latitude: string, duration: number): Promise<any> {
    const baseURL: string = 'https://atlas.microsoft.com/weather/forecast/daily/json?api-version=1.0&';
    const query: string = 'query=' + longitude + '%2C' + latitude + '&duration=' + duration + '&';
    const subscription_key: string = 'subscription-key=ETPQmOJLe4eyTAzAM7UZiSiD2LI6w-45cfguWFdMUSI'
    return axios.get(baseURL + query + subscription_key);
}
