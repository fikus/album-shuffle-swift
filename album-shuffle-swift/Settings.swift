//
//  Settings.swift
//  album-shuffle-swift
//
//  Created by Eric Fikus on 9/16/14.
//  Copyright (c) 2014 Eric Fikus. All rights reserved.
//

import Foundation

class Settings
{
    class var rdioAccessToken : String? {
        get { return NSUserDefaults.standardUserDefaults().stringForKey("accessToken") }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "accessToken")
        }
    }
}