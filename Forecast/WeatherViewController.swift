//
//  ViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/9/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit
import SwiftOverlays

class WeatherViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let apiManager = APIManager()
    
    @IBOutlet weak var day0: WeatherConditionView!
    @IBOutlet weak var day1: WeatherConditionView!
    @IBOutlet weak var day2: WeatherConditionView!
    @IBOutlet weak var day3: WeatherConditionView!
    @IBOutlet weak var day4: WeatherConditionView!
    @IBOutlet weak var day5: WeatherConditionView!
    
    var days: [WeatherConditionView]!
    
    @IBAction func refreshPressed(sender: UIBarButtonItem) {
        refresh()
    }
    
    override func viewDidLoad() {
        
        //Puts all WeatherConditionViews in an array to make them accessible by loops easier
        days = [day0, day1, day2, day3, day4, day5]
        
        refresh()
        
        setNeedsStatusBarAppearanceUpdate()
        
        //Inserts Background Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 1, green: 1, blue: 1, alpha: 0).CGColor as CGColorRef
        let color2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        //Makes Navigation Bar Transparent
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.barStyle = .BlackTranslucent
        
        //Adds a GestureRecognizer to WeatherConditionViews
        for i in 0...5 { days[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("day\(i)Pressed"))) }
        
    }
    
    //Functions that are called by the TapGestureRecognizers (bad practice; find a better way?)
    func day0Pressed() { dayPressed(0) }
    func day1Pressed() { dayPressed(1) }
    func day2Pressed() { dayPressed(2) }
    func day3Pressed() { dayPressed(3) }
    func day4Pressed() { dayPressed(4) }
    func day5Pressed() { dayPressed(5) }
    
    //Calls the DetailWeatherViewController with the WeatherCondition as sender
    func dayPressed(number:Int) {
        print("WeatherConditionView \(number) pressed!")
        performSegueWithIdentifier("showDetail", sender: days[number].weatherCondition)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Sets the weatherCondition of the DetailWeatherViewController to the pressed one
        if segue.identifier == "showDetail" {
            
            let destinationNavController = segue.destinationViewController as! UINavigationController
            let detailWeatherViewController = destinationNavController.viewControllers.first as! DetailWeatherViewController
            let weatherView = detailWeatherViewController.view as! WeatherConditionView
            
            weatherView.weatherCondition = sender as? WeatherCondition
            
        }
        
        //Sets the SettingsViewControllers delegate to self
        if segue.identifier == "showSettings" {
            
            let destinationNavController = segue.destinationViewController as! UINavigationController
            let settingsViewController = destinationNavController.viewControllers.first as! SettingsViewController
            
            settingsViewController.delegate = self
            
        }
    }
    
    //Refreshes the Data/UI
    func refresh() {
        
        //Callback for putting received Data in the UI
        let refreshCallback: ([WeatherCondition]) -> Void = { weatherConditions in
            
            print("Trying to put received data in the UI...")
            
            SwiftOverlays.removeAllBlockingOverlays()
            
            //Checks for empty array and shows error message in case someting went wrong
            if weatherConditions.isEmpty {
                print("The array is empty! Showing error alert...")
                
                let alert = UIAlertController(title: "Error while refreshing Data", message: "Please check your Internet Connection and Location Settings.", preferredStyle: .Alert)
                
                let reloadAction = UIAlertAction(title: "Reload", style: .Cancel, handler: { aa in self.refresh() })
                let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                
                alert.addAction(reloadAction)
                alert.addAction(okayAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            
            //Fills the [WeatherCondition] in the UI
            for i in 0...5 { self.days[i].weatherCondition = weatherConditions[i] }
            
            self.view.backgroundColor = weatherConditions[0].color
            print("Successfully filled UI with refreshed Data!")
            
        }
        
        //Calling the API-Manager for fresh Data
        SwiftOverlays.showBlockingWaitOverlayWithText("Refreshing...")
        apiManager.fetchForecast({ weatherConditions in refreshCallback(weatherConditions)})
    }
    
}
