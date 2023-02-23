//
//  ViewController.swift
//  Audio
//
//  Created by 이재웅 on 2023/02/23.
//

import UIKit
import AVFoundation // 오디오 재생을 위한 헤더파일

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    
    let MAX_VOLUMN: Float = 10.0
    var progressTimer : Timer!
    

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPaly: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolumn: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        initPlay()
    }
    
    // 오디오 재생을 위한 초기화
    // 뒤에 재생모드와 녹음모드로 변경할 떄를 대비해 오디오재생초기화와 녹음재생초기화를 따로 설정해야한다. 따라서 함수를 만든다
    func initPlay() {
        // 오디오파일이 없을때를 대비한 do-catch
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay :\(error)")
        }
        slVolumn.maximumValue = MAX_VOLUMN      // 최대볼륨 10
        slVolumn.value = 1.0                    // 볼륨 1.0으로 초기화
        pvProgressPlay.progress = 0             // 프로그레스뷰(진행도) 0으로 초기화
        
        audioPlayer.delegate = self             // delegate를 self로
        audioPlayer.prepareToPlay()             // preparetoplay() 실행
        audioPlayer.volume = slVolumn.value     // 오디오의 볼륨을 방금 초기화시켰던 1.0으로 초기화
        
        
        // endtime을 audioPlayer.duration으로 할수도 있지만 00:00의 형태로 만들기 위해 함수를 만든다
        lblEndTime.text = convertNSTimeInterval2Sttring(audioPlayer.duration)   // 오디오 파일의 재생시간을 함수에 입력
        lblCurrentTime.text = convertNSTimeInterval2Sttring(0)                  // 00:00이 출력되도록 0을 입력
    }
    
    // 00:00 형태로 바꾸기 위해 TimeIntervalr값을 받아 문자열로 돌려보내는 함수
    func convertNSTimeInterval2Sttring(_ time:TimeInterval) -> String {
        let min = Int(time/60)                                      // 매개변수인 time을 60으로 나눈 몫 값을 min으로
        let sec = Int(time.truncatingRemainder(dividingBy: 60))     // 매개변수인 time을 60으로 나눈 나머지 값을 정수로 변환하여 sec으로
        let strTime = String(format: "%02d:%02d",min,sec)           // 02d의 형태로 문자열로 반환하여 strTime으로
        return strTime
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
    }
    @IBAction func btnPauseAudio(_ sender: UIButton) {
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
    }
    @IBAction func slChangeVolumn(_ sender: UISlider) {
    }
}

