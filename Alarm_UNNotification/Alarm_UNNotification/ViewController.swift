//
//  ViewController.swift
//  Alarm_UNNotification
//
//  Created by J K on 2019/3/1.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    //显示当前时间的label
    fileprivate var timeLabel: UILabel!
    //显示设置的闹钟时间
    fileprivate var alarmTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = #colorLiteral(red: 0.4786051854, green: 0.6452147711, blue: 1, alpha: 1)
        
        //配置能够显示设置的闹钟时间
        alarmTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 40))
        alarmTimeLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        alarmTimeLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(alarmTimeLabel)
        
        //配置能够显示当前时间的label
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 80))
        timeLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        timeLabel.backgroundColor = #colorLiteral(red: 0.6709647056, green: 0.7481290299, blue: 1, alpha: 1)
        timeLabel.layer.cornerRadius = 15
        timeLabel.layer.masksToBounds = true
        timeLabel.font = UIFont.boldSystemFont(ofSize: 26)
        timeLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(timeLabel)
        
        //配置设置闹钟时间的按钮
        let setAlarmBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        setAlarmBtn.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
        setAlarmBtn.setTitle("set", for: .normal)
        setAlarmBtn.backgroundColor = #colorLiteral(red: 0.6880046596, green: 1, blue: 0.6228348736, alpha: 1)
        setAlarmBtn.setTitleColor(#colorLiteral(red: 1, green: 0.5417675151, blue: 0.5010515496, alpha: 1), for: .normal)
        setAlarmBtn.layer.cornerRadius = 14
        setAlarmBtn.addTarget(self, action: #selector(ViewController.setAlarmButton), for: .touchUpInside)
        self.view.addSubview(setAlarmBtn)
        
        //设置Timer
        manager.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.theTimer), userInfo: nil, repeats: true)
        
        //设置用户通知代理
        UNUserNotificationCenter.current().delegate = self
    }
  
    
    //定时器Tiemr每次更新时调用的方法
    @objc func theTimer() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"  //设定时间格式
        
        let timeStr = formatter.string(from: Date())
        timeLabel.text = timeStr  //传递给timeLabel,以便能够显示当前时间
    }
    
    //点击设置闹钟的按钮时调用
    @objc func setAlarmButton() {
        let alarmView = SetAlarmViewController()
        
        //弹出设置闹钟时间的视图
        self.present(alarmView, animated: true, completion: nil)
    }
   
    //视图即将显现时
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if manager.alarmTime != "" {    //如果设定了闹钟
            alarmTimeLabel.text = "设定了\(manager.alarmTime)闹钟"
            
            //设置的小时
            let hRange = manager.alarmTime.startIndex ... manager.alarmTime.index(manager.alarmTime.startIndex, offsetBy: 1)
            let hour = manager.alarmTime[hRange]
            
            //设置的分钟
            let mRange = manager.alarmTime.index(manager.alarmTime.endIndex, offsetBy: -2) ... manager.alarmTime.index(manager.alarmTime.endIndex, offsetBy: -1)
             let minute = manager.alarmTime[mRange]
            
            //调用通知方法
            notification(Int(String(hour)), Int(String(minute)))
            
        }else {  //如果没有设定了闹钟
            alarmTimeLabel.text = "无设定的闹钟"
            
            //调用通知方法
            notification(nil, nil)
        }
    }
    
    //用户通知方法
    func notification(_ hour: Int?, _ minute: Int?) {
        //配置通知
        let content = UNMutableNotificationContent()
        content.title = "Alarm_UNNotification"
        content.body = "闹钟响了"
        content.badge = nil
        content.sound = UNNotificationSound.default

        //设置时间
        var component = DateComponents()
        component.hour = hour ?? nil
        component.minute = minute ?? nil
        
        //设置通知的触发器
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        //设置通知请求
        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        
        //把请求发送到通知中心
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error!)
            }
        }
    }
    
    //使用UserNotification代理中的方法，该方法在应用处于前台时，也允许发送通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
        
        //遍历所有已推送的通知
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            for n in notifications {
                print(n)
            }
        }
        
        //删除所有已推送的通知
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
   
}

