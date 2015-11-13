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
    var delegate: WeatherViewController?
    
    //Tries to fetch the Forecast for 5 days from forecast.io
    func fetchForecast(delegate: WeatherViewController) {
        
        self.delegate = delegate
        
        print("Trying to locate phone...")
        
        //Tries to locate the phone for location-based Forecast
        locationManager = OneShotLocationManager()
        locationManager!.fetchWithCompletion {location, error in
            if location != nil {
                
                print("Location found! Trying to request weather data...")
                
                //Saves location for API-Use
                let lat = location!.coordinate.latitude
                let lon = location!.coordinate.longitude
                
                //Requesting Server for Data
                //Register at developer.forecast.io for your own API-Key. Please don't use this key if you're using this code.
                Alamofire.request(.GET, "https://api.forecast.io/forecast/12558c284449ff431b6f91235f6f669d/\(lat),\(lon)").responseJSON(completionHandler: {response in
                    
                    //Checking for successful Result
                    if response.result.value != nil {
                        
                        print("Server responded! Compiling Raw Data to [CurrentWeatherData]...")
                        
                        let json = JSON(response.result.value!)
                        var weatherConditions = [WeatherCondition]()
                        
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
                        
                        print("Success! Delegating Data to ViewController...")
                        self.delegate!.showData(weatherConditions)
                        
                    } else {
                        print("Error while requesting weather data:")
                        print(response.result.error?.localizedDescription)
                    }
                    
                })

                
            } else if error != nil {
                print("Error while fetching location:")
                print(error!.localizedDescription)
            }
            self.locationManager = nil
        }

    }
    
}