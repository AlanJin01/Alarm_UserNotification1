//
//  Manager.swift
//  Alarm_UNNotification
//
//  Created by J K on 2019/3/1.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

//设置对外开放的单例模式
class Manager {
    static var shared = Manager()
    
    var timer = Timer()  //初始化时间定时器 
    var alarmTime = String() //设置的时间
    
    init() {}
}

let manager = Manager.shared

