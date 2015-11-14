//
//  PrecipCondition.swift
//  Forecast
//
//  Created by Chase Roossin on 11/14/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import Foundation
import UIKit

class PrecipCondition {
    var precipProbability: Double
    var precipIntensity: Double
    var time: Int

    init(precipProbability:Double, precipIntensity:Double, time:String){
        self.precipProbability = precipProbability
        self.precipIntensity = precipIntensity

        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time)!)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: date)
        self.time = comp.hour
    }

    func printPrecip(){
        print("prob: \(precipProbability)\nint:\(precipIntensity)\ntime: \(time)")
    }
}