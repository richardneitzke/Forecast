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
                
                for i in 0...6 {
                    if json["Days"][i]["date"].stringValue != yesterdayFormatted {
                        dailyConditions.append(DailyCondition(json: json["Days"][i]))
                    }
                }
                
                onSuccess(dailyConditions)
            }
            
        })
        
    }
    
}