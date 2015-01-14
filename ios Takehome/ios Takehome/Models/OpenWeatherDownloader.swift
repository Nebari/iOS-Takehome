//
//  OpenWeatherDownloader.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import Foundation

func downloadSeattleWeatherForNumberOfDays(numberOfDays: Int = 5, completion: (weather: Weather) -> Void) {
    let apiUrl = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Seattle&units=imperial&cnt=\(numberOfDays)")
    let urlRequest = NSURLRequest(URL: apiUrl!)
    
    let urlSession = NSURLSession.sharedSession()
    let dataTask = urlSession.dataTaskWithRequest(urlRequest, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
        let json = JSON(data: data, options: nil, error: nil)
        let foundWeather = weatherFromJson(json)
        
        completion(weather: foundWeather)
    })
    
    dataTask.resume()
}

func weatherFromJson(serverJson: JSON) -> Weather {
    let cityName = serverJson["city"]["name"].string
    
    var forecasts = [ForecastDay]()
    for (index: String, subJson: JSON) in serverJson["list"] {
        var date = NSDate(timeIntervalSince1970: subJson["dt"].doubleValue)
        var high = subJson["temp"]["max"].doubleValue
        var low = subJson["temp"]["min"].doubleValue
        var humidity = (subJson["humidity"].doubleValue / 100)
        
        var condition: WeatherCondition?
        var conditionText = subJson["weather"][0]["main"].string
        if conditionText == "Rain" {
            condition = WeatherCondition.Rain
        } else if conditionText == "Clouds" {
            condition = WeatherCondition.Clouds
        } else if conditionText == "Clear" {
            condition = WeatherCondition.Clear
        }
        
        var forecast = ForecastDay(date: date, highTemp: high, lowTemp: low, condition: condition, humidity: humidity)
        forecasts.append(forecast)
    }
    
    var cityWeather = Weather(name: cityName, forecast: forecasts)
    return cityWeather
}