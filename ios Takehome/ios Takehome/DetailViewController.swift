
//
//  DetailViewController.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: Properties
    private var day: ForecastDay?
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    //MARK: API
    func configureViewWithForecast(forecast: ForecastDay) {
        self.day = forecast
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        if let forecast = self.day {
            if let forecastedCondition = forecast.condition {
                let icon = forecast.condition?.icon()
                self.conditionImageView.image = icon
            }
            
            self.dayLabel.text = forecast.formattedDateString()
            
            if let high = forecast.highTemp {
                self.highLabel.text = "High: \(high)º"
            } else {
                self.highLabel.text = "High Not Available"
            }
            
            if let low = forecast.lowTemp {
                self.lowLabel.text = "Low: \(low)º"
            } else {
                self.lowLabel.text = "Low Not Available"
            }
            
            if let humidity = forecast.humidity {
                self.humidityLabel.text = "Humidity: \(humidity * 100)%"
            } else {
                self.humidityLabel.text = "Humidity Not Available"
            }
        }
    }
}