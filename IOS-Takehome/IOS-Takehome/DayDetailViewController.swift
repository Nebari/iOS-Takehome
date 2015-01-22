//
//  DayDetailViewController.swift
//  IOS-Takehome
//
//  Created by Darrell Nicholas on 1/21/15.
//  Copyright (c) 2015 Darrell Nicholas. All rights reserved.
//

import UIKit

class DayDetailViewController: UIViewController {
    
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var hiTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    var humidity:Int = 0
    var hiTemp = 0
    var lowTemp = 0
    var weatherCode = 0
    var day = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.humidityLabel.text = "\(humidity)%"
        self.hiTempLabel.text = "\(hiTemp)F"
        self.lowTempLabel.text = "\(lowTemp)F"
        weatherImage.image = self.imageForWeather(weatherCode)
        self.dayLabel.text = day
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
