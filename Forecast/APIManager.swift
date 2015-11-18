//
//  APIManager.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/9/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire

class APIManager {
    
    var locationManager: OneShotLocationManager?
    
    //Tries to fetch the Forecast from forecast.io
    func fetchForecast(callback:([WeatherCondition])->()) {
        
        //Empty [WeatherCondition] which is to be filled with data
        var weatherConditions = [WeatherCondition]()
        
        print("Trying to locate phone...")
        
        //Tries to locate the phone for location-based Forecast
        locationManager = OneShotLocationManager()
        locationManager!.fetchWithCompletion {location, error in
            if location != nil {
                
                print("Location found! Trying to request weather data...")
                
                //Saves location for API-Use
                let lat = location!.coordinate.latitude
                let lon = location!.coordinate.longitude
                
                //Looks up the user-preffered units
                let defaults = NSUserDefaults.standardUserDefaults()
                let unitValue = defaults.valueForKey("unit") as? String
                var prefUnitSet = "auto"
                switch unitValue {
                case "us"?: prefUnitSet = "us"
                case "si"?: prefUnitSet = "si"
                default: defaults.setValue("auto", forKey: "unit")
                }
                
                //Requesting Data from Server
                //Register at developer.forecast.io for your own API-Key. Please don't use this key if you're using this code in your own project.
                
                Alamofire.request(.GET, "https://api.forecast.io/forecast/12558c284449ff431b6f91235f6f669d/\(lat),\(lon)?extend=hourly&units=\(prefUnitSet)").responseJSON(completionHandler: {response in
                    
                    //Checking for successful Response
                    if response.result.value != nil {
                        
                        print("Server responded! Compiling Raw Data to [CurrentWeatherData]...")
                        print(response.request!)
                        
                        let json = JSON(response.result.value!)
                        
                        let currDeg = json["currently"]["temperature"].doubleValue
                        let currMaxDeg = json["daily"]["data"][0]["temperatureMax"].doubleValue
                        let currUnt = json["flags"]["units"].stringValue
                        let currIcn = json["currently"]["icon"].stringValue
                        let currTim = json["currently"]["time"].stringValue
                        let currMinDeg = json["daily"]["data"][0]["temperatureMin"].doubleValue
                        let currPrecip = json["daily"]["data"][0]["precipProbability"].doubleValue
                        let currWind = json["daily"]["data"][0]["windSpeed"].doubleValue
                        let currDesc = json["daily"]["data"][0]["summary"].stringValue

                        let offset = json["offset"].intValue
                        
                        //Determines the current Time of the day in order to display the right graph later
                        let offsetCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                        offsetCalendar.timeZone = NSTimeZone(forSecondsFromGMT: offset*60*60)
                        
                        let currentDate = NSDate(timeIntervalSince1970: NSTimeInterval(currTim)!).dateByAddingTimeInterval(NSTimeInterval(offset*60*60))
                        let tomorrow = currentDate.dateByAddingTimeInterval(NSTimeInterval("86400")!)
                        let startOfTomorrow = offsetCalendar.startOfDayForDate(tomorrow).dateByAddingTimeInterval(NSTimeInterval(offset*60*60))
            
                        let hoursTillMidnight = startOfTomorrow.hoursFrom(currentDate)
                        let hoursPassed = 23 - hoursTillMidnight
                        
                        
                        //Only adds the coming hours, as the past hours are not provided for the current day
                        var currTemperatures = [Double](count: 24, repeatedValue: Double.infinity)
                        for i in 0...23 {
                            if i >= hoursPassed {
                                currTemperatures[i] = json["hourly"]["data"][i - hoursPassed]["temperature"].doubleValue
                            }
                        }
                        
                        
                        weatherConditions.append(WeatherCondition(maxDegrees: currMaxDeg, units: currUnt, icon: currIcn, time: currTim, minDegrees: currMinDeg, windSpeed: currWind, precipitation: currPrecip, currDeg: currDeg, description: currDesc, temperatures: currTemperatures))
                        
                        for i in 1...5 {
                            let maxDeg = json["daily"]["data"][i]["temperatureMax"].doubleValue
                            let unt = json["flags"]["units"].stringValue
                            let icn = json["daily"]["data"][i]["icon"].stringValue
                            let tim = json["daily"]["data"][i]["time"].stringValue
                            let minDeg = json["daily"]["data"][i]["temperatureMin"].doubleValue
                            let precip = json["daily"]["data"][i]["precipProbability"].doubleValue
                            let wind = json["daily"]["data"][i]["windSpeed"].doubleValue
                            let desc = json["daily"]["data"][i]["summary"].stringValue
                            
                            var temperatures = [Double]()
                            for j in 0...23 { temperatures.append(json["hourly"]["data"][j+(24*i) - hoursPassed]["temperature"].doubleValue) }
                            
                            let weather = WeatherCondition(maxDegrees: maxDeg, units: unt, icon: icn, time: tim, minDegrees: minDeg, windSpeed: wind, precipitation: precip, currDeg: nil, description: desc, temperatures: temperatures)
                            weatherConditions.append(weather)
                        }
                        
                        print("Success! Calling back WeatherController with data...")
                        callback(weatherConditions)
                        
                    } else {
                        print("Error while requesting weather data:")
                        print(response.result.error?.localizedDescription)
                        callback(weatherConditions)
                    }
                    
                })
                
                
            } else if error != nil {
                print("Error while fetching location:")
                print(error!.localizedDescription)
                callback(weatherConditions)
                
            }
            self.locationManager = nil
        }
        
    }
    
}

extension NSDate {

    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: .MatchFirst).hour
    }
}