//
//  WeatherModel.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import UIKit

enum WeatherCondition: String {
    case Clear = "Clear"
    case Rain = "Rain"
    case Clouds = "Clouds"
    
    func icon () -> UIImage? {
        var conditionImage: UIImage?
        switch self {
        case .Clear:
            let icon = UIImage(named: "Clear")
            if let clearImage = icon {
                conditionImage = clearImage
            }
            
        case .Rain:
            if let rainImage = UIImage(named: "Rain") {
                conditionImage = rainImage
            }
            
        case .Clouds:
            if let cloudsImage = UIImage(named: "Clouds") {
                conditionImage = cloudsImage
            }
        }
        return conditionImage
    }
}

struct Weather {
    var name: String?
    var forecast: [ForecastDay]?
}

//Has to be a class in order to be passed in a segue (needs to be a reference type)
class ForecastDay {
    var date: NSDate?
    var highTemp: Double?
    var lowTemp: Double?
    var condition: WeatherCondition?
    var humidity: Double?
    
    init(date: NSDate?, highTemp: Double?, lowTemp: Double?, condition: WeatherCondition?, humidity: Double?) {
        self.date = date
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.condition = condition
        self.humidity = humidity
    }
    
    func formattedDateString() -> String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, M/d"
        return formatter.stringFromDate(date!)
    }
}