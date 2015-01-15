//
//  DetailViewController.swift
//  Weathrd
//
//  Created by Jordan Nelson on 1/14/15.
//  Copyright (c) 2015 LunarBoxx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // IBOutlets

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    
    var forecast: Forecast!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        // Finish setting up UI here
        var description = forecast.weather.objectForKey("description") as String
        var tempMax = forecast.temp.objectForKey("max") as Double
        
        if description == "sky is clear" {
            forecastImage.image = UIImage(named: "Sunny")
        } else if description == "heavy intensity rain" {
            forecastImage.image = UIImage(named: "Rainy")
        } else if description == "light rain" {
            forecastImage.image = UIImage(named: "Rainy")
        } else {
            forecastImage.image = UIImage(named: "Cloudy")
        }
        

        labelOne.text = "Forecast:  \(description)"
        labelTwo.text = "High \(tempMax) degrees"
        labelThree.text = "Cloudiness \(forecast.clouds)%"
        labelFour.text = "Chance of rain \(forecast.rain)%"
    }

}
