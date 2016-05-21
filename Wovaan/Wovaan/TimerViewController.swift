//
//  FirstViewController.swift
//  Wovaan
//
//  Created by Ari Cohn on 5/19/16.
//  Copyright © 2016 Ari Cohn. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController
{
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var bestTimeLabel: UILabel!
    
    @IBOutlet weak var averageTimeLabel: UILabel!
    
    @IBOutlet weak var scrambleLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func resetButtonPressed(sender: AnyObject)
    {
        
        timeLabel.text = "0.00"
        
        count = 0.0
        
        counting = false
        
    }
    
    var timer = NSTimer()
    
    let interval = 0.01
    var count = 0.0
    var counting = false
    
    var bestTime = 0.0
    var avgTime = 0.0
    var worstTime = 0.0
    var pastTimes = [Double]()
    var numTimes = 0
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bestTime = defaults.doubleForKey("best")
        avgTime = defaults.doubleForKey("average")
        worstTime = defaults.doubleForKey("worst")
        if (defaults.objectForKey("pastTimes") != nil)
        {
            pastTimes = defaults.objectForKey("pastTimes") as! [Double]
        }
        numTimes = defaults.integerForKey("numTimes")
        
        bestTimeLabel.text = formatTime(bestTime)
        averageTimeLabel.text = formatTime(avgTime)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimerViewController.tap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        bestTime = defaults.doubleForKey("best")
        avgTime = defaults.doubleForKey("average")
        worstTime = defaults.doubleForKey("worst")
        if (defaults.objectForKey("pastTimes") != nil)
        {
            pastTimes = defaults.objectForKey("pastTimes") as! [Double]
        }
        numTimes = defaults.integerForKey("numTimes")
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func tap(sender: UITapGestureRecognizer)
    {
        
        if (counting)
        {
            stop()
        }
        else
        {
            play()
        }
        
    }
    
    func play()
    {
        
        counting = true
        
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
        
        resetButton.hidden = true
        
    }
    
    func stop()
    {
        
        counting = false
        
        timer.invalidate()
        
        resetButton.hidden = false
        
        pastTimes.insert(count, atIndex: 0)
        
        defaults.setObject(pastTimes, forKey: "pastTimes")
        
        if (count < bestTime || bestTime == 0)
        {
            
            bestTime = count
            
            defaults.setDouble(count, forKey: "best")
            
        }
        
        if (count > worstTime)
        {
            
            worstTime = count
            
            defaults.setDouble(count, forKey: "worst")
            
        }
        
        avgTime = ((avgTime * Double(numTimes)) + count)
        numTimes += 1
        avgTime /= Double(numTimes)
        
        defaults.setDouble(avgTime, forKey: "average")
        defaults.setInteger(numTimes, forKey: "numTimes")
        
        bestTimeLabel.text = formatTime(bestTime)
        averageTimeLabel.text = formatTime(avgTime)
        
        count = 0
        
    }
    
    func updateTime()
    {
        count += interval
        
        timeLabel.text = formatTime(count)
    }


}

