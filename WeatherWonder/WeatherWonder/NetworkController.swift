//
//  NetworkController.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/14/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import Foundation

class NetworkController {
   // Added an API key
  let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Seattle&units=imperial&cnt=7&APPID=3e15652a662d33a186fdcf5567cf1f66"
  let networkQueue = NSOperationQueue()

  func getJSONForForecasts(completionHandler : (forecasts: [Forecast]) ->(Void)) {
    self.fetchJSONFromURL(self.apiURL, completionHandler: { (dataFromURL) -> (Void) in
      let parser = JsonParser()
      var forecasts = parser.parseJSONIntoForecasts(dataFromURL)
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(forecasts: forecasts)
      })
    })
  }

  func fetchJSONFromURL(aURL: String, completionHandler : (dataFromURL: NSData) -> (Void)) {
    let fetchURL = NSURL(string: aURL)
    let fetchSession = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: fetchURL!)
    request.HTTPMethod = "GET"

    let dataTask = fetchSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      let dataFromRequest = data as NSData
      if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200:
          completionHandler(dataFromURL: dataFromRequest)
        default:
          println("ERROR: Bad response")
          completionHandler(dataFromURL: dataFromRequest)
        }
      } else {
        println("NO RESPONSE------")
      }
    })
    dataTask.resume()
  }

} // End
