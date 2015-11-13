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
                
                //Requesting Data from Server
                //Register at developer.forecast.io for your own API-Key. Please don't use this key if you're using this code in your own project.
                
                Alamofire.request(.GET, "https://api.forecast.io/forecast/12558c284449ff431b6f91235f6f669d/\(lat),\(lon)").responseJSON(completionHandler: {response in
                    
                    //Checking for successful Response
                    if response.result.value != nil {
                        
                        print("Server responded! Compiling Raw Data to [CurrentWeatherData]...")
                        
                        let json = JSON(response.result.value!)
                        
                        let currDeg = json["currently"]["temperature"].doubleValue
                        let currUnt = json["flags"]["units"].stringValue
                        let currIcn = json["currently"]["icon"].stringValue
                        let currTim = json["currently"]["time"].stringValue
                        
                        weatherConditions.append(WeatherCondition(degrees: currDeg, units: currUnt, icon: currIcn, time: currTim))
                        
                        for i in 1...5 {
                            let deg = json["daily"]["data"][i]["temperatureMax"].doubleValue
                            let unt = json["flags"]["units"].stringValue
                            let icn = json["daily"]["data"][i]["icon"].stringValue
                            let tim = json["daily"]["data"][i]["time"].stringValue
                            
                            let weather = WeatherCondition(degrees: deg, units: unt, icon: icn, time: tim)
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