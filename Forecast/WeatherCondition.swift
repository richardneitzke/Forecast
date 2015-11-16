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
    
    //Properties needed by WeatherViewController
    var maxDegrees:Int
    var tempUnit:String
    var iconChar:String
    var day:String
    var color:UIColor
    
    var currDeg:Int?
        
    //Properties needed by DetailWeatherViewController
    var fullDay:String
    var minDegrees:Int
    var precipitation:Int
    var windSpeed:String
    var windUnit:String
    var description:String
    var temperatures:[Double]
    
    //Builds a WeatherCondition from certain API-Data
    init(maxDegrees:Double,units:String,icon:String,time:String, minDegrees:Double, windSpeed:Double, precipitation:Double, currDeg:Double?, description:String, temperatures:[Double]) {
        
        self.temperatures = temperatures
        
        self.minDegrees = Int(minDegrees)
        self.maxDegrees = Int(maxDegrees)
        
        self.precipitation = Int(precipitation*100)
        
        self.windSpeed = String(format: "%.2f", windSpeed)
        
        if let currentDegrees = currDeg {self.currDeg = Int(currentDegrees)}
        
        self.description = description
        
        switch units {
        case "us":
            self.tempUnit = "°F"
            self.windUnit = "mph"
        default:
            self.tempUnit = "°C"
            self.windUnit = "m/s"
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
        
        switch dayNumber {
        case 1: self.fullDay = "Sunday"
        case 2: self.fullDay = "Monday"
        case 3: self.fullDay = "Tuesday"
        case 4: self.fullDay = "Wednesday"
        case 5: self.fullDay = "Thurday"
        case 6: self.fullDay = "Friday"
        case 7: self.fullDay = "Saturday"
        default: self.fullDay = "DAY ERROR"
        }
        

        var tempCelsius = maxDegrees
        if tempUnit == "°F" { tempCelsius = (maxDegrees-32)/(9/5) }
        
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
    
