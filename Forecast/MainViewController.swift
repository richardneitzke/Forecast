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
import PKHUD

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
            weatherVC.view.backgroundColor = UIColor.clearColor()
            
            let dayNumber = NSCalendar.currentCalendar().components(.Weekday, fromDate: NSDate().dateByAddingTimeInterval(Double(86400 * i))).weekday
            
            switch dayNumber {
            case 1: weatherVC.title = "SUN"
            case 2: weatherVC.title = "MON"
            case 3: weatherVC.title = "TUE"
            case 4: weatherVC.title = "WED"
            case 5: weatherVC.title = "THU"
            case 6: weatherVC.title = "FRI"
            case 7: weatherVC.title = "SAT"
            default: weatherVC.title = "ERR"
            }
            
            viewControllerArray.append(weatherVC)
        }
        
        var parameters: [CAPSPageMenuOption] = [
            CAPSPageMenuOption.ViewBackgroundColor(UIColor.clearColor()),
            CAPSPageMenuOption.ScrollMenuBackgroundColor(UIColor.clearColor()),
            CAPSPageMenuOption.UnselectedMenuItemLabelColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)),
            CAPSPageMenuOption.MenuItemWidth(50),
            CAPSPageMenuOption.CenterMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: viewControllerArray, frame: CGRectMake(0.0, 20.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self
        self.view.addSubview(pageMenu!.view)
        
        refresh()
        
    }
    
    func refresh() {
        
        let errorHandler: (NSError?) -> Void = { error in
            PKHUD.sharedHUD.contentView = PKHUDErrorView()
            PKHUD.sharedHUD.hide(afterDelay: 2)
            print("Error: \(error!.localizedDescription)")
        }
        
        let successFetchWeatherDataHandler: ([DailyCondition]) -> Void = { dailyConditions in
            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            PKHUD.sharedHUD.hide(afterDelay: 2)
            
            for i in 0...5 { self.viewControllerArray[i].dailyCondition = dailyConditions[i] }
            
            print(dailyConditions[0].maxTempWeek("f"))
        }
        
        let successLocationHandler: (CLLocation?) -> Void = { location in
            print("Successfully fetched location!")
            apiManager.fetchWeatherData(location!, onSuccess: successFetchWeatherDataHandler, onFail: errorHandler)
        }
        
        print("Refreshing...")
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        try! SwiftLocation.shared.currentLocation(.Neighborhood, timeout: 15, onSuccess: successLocationHandler, onFail: errorHandler)
        }
    
    func changeBackgroundColor(color: UIColor) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.backgroundColor = color
        })
    }
    
}