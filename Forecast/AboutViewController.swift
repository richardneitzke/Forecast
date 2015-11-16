//
//  AboutViewController.swift
//  Forecast
//
//  Created by Kyle Bashour on 11/12/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    @IBAction func dismissPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 0)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/richardxyx")!) }
        
        if indexPath == NSIndexPath(forItem: 0, inSection: 1)
        { UIApplication.sharedApplication().openURL(NSURL(string:"http://forecast.io")!) }
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 1)
        { UIApplication.sharedApplication().openURL(NSURL(string:"http://weathericons.io")!) }
    
        if indexPath == NSIndexPath(forItem: 2, inSection: 1)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://icons8.com")!) }
        
        if indexPath == NSIndexPath(forItem: 0, inSection: 2)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/kylebshr")!) }
        
        if indexPath == NSIndexPath(forItem: 1, inSection: 2)
        { UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/lapfelix")!) }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
