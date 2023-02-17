//
//  ViewController.swift
//  Alert_Mission
//
//  Created by 이재웅 on 2023/02/17.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime: String?
    var alertFlag = false

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblSelectTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(from: date as Date)
        
        if alarmTime == currentTime {
            if alertFlag == false {
                let alert = UIAlertController(title: "알림", message: "설정된 시간입니다 !!!", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
                
                alertFlag = true
            } else {
                alertFlag = false
            }
        }
        // 1분동안 게속 나타나게 하는것은 생각보다 쉬웠다
        // 그저 분이 같다면 계속 알람이 띄워지게하면 되는것이었다.
        // 분이 바뀌지않는 이상 게속해서 알람을 띄운다.
    }
    
}

