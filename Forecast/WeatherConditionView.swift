//
//  WeatherConditionView.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/9/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class WeatherConditionView: UIView {

    @IBOutlet weak var dayLabel:UILabel?
    @IBOutlet weak var iconLabel:UILabel!
    @IBOutlet weak var degreeLabel:UILabel!
    
    var weatherCondition: WeatherCondition? {
        get { return self.weatherCondition }
        
        //Fills the UI with the new data
        set(newCondition) {
            self.dayLabel?.text = newCondition!.day
            self.iconLabel.text = newCondition!.iconChar
            self.degreeLabel.text = "\(newCondition!.degrees)\(newCondition!.unit)"
        }
    }
}
