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

