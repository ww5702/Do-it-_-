//
//  ViewController.swift
//  DrawGraphics
//
//  Created by 이재웅 on 2023/02/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnDrawLine(_ sender: UIButton) {
        // 그림을 그리는 도화지
        UIGraphicsBeginImageContext(imgview.frame.size)     // 이미지뷰와 동일한 크기로 설정
        let context = UIGraphicsGetCurrentContext()!        // 생성한 콘텍스트 정보를 가져온다
        
        context.setLineWidth(2.0)                          // 굵기 2.0
        context.setStrokeColor(UIColor.red.cgColor)        // 선의 색상
        
        context.move(to: CGPoint(x: 70, y: 50))            // 시작위치로 커서를 이동(70,50)으로
        context.addLine(to: CGPoint(x: 270, y: 250))       // 지정한 위치까지(270,250)까지 선을 추가 더 그리고 싶다면 이어서 추가할수있다
        
        context.strokePath()                               // 위의 추가한 경로를 그린다
        
        context.setLineWidth(4.0)                          // 이번에는 4.0의 굵기와 파란 색으로 삼각형의 꼭지점이 3개이므로 move좌표에서 addline꼭지점으로 이동 후 그림그리기
        context.setStrokeColor(UIColor.blue.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 270, y: 350))
        context.addLine(to: CGPoint(x: 70, y: 350))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.strokePath()
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func btnDrawRectangle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgview.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addRect(CGRect(x: 70, y: 100, width: 200, height: 200))    // 좌표 (70,100)에서 시작하여 200px인 사각형을 그린다
        context.strokePath()
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawCircle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgview.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addEllipse(in: CGRect(x: 70, y: 50, width: 200, height: 100))  // 200,200 픽셀에 내접하는 원을 그린다.
        context.strokePath()
        
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.green.cgColor)
        
        context.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 200))
        context.strokePath()
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }
    
    @IBAction func btnDrawArc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgview.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 100, y: 50))
        // 250,50 250,200 사이에 내접한 반지름이 50인 호를 그리겠다는 뜻
        context.addArc(tangent1End: CGPoint(x: 250, y: 50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50))
        context.addLine(to: CGPoint(x: 250, y: 200))
        
        context.move(to: CGPoint(x: 100, y: 250))
        context.addArc(tangent1End: CGPoint(x: 270, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawFill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgview.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.red.cgColor)                       // 도형 내부의 색상을 채운다
        
        let rectangle = CGRect(x: 70, y: 50, width: 200, height: 100)
        context.addRect(rectangle)
        context.fill(rectangle)                                         // 사각형 내부 색 변경
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: 70, y: 200, width: 200, height: 100)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 350))
        context.addLine(to: CGPoint(x: 270, y: 450))
        context.addLine(to: CGPoint(x: 70, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 350))
        context.fillPath()                                              // 선 내부를 색상 채움
        context.strokePath()
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    
    @IBAction func btnDrawMission(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgview.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 삼각형
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        context.move(to: CGPoint(x: 140, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 450))
        context.addLine(to: CGPoint(x: 140, y: 450))
        context.fillPath()
        context.strokePath()
        
        // 주위 원
        context.setStrokeColor(UIColor.yellow.cgColor)
        context.setFillColor(UIColor.yellow.cgColor)
        let circle2 = CGRect(x: 170, y: 150, width: 100, height: 100)
        context.addEllipse(in: circle2)
        context.fillEllipse(in: circle2)
        context.strokePath()
        
        let circle3 = CGRect(x: 70, y: 150, width: 100, height: 100)
        context.addEllipse(in: circle3)
        context.fillEllipse(in: circle3)
        context.strokePath()
        
        let circle4 = CGRect(x: 120, y: 100, width: 100, height: 100)
        context.addEllipse(in: circle4)
        context.fillEllipse(in: circle4)
        context.strokePath()
        
        let circle5 = CGRect(x: 120, y: 200, width: 100, height: 100)
        context.addEllipse(in: circle5)
        context.fillEllipse(in: circle5)
        context.strokePath()
        
        // 가운데 원
        context.setStrokeColor(UIColor.orange.cgColor)
        context.setFillColor(UIColor.orange.cgColor)
        let circle = CGRect(x: 120, y: 150, width: 100, height: 100)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)
        context.strokePath()
        
        
        imgview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    

}

