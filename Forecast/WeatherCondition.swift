//
//  WeatherCondition.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/9/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import UIKit

class WeatherCondition {
    
    var degrees:Int
    var unit:String
    var iconChar:String
    var day:String
    var color:UIColor
    
    //Builds a WeatherCondition from certain API-Data
    init(degrees:Double,units:String,icon:String,time:String) {
        
        self.degrees = Int(degrees)
        
        switch units {
        case "us": self.unit = "°F"
        default: self.unit = "°C"
        }
        
        switch icon {
        case "clear-day":           self.iconChar = "\u{f00d}"
        case "clear-night":         self.iconChar = "\u{f02e}"
        case "rain":                self.iconChar = "\u{f019}"
        case "snow":                self.iconChar = "\u{f01b}"
        case "sleet":               self.iconChar = "\u{f0b5}"
        case "wind":                self.iconChar = "\u{f050}"
        case "fog":                 self.iconChar = "\u{f014}"
        case "cloudy":              self.iconChar = "\u{f013}"
        case "partly-cloudy-day":   self.iconChar = "\u{f002}"
        case "partly-cloudy-night": self.iconChar = "\u{f086}"
        case "hail":                self.iconChar = "\u{f015}"
        case "thunderstorm":        self.iconChar = "\u{f01e}"
        case "tornado":             self.iconChar = "\u{f056}"
        default:                    self.iconChar = "\u{f055}"
        }
        
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time)!)
        let dayNumber = NSCalendar.currentCalendar().components(.Weekday, fromDate: date).weekday
        
        switch dayNumber {
        case 1: self.day = "SUN"
        case 2: self.day = "MON"
        case 3: self.day = "TUE"
        case 4: self.day = "WED"
        case 5: self.day = "THU"
        case 6: self.day = "FRI"
        case 7: self.day = "SAT"
        default: self.day = "ERR"
        }

        var tempCelsius = degrees
        if unit == "°F" { tempCelsius = (degrees-32)/(9/5) }
        
        switch tempCelsius {
        case (35)...(300): color = UIColor(hue: 10.0/360.0, saturation: 0.74, brightness: 1, alpha: 1)
        case (30)...(35): color = UIColor(hue: 26.0/360.0, saturation: 0.74, brightness: 1, alpha: 1)
        case (20)...(30): color = UIColor(hue: 47.0/360.0, saturation: 0.74, brightness: 1, alpha: 1)
        case (15)...(20): color = UIColor(hue: 144.0/360.0, saturation: 0.70, brightness: 0.71, alpha: 1)
        case (5)...(15): color = UIColor(hue: 180.0/360.0, saturation: 0.65, brightness: 0.74, alpha: 1)
        case (-5)...(5): color = UIColor(hue: 190.0/360.0, saturation: 0.84, brightness: 0.76, alpha: 1)
        default: color = UIColor.blackColor()
        }
        }
        
        
    }
    
    
