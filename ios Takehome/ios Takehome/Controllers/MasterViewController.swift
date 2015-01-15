//
//  MasterViewController.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource {
    //MARK: Constants
    let cellId = "WeatherCell"
    let segue_detail = "ShowForecastDetail"
    
    //MARK: Properties
    var cityWeather = Weather(name: nil, forecast: nil)
    @IBOutlet var activitySpinner: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadSeattleWeatherForNumberOfDays(numberOfDays: 10, { (error: NSError?, weather: Weather?) -> Void in
            if error != nil {
                //Show alert
                println("Weather not retrieved")
                return
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.cityWeather = weather!
                self.tableView.reloadData()
                self.activitySpinner.stopAnimating()
                self.tableView.hidden = false
                self.title = self.cityWeather.name!
            })
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segue_detail {
            assert(sender != nil, "There must be a day passed in.")
            let destination = segue.destinationViewController as DetailViewController
            destination.configureViewWithForecast(sender as ForecastDay)
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeather.forecast?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as ForecastCell
        
        if let forecastArray = cityWeather.forecast {
            let day = forecastArray[indexPath.row]
            
            var dateString = "\(day.formattedDateString())"
            let conditionImage = day.condition?.icon()
            
            cell.configureCell(conditionImage, forDate: dateString)
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let forecastArray = cityWeather.forecast {
            let day = forecastArray[indexPath.row]
            performSegueWithIdentifier(segue_detail, sender: day)
        }
    }
}

class ForecastCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet var conditionImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    func configureCell(conditionImage: UIImage?, forDate dateString: String) {
        self.conditionImage.image = conditionImage ?? nil
        self.dateLabel.text = dateString
    }
}