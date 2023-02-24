//
//  ViewController.swift
//  Audio
//
//  Created by 이재웅 on 2023/02/23.
//

import UIKit
import AVFoundation // 오디오 재생을 위한 헤더파일

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    
    let MAX_VOLUMN: Float = 10.0
    var progressTimer : Timer!
    
    // 재생타이머를 위한 상수
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    // 녹음타이머를 위한 상수
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolumn: UISlider!
    
    
    // 미션
    @IBOutlet var imageView: UIImageView!
    
    
    // 녹음 아울렛변수
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false                // record모드가 true면 재생모드가 아닌 녹음모드가 나오게 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "stop.png")
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
        }
    }
    
    // 녹음 파일 생성
    func selectAudioFile() {
        if !isRecordMode {      // 재생모드일때
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {                // 녹음모드일때 녹음파일 생성
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    // 녹음을 위한 초기화
    func initRecord() {
        // 포맷은 apple lossless / 음질은 최대 / 비트율은 320kbps / 오디오 채널은 2 / 샘플률은 44,100Hz으로 설정한다.
        let recordSettings = [
        AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
        AVEncoderBitRateKey : 320000,
        AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        slVolumn.value = 0.1
        audioPlayer.volume = slVolumn.value
        lblEndTime.text = convertNSTimeInterval2Sttring(0)
        lblCurrentTime.text = convertNSTimeInterval2Sttring(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
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
        slVolumn.value = 0.1                    // 볼륨 1.0으로 초기화
        pvProgressPlay.progress = 0             // 프로그레스뷰(진행도) 0으로 초기화
        
        audioPlayer.delegate = self             // delegate를 self로
        audioPlayer.prepareToPlay()             // preparetoplay() 실행
        audioPlayer.volume = slVolumn.value     // 오디오의 볼륨을 방금 초기화시켰던 1.0으로 초기화
        
        
        // endtime을 audioPlayer.duration으로 할수도 있지만 00:00의 형태로 만들기 위해 함수를 만든다
        lblEndTime.text = convertNSTimeInterval2Sttring(audioPlayer.duration)   // 오디오 파일의 재생시간을 함수에 입력
        lblCurrentTime.text = convertNSTimeInterval2Sttring(0)                  // 00:00이 출력되도록 0을 입력
        
        // 재생, 일시정지, 정지 버튼
        /*
        btnPlay.isEnabled = true    // 활성화
        btnPause.isEnabled = false   // 비활성화
        btnStop.isEnabled = false   // 활성화 */
        setPlayButtons(true, pause : false, stop : false)  // 같은 의미이다.
        
    }
    
    // 00:00 형태로 바꾸기 위해 TimeIntervalr값을 받아 문자열로 돌려보내는 함수
    func convertNSTimeInterval2Sttring(_ time:TimeInterval) -> String {
        let min = Int(time/60)                                      // 매개변수인 time을 60으로 나눈 몫 값을 min으로
        let sec = Int(time.truncatingRemainder(dividingBy: 60))     // 매개변수인 time을 60으로 나눈 나머지 값을 정수로 변환하여 sec으로
        let strTime = String(format: "%02d:%02d",min,sec)           // 02d의 형태로 문자열로 반환하여 strTime으로
        return strTime
    }
    
    // play, stop, pause 버튼의 동작여부를 설정하는 부분의 함수
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()                              // 오디오 재생
        setPlayButtons(false, pause: true, stop: true)  // 재생버튼 비활성화, 일시정지, 멈춤버튼 활성화
        // 재생시간 타이머 표시 (0.1초 간격)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        
        // 미션이미지
        imageView.image = UIImage(named: "play.png")
    }
    // updatePlayTime
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2Sttring(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
        
        // 미션 이미지
        imageView.image = UIImage(named: "pause.png")
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        setPlayButtons(true, pause: true, stop: false)
        // 정지했을때 시간이 00:00이 되도록
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2Sttring(0)
        pvProgressPlay.progress = 0.0 // 진행도 초기화
        progressTimer.invalidate()  // 타이머도 초기화
        
        // 미션 이미지
        imageView.image = UIImage(named: "stop.png")
    }
    @IBAction func slChangeVolumn(_ sender: UISlider) {
        // slider 값에 따라서 볼륨 조절
        audioPlayer.volume = slVolumn.value
    }
    // 오디오 재생이 끝나면 맨 처음 상태로 돌아가도록
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    
    // 녹음 액션함수
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        // 스위치가 on이면 녹음모드이므로 재생 중지, 현재 재생시간 00:00, isrecormode를 참으로, record버튼과 녹음시간 활성화
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2Sttring(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            // on이 아니면 재생모드
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2Sttring(0)
        }
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    @IBAction func btnRecord(_ sender: UIButton) {
        // 버튼이 record이면 녹음하고 아니면 stop으로 변경
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
            
            // 미션 이미지
            imageView.image = UIImage(named: "record.png")
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
            
            // 미션 이미지
            imageView.image = UIImage(named: "stop.png")
        }
    }
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2Sttring(audioRecorder.currentTime)
    }
    
    
}

