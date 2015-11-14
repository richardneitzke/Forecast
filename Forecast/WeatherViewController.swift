//
//  ViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/9/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit
import SwiftOverlays
import BEMSimpleLineGraph

class WeatherViewController: UIViewController, BEMSimpleLineGraphDelegate {

    let apiManager = APIManager()
    
    @IBOutlet weak var day0: WeatherConditionView!
    @IBOutlet weak var day1: WeatherConditionView!
    @IBOutlet weak var day2: WeatherConditionView!
    @IBOutlet weak var day3: WeatherConditionView!
    @IBOutlet weak var day4: WeatherConditionView!
    @IBOutlet weak var day5: WeatherConditionView!
    @IBOutlet weak var precipGraph: BEMSimpleLineGraphView!
    
    @IBAction func refreshPressed(sender: UIBarButtonItem) {
        refresh()
    }
    
    override func viewDidLoad() {

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
    }

    //Refreshes the Data/UI
    func refresh() {
        
        //Callback for putting received Data in the UI
        let refreshCallback: ([WeatherCondition]) -> Void = { weatherConditions in
            
            print("Trying to put received data in the UI...")
            
            self.removeAllOverlays()
            
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
            
            //Reads the [WeatherCondition] in the UI
            let days = [self.day0, self.day1, self.day2, self.day3, self.day4, self.day5]
            
            for i in 0...5 {
                let day = days[i]
                let wtr = weatherConditions[i]
                
                if day.dayLabel != nil {day.dayLabel.text = wtr.day}
                day.iconLabel.text = wtr.iconChar
                day.degreeLabel.text = "\(wtr.degrees)\(wtr.unit)"
            }
            
            self.view.backgroundColor = weatherConditions[0].color
            
            print("Successfully filled UI with refreshed Data!")

            
        }
        
        //Calling the API-Manager for fresh Data
        self.showWaitOverlayWithText("Refreshing...")
        apiManager.fetchForecast({ weatherConditions in refreshCallback(weatherConditions)})
    }

    //Number of points in graph - 24 for next 24 hours
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 24
    }

    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return 1
    }

}
