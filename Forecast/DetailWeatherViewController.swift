//
//  DetailWeatherViewController.swift
//  Forecast
//
//  Created by Richard Neitzke on 11/14/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class DetailWeatherViewController: UIViewController, BEMSimpleLineGraphDataSource {
    
    @IBOutlet weak var tempGraph: BEMSimpleLineGraphView!
    @IBAction func dismissPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var wCon:WeatherCondition?
    
    override func viewDidLoad() {
        
        setNeedsStatusBarAppearanceUpdate()
        
        //Makes Navigation Bar Transparent
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.barStyle = .BlackTranslucent
        
        let swipeDownGestureRec = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDownGestureRec.direction = .Down
        
        self.view.addGestureRecognizer(swipeDownGestureRec)
        
    }
    
    func swipeDown() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Sets title based on WeatherCondition
        let wConView = self.view as! WeatherConditionView
        wCon = wConView.weatherCondition
        self.title = "Weather on \(wCon!.fullDay)"
        
        tempGraph.colorBackgroundYaxis = UIColor.clearColor()
    }
    
    //Every temperature graph will have 24h
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 6
    }
    
    //Gives the graph the data of the WeatherCondition
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        
        return CGFloat(wCon!.temperatures[index*4])
    }

    
}
