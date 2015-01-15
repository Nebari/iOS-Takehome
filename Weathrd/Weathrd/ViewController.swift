//
//  ViewController.swift
//  Weathrd
//
//  Created by Jordan Nelson on 1/14/15.
//  Copyright (c) 2015 LunarBoxx. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var checkForecastButton: UIButton!
    
    // Lazy Instantiation
    var forecastData: NSMutableArray = {
        var tmpData = NSMutableArray()
        return tmpData
    }()

    // Mark: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForecastButton.enabled = false
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Seattle&units=imperial&cnt=7")!)
        
        // Get the datas
        getForecast(request, callback: { (data, error) -> Void in
            if error != nil {
                println("Failure!")
            } else {
                println("Success!")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Mark: Helper Methods
    
    
    func getForecast(request: NSURLRequest!, callback: (String, String?) -> Void) {
        // NSURLSession / Configuration
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                var results = NSString(data: data, encoding: NSASCIIStringEncoding)!
                callback(results, nil)
                
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: NSErrorPointer()) as NSDictionary
                
                println(jsonData)
                
                var forecastList: NSArray = jsonData.objectForKey("list") as NSArray
                
                for object in forecastList {
                    // This should be pulled into it's own method
                    var dictionary = object as NSDictionary
                    var clouds = dictionary.objectForKey("clouds")?.stringValue
                    var rain = dictionary.objectForKey("rain")?.stringValue
                    var deg = dictionary.objectForKey("deg")?.stringValue
                    var temp = dictionary.objectForKey("temp") as NSDictionary
                    var weatherArray = dictionary.objectForKey("weather") as NSArray
                    var weather = weatherArray[0] as NSDictionary

                    var newForecast: Forecast = Forecast(clouds: clouds, deg: deg, rain: rain, temp: temp, weather: weather)
                    
                    self.forecastData.addObject(newForecast)
                }
                
                // Update the UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.checkForecastButton.enabled = true
                })
            }
        });
        
        // Start
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showForecast" {
            let tableViewController: TableViewController = segue.destinationViewController as TableViewController
            tableViewController.forecastDataSource = self.forecastData
        }
    }
}

