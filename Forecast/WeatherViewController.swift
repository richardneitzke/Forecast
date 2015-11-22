//
//  WeatherViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/21/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import UIKit
import BEMSimpleLineGraph

class WeatherViewController: UIViewController, BEMSimpleLineGraphDataSource {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    let tempUnit = "f"
    let windUnit = "mph"
    
    var dailyConditionStorage: DailyCondition?
    var dailyCondition: DailyCondition? {
        get { return dailyConditionStorage }
        set {
            tempLabel.text = "LOL"
            dailyConditionStorage = newValue
            
        }
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 3
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return CGFloat(index)
    }
}