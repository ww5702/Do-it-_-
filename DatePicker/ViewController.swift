//
//  ViewController.swift
//  DatePicker
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {
    //타이머 추가
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0  // 타이머의 간격값이다. 1.0은 1초를 의미
    var count = 0   // 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
    }
    
    // #selecter()의 인자로 사용될 메서드를 선언할 때 Object-C와의 호완성을 위해 함수 앞에 @objc를 붙인다.
    @objc func updateTime() {
//        lblCurrentTime.text = String(count) + "초 경과"
//        count = count + 1
        
        let date = NSDate() //현재 시간을 가져오기 위해 NSDate()함수를 사용해 가져옵니다.
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)  //달력에서 날짜를 고른것이 아니기 때문에 from에 datePickerView를 사용하지 않는다.
    }
    
}

