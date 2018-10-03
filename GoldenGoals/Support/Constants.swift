//
//  Constants.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 03/10/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import Foundation

//for all the strings added to UserDefaults
struct UserDefaultsStrings {
    static let Default = UserDefaults.standard
    
    static let Firstrun = "userRunningAppFirstTime"
    
    //settings set in About
    static let StartView = "StartView"
    static let DefaultHall = "DefaultHall"
    static let ShowGoalStart = "ShowGoalStart"
}

struct Constants{
    //used in About footer
    static let Appversion = "CFBundleShortVersionString"
    static let Buildnumber = "CFBundleVersion"
}
