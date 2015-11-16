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
    @IBOutlet weak var iconLabel:UILabel?
    @IBOutlet weak var degreeLabel:UILabel?
    
    @IBOutlet weak var minDegreeLabel:UILabel?
    @IBOutlet weak var maxDegreeLabel:UILabel?
    @IBOutlet weak var precipitationLabel:UILabel?
    @IBOutlet weak var windSpeedLabel:UILabel?
    
    var weatherConditionStorage:WeatherCondition?
    var weatherCondition: WeatherCondition? {
        
        //Returns the stored WeatherCondition
        get { return weatherConditionStorage }
        
        //Fills the UI with the new data and stores it
        set(newCondition) {
            
            self.dayLabel?.text = newCondition!.day
            self.iconLabel?.text = newCondition!.iconChar
            self.degreeLabel?.text = "\(newCondition!.maxDegrees)\(newCondition!.tempUnit)"
            minDegreeLabel?.text = "\(newCondition!.minDegrees)\(newCondition!.tempUnit)"
            maxDegreeLabel?.text = "\(newCondition!.maxDegrees)\(newCondition!.tempUnit)"
            precipitationLabel?.text = "\(newCondition!.precipitation)%"
            windSpeedLabel?.text = "\(newCondition!.windSpeed) \(newCondition!.windUnit)"
            
            if newCondition!.currDeg != nil {self.degreeLabel?.text = "\(newCondition!.currDeg!)\(newCondition!.tempUnit)"}
            
            //Stores the WeatherCondition
            self.weatherConditionStorage = newCondition!
        }
    }
}
