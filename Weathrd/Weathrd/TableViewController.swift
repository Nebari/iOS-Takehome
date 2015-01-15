//
//  TableViewController.swift
//  Weathrd
//
//  Created by Jordan Nelson on 1/14/15.
//  Copyright (c) 2015 LunarBoxx. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource {
    
    let kCellID = "WeatherCell"
    var forecastDataSource: NSArray!

    // Mark: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var currentForecast: Forecast = forecastDataSource.objectAtIndex(indexPath.row) as Forecast
        var description = currentForecast.weather.objectForKey("description") as String
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as? UITableViewCell
        
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: kCellID)
        }
        
        cell?.textLabel?.text = description

        if description == "sky is clear" {
            cell?.imageView?.image = UIImage(named: "Sunny")
        } else if description == "heavy intensity rain" {
            cell?.imageView?.image = UIImage(named: "Rainy")
        } else if description == "light rain" {
            cell?.imageView?.image = UIImage(named: "Rainy")
        } else {
            cell?.imageView?.image = UIImage(named: "Cloudy")
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        self.performSegueWithIdentifier("showForecastDetail", sender: tableView.cellForRowAtIndexPath(indexPath))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // Mark: Helper Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showForecastDetail" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            var selectedIndex = indexPath?.row
            
            let detailViewController: DetailViewController = segue.destinationViewController as DetailViewController
            detailViewController.forecast = forecastDataSource.objectAtIndex(selectedIndex!) as Forecast
        }
    }

}
