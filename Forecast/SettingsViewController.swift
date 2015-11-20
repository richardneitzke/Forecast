//
//  AboutViewController.swift
//  Forecast
//
//  Created by Kyle Bashour on 11/12/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var delegate: WeatherViewController?
    var reloadRequired = false
    
    //Dismisses the view and reloads the WeatherViewController in case the unit preference changed
    @IBAction func dismissPressed(sender: UIBarButtonItem) {
        if reloadRequired {delegate?.refresh()}
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var unitControl: UISegmentedControl!
    
    //Changes the unit preference
    @IBAction func unitControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: defaults.setValue("us", forKey: "unit")
        case 1: defaults.setValue("si", forKey: "unit")
        default: defaults.setValue("auto", forKey: "unit")
        }
        
        reloadRequired = true
    }
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //Marks the current unit preference
    override func viewWillAppear(animated: Bool) {
        switch defaults.valueForKey("unit") as? String {
        case "us"?: unitControl.selectedSegmentIndex = 0
        case "si"?: unitControl.selectedSegmentIndex = 1
            
        //Sets the current unit setting to auto in case the unit never changed
        default:
            defaults.setValue("auto", forKey: "unit")
            unitControl.selectedSegmentIndex = 2
        }
        
        reloadRequired = false
    }
    
    //Makes Navigation Bar Transparent
    override func viewDidLoad() {
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.barStyle = .BlackTranslucent
    }
    
    //Manages the text color of the headers
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.whiteColor()
        header.alpha = 0.5
    }
    
    //Opens the right link in Safari if a link is pressed
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 1)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/richardxyx")!) }
        
        if indexPath == NSIndexPath(forItem: 0, inSection: 2)
        { UIApplication.sharedApplication().openURL(NSURL(string:"http://forecast.io")!) }
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 2)
        { UIApplication.sharedApplication().openURL(NSURL(string:"http://weathericons.io")!) }
    
        if indexPath == NSIndexPath(forItem: 2, inSection: 2)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://icons8.com")!) }
        
        if indexPath == NSIndexPath(forItem: 0, inSection: 3)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/kylebshr")!) }
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 3)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/lapfelix")!) }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
