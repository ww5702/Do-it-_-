//
//  ViewController.swift
//  MoviePlayer
//
//  Created by 이재웅 on 2023/02/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        // 내부 파일
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")  // 내부경로 받아오기
        let url = NSURL(fileURLWithPath: filePath!)                                         // NSURL형식으로 변경
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController,animated: true) {
            player.play()
        }
        
        playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        // 외부 파일
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks/.mp4")!
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
        
        playVideo(url: url)
    }

    @IBAction func btnPlayMovInternal(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "Mountaineering", ofType: "mov")  // 내부경로 받아오기
        let url = NSURL(fileURLWithPath: filePath!)                                         // NSURL형식으로 변경
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController,animated: true) {
            player.play()
        }
        
        playVideo(url: url)
    }
    
    @IBAction func btnPlayMovExternal(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/ijybpprsmx0bgre/Seascape.mov")!
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
        
        playVideo(url: url)
    }
    
    
    // 비디오 재생함수
    private func playVideo(url : NSURL) {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController,animated: true) {
            player.play()
        }
    }
}

