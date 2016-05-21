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
    var numTimes = 0
    
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
        numTimes = defaults.integerForKey("numTimes")
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if (defaults.objectForKey("pastTimes") != nil)
        {
            pastTimes = defaults.objectForKey("pastTimes") as! [Double]
        }
        
        bestTime = defaults.doubleForKey("best")
        avgTime = defaults.doubleForKey("average")
        worstTime = defaults.doubleForKey("worst")
        numTimes = defaults.integerForKey("numTimes")
        
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
                cell.titleLabel.textColor = UIColor(red: 0, green: 119/255, blue: 0, alpha: 1)
                
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
        if (indexPath.section == 1)
        {
            
            let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action: UITableViewRowAction, indexPath: NSIndexPath) in
                
                self.pastTimes.removeAtIndex(indexPath.row)

                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                self.defaults.setObject(self.pastTimes, forKey: "pastTimes")
                
                self.bestTime = self.pastTimes[0]
                self.worstTime = self.pastTimes[0]
                var total = 0.0
                
                for i in self.pastTimes
                {
                    
                    if (i < self.bestTime)
                    {
                        self.bestTime = i
                    }
                    else if (i > self.worstTime)
                    {
                        self.worstTime = i
                    }
                    
                    total += i
                    
                }
                
                self.numTimes -= 1
                self.avgTime = total / Double(self.numTimes)
                
                self.defaults.setDouble(self.bestTime, forKey: "best")
                self.defaults.setDouble(self.worstTime, forKey: "worst")
                self.defaults.setDouble(self.avgTime, forKey: "average")
                self.defaults.setInteger(self.numTimes, forKey: "numTimes")
                
                tableView.reloadData()
                
            })
            
            return [deleteAction]
            
        }
        
        return nil
        
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        
        if (indexPath.section == 0)
        {
            return UITableViewCellEditingStyle.None
        }
        
        return UITableViewCellEditingStyle.Delete
        
    }

}
