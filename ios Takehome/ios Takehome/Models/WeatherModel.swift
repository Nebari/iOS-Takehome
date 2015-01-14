//
//  WeatherModel.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import UIKit

func kelvinToFahrenheit(degreesKelvin: Double) -> Double {
    let step1 = degreesKelvin - 273.15
    let step2 = step1 * 1.8
    return (step2 + 32)
}

enum WeatherCondition: String {
    case Clear = "Clear"
    case Rain = "Rain"
    case Clouds = "Clouds"
    
    func icon () -> UIImage? {
        var conditionImage: UIImage?
        switch self {
        case .Clear:
            if let clearImage = UIImage(named: "Clear") {
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
    var name: String
    var forecast: [ForecastDay]
}

struct ForecastDay {
    var date: NSDate
    var highTemp: Double
    var lowTemp: Double
    var condition: WeatherCondition
    var humidity: Double
}