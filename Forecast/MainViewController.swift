//
//  MainViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/21/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import UIKit
import SwiftLocation
import CoreLocation

let apiManager = APIManager()

class MainViewController: UIViewController, CAPSPageMenuDelegate {
    
    @IBAction func refreshPressed(sender: UIBarButtonItem) { refresh() }
    
    var pageMenu: CAPSPageMenu?
    var viewControllerArray = [WeatherViewController]()
    
    override func viewDidLoad() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor as CGColorRef
        let color2 = UIColor(red: 1, green: 1, blue: 1, alpha: 0).CGColor as CGColorRef
        let color3 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3]
        
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        for i in 0...5 {
            let weatherVC = WeatherViewController()
            weatherVC.title = "Weekday"
            viewControllerArray.append(weatherVC)
        }
        
        var parameters: [CAPSPageMenuOption] = [
            CAPSPageMenuOption.ViewBackgroundColor(UIColor.clearColor()),
            CAPSPageMenuOption.ScrollMenuBackgroundColor(UIColor.clearColor()),
            CAPSPageMenuOption.UnselectedMenuItemLabelColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5))
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: viewControllerArray, frame: CGRectMake(0.0, 20.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self
        self.view.addSubview(pageMenu!.view)
        
        refresh()
        
    }
    
    func refresh() {
        
        let errorHandler: (NSError?) -> Void = { error in print("Error: \(error!.localizedDescription)") }
        
        let successFetchWeatherDataHandler: ([DailyCondition]) -> Void = { dailyConditions in
            print("Received weather data!")
            
            for i in 0...5 {
                self.viewControllerArray[i].dailyCondition = dailyConditions[i]
            }
        }
        
        let successLocationHandler: (CLLocation?) -> Void = { location in
            print("Successfully fetched location!")
            apiManager.fetchWeatherData(location!, onSuccess: successFetchWeatherDataHandler, onFail: errorHandler)
        }
        
        print("Refreshing...")
        try! SwiftLocation.shared.currentLocation(.Neighborhood, timeout: 15, onSuccess: successLocationHandler, onFail: errorHandler)
        }
    
    func changeBackgroundColor(color: UIColor) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.backgroundColor = color
        })
    }
    
}