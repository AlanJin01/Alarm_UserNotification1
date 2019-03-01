//
//  SetAlarmViewController.swift
//  Alarm_UNNotification
//
//  Created by J K on 2019/3/1.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController {

    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.6880046596, green: 1, blue: 0.6228348736, alpha: 1)
        
        //配置返回按钮
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        backButton.center = CGPoint(x: self.view.center.x - 80, y: self.view.center.y + 150)
        backButton.setTitle("Cancel", for: .normal)
        backButton.backgroundColor = #colorLiteral(red: 0.4786051854, green: 0.6452147711, blue: 1, alpha: 1)
        backButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 0.5417675151, blue: 0.5010515496, alpha: 1)
        backButton.layer.cornerRadius = 14
        backButton.addTarget(self, action: #selector(SetAlarmViewController.backButton), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        //配置确定设置的闹钟时间按钮
        let okButton = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        okButton.center = CGPoint(x: self.view.center.x + 80, y: self.view.center.y + 150)
        okButton.setTitle("Ok", for: .normal)
        okButton.backgroundColor = #colorLiteral(red: 0.4786051854, green: 0.6452147711, blue: 1, alpha: 1)
        okButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 0.5417675151, blue: 0.5010515496, alpha: 1)
        okButton.layer.cornerRadius = 14
        okButton.addTarget(self, action: #selector(SetAlarmViewController.okButton), for: .touchUpInside)
        self.view.addSubview(okButton)
        
        //配置时间拾取器
        let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 200))
        timePicker.tag = 1
        timePicker.datePickerMode = .time
        self.view.addSubview(timePicker)
        
    }
    
    //返回back按钮时调用
    @objc func backButton() {
        //返回主页
        self.dismiss(animated: true, completion: nil)
    }
    
    //点击确认按钮时调用
    @objc func okButton() {
        let timePicker = self.view.viewWithTag(1) as! UIDatePicker
        let theTime = timePicker.date   //获取设置的时间
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"  //设置时间格式
        
        let timeStr = formatter.string(from: theTime)
        manager.alarmTime = timeStr  //存储设置的时间
        
        //返回主页
        self.dismiss(animated: true, completion: nil)
    }
}
