//
//  WeatherCell.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/14/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

  @IBOutlet weak var forecastImage: UIImageView!
  @IBOutlet weak var forecastLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
