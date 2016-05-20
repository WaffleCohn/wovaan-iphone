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

    var timer = NSTimer()
    
    let interval = 0.01
    
    var count = 0.0
    
    var counting = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "tap:")
        self.view.addGestureRecognizer(tap)
        
        //play()
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
        
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
    }
    
    func stop()
    {
        
        counting = false
        
        timer.invalidate()
        
    }
    
    func updateTime()
    {
        count += interval
        
        timeLabel.text = formatTime(count)
    }
    
    func formatTime(var x:Double) -> String
    {
        var hrs = 0
        var min = 0
        var sec = 0
        var ms = 0
        
        if (x / 3600 >= 1)
        {
            hrs = Int(x/3600)
            x -= Double(hrs*3600)
        }
        
        if (x / 60 >= 1)
        {
            min = Int(Int(x)/60)
            x -= Double(min*60)
        }
        
        sec = Int(x)
        x -= Double(sec)
        ms = Int(x*100)
        
        if (hrs > 0)
        {
            return String(format: "\(hrs):%02d:%02d.%02d", arguments: [min, sec, ms])
        }
        
        if (min > 0)
        {
            return String(format: "\(min):%02d.%02d", arguments: [sec, ms])
        }
        
        return String(format: "\(sec).%02d", arguments: [ms])
    }


}

