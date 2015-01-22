//
//  ViewController.swift
//  IOS-Takehome
//
//  Created by Darrell Nicholas on 1/20/15.
//  Copyright (c) 2015 Darrell Nicholas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var forecastList = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?id=4641239&&units=imperial&cnt=7&APPID=0538b5c2faac4f9b91cdb9da89f00437"
        var nsURL = NSURL(string: url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            var feedDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            self.forecastList = feedDict["list"]! as NSMutableArray
            self.tableView.reloadData()
        }
        task.resume()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func imageForWeather(code:Int) -> UIImage? {
        switch code {
        case 200...799, 900...906:
            return UIImage(named: "Rainy")
        case 801...804:
            return UIImage(named: "Cloudy")
        default:
            return UIImage(named: "Sunny")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "weatherCell"
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        // Get position in forecastList for cell
        let listRow = forecastList[indexPath.row] as NSDictionary
        // Get Unix timestamp from api
        let timeStampUnix: Double = listRow.valueForKey("dt") as Double
        // convert it to an NSDate
        let date = NSDate(timeIntervalSince1970: timeStampUnix)
        // create an NSDateFormatter
        var formatter = NSDateFormatter()
        // 4 'E's makes the day of the week spell itself out completely.
        formatter.dateFormat = "EEEE"
        // set the text of the dayLabel
        if let dayLabel = cell.viewWithTag(3) as? UILabel {
            dayLabel.text = "\(formatter.stringFromDate(date))"
        }
        // set the image based on weather codes using self.imageForWeather
        if let weatherImageView = cell.viewWithTag(2) as? UIImageView {
            var codeArray = listRow.valueForKey("weather") as NSArray
            var codeDictionary = codeArray.objectAtIndex(0) as NSDictionary
            var code = codeDictionary["id"] as Int
            weatherImageView.image = self.imageForWeather(code)

        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            var detailVC = segue.destinationViewController as DayDetailViewController
            var path:NSIndexPath = tableView.indexPathForSelectedRow()!
            var list = forecastList.objectAtIndex(path.row) as NSDictionary
            
            let timeStampUnix: Double = list.valueForKey("dt") as Double
            
            let date = NSDate(timeIntervalSince1970: timeStampUnix)
            
            var formatter = NSDateFormatter()
            
            formatter.dateFormat = "EEEE"
            
            var dayString = "\(formatter.stringFromDate(date))"
            detailVC.day = dayString
            var codeArray = list.valueForKey("weather") as NSArray
            var codeDictionary = codeArray.objectAtIndex(0) as NSDictionary
            var code = codeDictionary["id"] as Int
            detailVC.weatherCode = code
            
            var humidity = list.valueForKey("humidity") as Int
            detailVC.humidity = humidity
            
            var tempDict = list.valueForKey("temp") as NSDictionary
            var hiTemp = tempDict["max"] as Int
            detailVC.hiTemp = hiTemp
            
            var loTemp = tempDict["min"] as Int
            detailVC.lowTemp = loTemp
            
            
        }
    }
}

