//
//  Utilities.swift
//  Wovaan
//
//  Created by Ari Cohn on 5/20/16.
//  Copyright © 2016 Ari Cohn. All rights reserved.
//

import Foundation

func formatTime(y:Double) -> String
{
    
    var x:Double = y
    
    var hrs = 0
    var min = 0
    var sec = 0
    var ms = 0
    
    if (x / 3600 >= 1)
    {
        hrs = Int(x/3600.0)
        x -= Double(hrs*3600)
    }
    
    if (x / 60 >= 1)
    {
        min = Int(x/60.0)
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