//
//  ViewController.swift
//  ImageView
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    var isZoom = false
    var imgOn : UIImage?
    var imgOff : UIImage?

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale : CGFloat = 2.0 // CGFloat는 Xcode에서 Float을 재정의 해놓은 자료형으로 Float이라고 생각하면된다.
        var newWidth : CGFloat, newHeight : CGFloat
        
        if isZoom {
            // 축소 버튼을 눌렀기에 가로 새로를 1/2로 변환 후 버튼의 이름을 확대로 변경
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        } else {
            // 확대 버튼을 눌렀기에 가로 새로를 2배로 변환 후 버튼의 이름을 축소로 변경
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.width*scale
            btnResize.setTitle("축소", for: .normal)
        }
        
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
}

