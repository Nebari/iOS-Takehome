//
//  JsonParser.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/14/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import Foundation

class JsonParser {

  func parseJSONIntoForecasts(rawJSONData: NSData) -> [Forecast] {
    var error : NSError?

    if let dictionaryFromJSON = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {
      var arrayOfForecasts = [Forecast]()

      if let arrayFromJSON = dictionaryFromJSON["list"]! as? NSArray {
        for JSONDictionary in arrayFromJSON {
          if let forecastDictionary = JSONDictionary as? NSDictionary {
            var weatherArray = forecastDictionary["weather"] as NSArray!
            let weatherDictionary = weatherArray.firstObject as NSDictionary!
            let tempDictionary = forecastDictionary["temp"] as [String: AnyObject]
              // Create and cast values to initialize Forecast
            let forecastDateCode = forecastDictionary["dt"] as Double
            let ForecastDay = self.parseDateCodeIntoDay(forecastDateCode)
            let forecastIDCode = weatherDictionary["id"] as Int
            let forecastID = self.parseWeatherTypeIntoForecastType(forecastIDCode)
            let forecastHumidity = forecastDictionary["humidity"] as Int
            let forecastMax = tempDictionary["max"] as Int
            let forecastMin = tempDictionary["min"] as Int

            var newForecast = Forecast(day: ForecastDay, weatherID: forecastID, humidity: forecastHumidity, maxTemp: forecastMax, minTemp: forecastMin)
            arrayOfForecasts.append(newForecast)
          }
        }
        return arrayOfForecasts
      }
    }
      // Return a blank forecast to signal failed parse to ViewController
      // For potential error handling
    let blankForecast = self.createBlankForecast()
    return blankForecast
  }

  func createBlankForecast() -> [Forecast] {
    var blankForecast = [Forecast]()
    var noForecast = Forecast(day: "NONE", weatherID: "sunny", humidity: 0, maxTemp: 0, minTemp: 0)
    blankForecast.append(noForecast)
    return blankForecast
  }

  func parseDateCodeIntoDay(dateCode: Double) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEEE"
    var aDate = NSDate(timeIntervalSince1970: NSTimeInterval(dateCode))
    let dateForForecast = formatter.stringFromDate(aDate)
    return dateForForecast
  }

  func parseWeatherTypeIntoForecastType(forecastIDCode: Int) -> String {
    switch forecastIDCode {
    case 200...622, 771, 781, 900...902, 905, 906:
      return "rainy"
    case 700...762, 802...804:
      return "cloudy"
    case 800...801:
      return "sunny"
    default:
      return "sunny"
    }
  }

} // End
