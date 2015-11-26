//
//  APIManager.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/20/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class APIManager {
    
    func fetchWeatherData(location:CLLocation, onSuccess:([DailyCondition])->Void, onFail:(NSError)->Void) {
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        //Please use your own data in case you use this code in your own project
        let parameters = ["app_id": "740b6fea", "app_key": "981b5da0e38085669dd4714a72db3981"]
        
        Alamofire.request(.GET, "http://api.weatherunlocked.com/api/forecast/\(lat),\(lon)", parameters: parameters, headers: ["Accept":"application/json"]).responseJSON(completionHandler: { result in
            
            print(result.request)
            
            if let error = result.result.error { onFail(error) } else {
                                
                var dailyConditions = [DailyCondition]()
                let json = JSON(result.result.value!)
                
                let yesterday = NSDate().dateByAddingTimeInterval(NSTimeInterval(-86400))
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let yesterdayFormatted = dateFormatter.stringFromDate(yesterday)
                
                var minTempWeekC = Int.max
                var maxTempWeekC = Int.min
                
                var minTempWeekF = Int.max
                var maxTempWeekF = Int.min
                
                for i in 0...6 {
                    if json["Days"][i]["date"].stringValue != yesterdayFormatted {
                        dailyConditions.append(DailyCondition(json: json["Days"][i]))
                    }
                }
                
                for i in 0..<dailyConditions.count {
                    if dailyConditions[i].minTemp("c") < minTempWeekC { minTempWeekC = dailyConditions[i].minTemp("c") }
                    if dailyConditions[i].maxTemp("c") > maxTempWeekC { maxTempWeekC = dailyConditions[i].maxTemp("c") }
                    
                    if dailyConditions[i].minTemp("f") < minTempWeekF { minTempWeekF = dailyConditions[i].minTemp("f") }
                    if dailyConditions[i].maxTemp("f") > maxTempWeekF { maxTempWeekF = dailyConditions[i].maxTemp("f") }
                }
                
                for i in 0..<dailyConditions.count {
                    dailyConditions[i].minTempWeekC = minTempWeekC
                    dailyConditions[i].maxTempWeekC = maxTempWeekC

                    dailyConditions[i].minTempWeekF = minTempWeekF
                    dailyConditions[i].maxTempWeekF = maxTempWeekF
                }
                
                for i in 0..<dailyConditions.count - 1 {
                    dailyConditions[i].nextDayFirstTempC = dailyConditions[i + 1].json["Timeframes"].array!.first!["temp_c"].intValue
                    dailyConditions[i].nextDayFirstTempF = dailyConditions[i + 1].json["Timeframes"].array!.first!["temp_f"].intValue
                }
                
                onSuccess(dailyConditions)
            }
            
        })
        
    }
    
}