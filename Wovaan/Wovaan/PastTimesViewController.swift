//
//  PastTimesViewController.swift
//  Wovaan
//
//  Created by Ari Cohn on 5/19/16.
//  Copyright © 2016 Ari Cohn. All rights reserved.
//

import UIKit

class PastTimesViewController: UITableViewController
{
    
    var pastTimes = [Double]()
    var bestTime = 0.0
    var avgTime = 0.0
    var worstTime = 0.0
    
    var defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if (defaults.objectForKey("pastTimes") != nil)
        {
            pastTimes = defaults.objectForKey("pastTimes") as! [Double]
        }
        
        bestTime = defaults.doubleForKey("best")
        avgTime = defaults.doubleForKey("average")
        worstTime = defaults.doubleForKey("worst")
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        if (defaults.objectForKey("pastTimes") != nil)
        {
            pastTimes = defaults.objectForKey("pastTimes") as! [Double]
        }
        
        bestTime = defaults.doubleForKey("best")
        avgTime = defaults.doubleForKey("average")
        worstTime = defaults.doubleForKey("worst")
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
        return 2
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        if (section == 0)
        {
            return "Records"
        }
        
        return "All"
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        
        return tableView.sectionHeaderHeight
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if (section == 0)
        {
            return 3
        }
        
        return pastTimes.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        if (indexPath.section == 0)
        {
            
            if (indexPath.row == 0)
            {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("record", forIndexPath: indexPath) as! RecordCell
                
                cell.titleLabel.text = "Best"
                cell.titleLabel.textColor = UIColor.greenColor()
                
                cell.timeLabel.text = formatTime(bestTime)
                
                return cell
                
            }
            
            if (indexPath.row == 1)
            {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("record", forIndexPath: indexPath) as! RecordCell
                
                cell.titleLabel.text = "Average"

                cell.timeLabel.text = formatTime(avgTime)
                
                return cell
                
            }
            
            if (indexPath.row == 2)
            {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("record", forIndexPath: indexPath) as! RecordCell
                
                cell.titleLabel.text = "Worst"
                cell.titleLabel.textColor = UIColor.redColor()
                
                cell.timeLabel.text = formatTime(worstTime)
                
                return cell
                
            }
            
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TimeCell
        
        cell.timeLabel.text = formatTime(pastTimes[indexPath.row])
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

}
