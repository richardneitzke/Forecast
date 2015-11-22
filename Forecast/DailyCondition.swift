//
//  DailyCondition.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/20/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import SwiftyJSON

class DailyCondition {
    
    let json:JSON
    init(json: JSON) { self.json = json }
    
    func maxTemp(unit: String) -> Int { return json["temp_max_\(unit)"].intValue }
    func minTemp(unit: String) -> Int { return json["temp_min_\(unit)"].intValue }
    
    func probabilityPercip() -> Int { return json["prob_precip_pct"].intValue }
    func totalPercip(unit: String) -> Int {return json["precip_total_\(unit)"].intValue }
    
    func maxWindSpeed(unit: String) -> Int { return json["windspd_max_\(unit)"].intValue }
    
    func date() -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.dateFromString(json["date"].stringValue)
        return date!
    }
    
    func weekday(short: Bool) -> String {
        let dayNumber = NSCalendar.currentCalendar().components(.Weekday, fromDate: date()).weekday
        
        if short {
            switch dayNumber {
            case 1: return "SUN"
            case 2: return "MON"
            case 3: return "TUE"
            case 4: return "WED"
            case 5: return "THU"
            case 6: return "FRI"
            case 7: return "SAT"
            default: return "ERR"
                
            } } else {
            
            switch dayNumber {
            case 1: return "Sunday"
            case 2: return "Monday"
            case 3: return "Tuesday"
            case 4: return "Wednesday"
            case 5: return "Thurday"
            case 6: return "Friday"
            case 7: return "Saturday"
            default: return "ERROR"
            } }
        
    }
    
    func timeframes(unit: String) -> ([String], [Int]) {
        
        var times = [String]()
        var temperatures = [Int]()
        
        for i in 0..<json["Timeframes"].count {
            
            let timeInt = json["Timeframes"][i]["time"].intValue
            let hours = timeInt / 100
            times.append("\(hours):00")
            
            temperatures.append(json["Timeframes"][i]["temp_\(unit)"].intValue)
        }
        
        return (times, temperatures)
        
    }
    

}