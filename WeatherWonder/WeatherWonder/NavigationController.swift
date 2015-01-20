//
//  NavigationController.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/17/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

  override func shouldAutorotate() -> Bool {
    // Disabling autoritation in iOS before 8.0 due to limitation of size classes, please see my email
    var versionString : NSString = UIDevice.currentDevice().systemVersion
    var versionNumber = versionString.floatValue
    println("version number is \(versionNumber)")
    if versionNumber < 8.0 {
      return false
    } else {
      return true
    }
  }

} // End
