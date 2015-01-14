//
//  MasterViewController.swift
//  ios Takehome
//
//  Created by Jared Sorge on 1/13/15.
//  Copyright (c) 2015 jsorge.net. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    //MARK: Constants
    let cellId = "WeatherCell"
    
    //MARK: Properties
    var cityWeather = Weather(name: nil, forecast: nil)
    lazy var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        return formatter
        }()
    @IBOutlet var activitySpinner: UIActivityIndicatorView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadSeattleWeatherForNumberOfDays(numberOfDays: 5, { (weather) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.cityWeather = weather
                self.tableView.reloadData()
            })
        })
    }
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeather.forecast?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell
        
        if let forecastArray = cityWeather.forecast {
            let day = forecastArray[indexPath.row]
            
            cell.textLabel?.text = "\(self.dateFormatter.stringFromDate(day.date!))"
        }
        
        return cell
    }
}