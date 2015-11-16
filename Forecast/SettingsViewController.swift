//
//  AboutViewController.swift
//  Forecast
//
//  Created by Kyle Bashour on 11/12/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBAction func dismissPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        //Makes Navigation Bar Transparent
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.barStyle = .BlackTranslucent
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 0.5 //make the header transparent
    }
    
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
