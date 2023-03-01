//
//  ViewController.swift
//  PinchGesture
//
//  Created by 이재웅 on 2023/03/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtPincch: UILabel!
    
    var initialFontSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        if(pinch.state == UIGestureRecognizer.State.began) {
            initialFontSize = txtPincch.font.pointSize                                  // 현재 폰트사이즈 저장
        } else {
            txtPincch.font = txtPincch.font.withSize(initialFontSize * pinch.scale)
        }
    }


}

