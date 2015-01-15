//
//  Forecast.swift
//  Weathrd
//
//  Created by Jordan Nelson on 1/14/15.
//  Copyright (c) 2015 LunarBoxx. All rights reserved.
//

import Foundation

class Forecast {
    
    
//    {
//    clouds = 8;
//    deg = 99;
//    dt = 1421265600;
//    humidity = 79;
//    pressure = "975.34";
//    speed = "2.07";
//    temp =     {
//    day = "30.54";
//    eve = "30.54";
//    max = "30.54";
//    min = "26.51";
//    morn = "30.54";
//    night = "26.69";
//    };
//    weather =     (
//    {
//    description = "sky is clear";
//    icon = 02n;
//    id = 800;
//    main = Clear;
//}
//);
//}

    // Instance variables - constants so they can't be changed
    let clouds: NSString!
    let deg: NSString!
    let rain: NSString!
    let temp: NSDictionary!
    let weather: NSDictionary!

    // Custom initializer
    init(clouds: NSString!, deg: NSString!, rain: NSString!, temp: NSDictionary!, weather: NSDictionary!)
    {
        self.clouds = clouds
        self.deg = deg
        self.rain = rain
        self.temp = NSDictionary(dictionary: temp)
        self.weather = NSDictionary(dictionary: weather)
    }
}
