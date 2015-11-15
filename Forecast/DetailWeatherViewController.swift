//
//  DetailWeatherViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/14/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    @IBAction func dismissPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        setNeedsStatusBarAppearanceUpdate()
        
        //Inserts Background Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 1, green: 1, blue: 1, alpha: 0).CGColor as CGColorRef
        let color2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        //self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        //Makes Navigation Bar Transparent
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.barStyle = .BlackTranslucent
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Sets background color and title based on WeatherCondition
        let wConView = self.view as! WeatherConditionView
        let wCon = wConView.weatherCondition
        self.title = "Weather on \(wCon!.fullDay)"
        //wConView.backgroundColor = wCon!.color
    }
    
}
