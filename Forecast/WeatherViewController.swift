//
//  WeatherViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/21/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var tempLabel: UILabel!
    
    var tempUnit = "f"
    
    var dailyCondition: DailyCondition? {
        didSet {
            tempLabel.text = "\(dailyCondition!.maxTemp(tempUnit))°"
        }
    }
    
    
}