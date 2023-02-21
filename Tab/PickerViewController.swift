//
//  ViewController.swift
//  PickerView
//
//  Created by 이재웅 on 2023/02/16.
//

import UIKit

// 피커 뷰의 델리게이트 메서드를 사용하려면 UIPickerViewDelegate, UIPickerViewDataSource 클래스를 상속받아야한다.
class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 2
    let PICKER_VIEW_HEIGHT : CGFloat = 80
    var imageArray : [UIImage?] = []
    var imageFileName = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg"]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        for i in 0..<MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }

    // 피커 뷰에게 무엇을 보여주고 어떻게 동작할 것인지 설정
    
    // 피커뷰에게 컴포넌트의 수를 정수값으로 넘겨주는 델리게이트 메서드. (열의 개수를 의미한다)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커뷰에게 컴포넌트의 열의 개수를 정수값으로 넘겨준다. 해당열에서 선택할 수 있는 행의 개수를 의미한다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 선택한 이미지 이름 출력하기
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            lblImageFileName.text = imageFileName[row]
        } else {
            imageView.image = imageArray[row]
        }
    }
    
    // 피커 뷰에게 컴포넌트의 각 열의 타이틀을 문자열 값으로 넘겨준다.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }
    
    // 위에거는 피커뷰 룰렛에 imageFileName[row] 즉 이름만 출력
    // 피커뷰 룰렛에 파일명 대신 이미지 출력하기
    func pickerView(_ pickerView: UIPickerView, viewForRow row : Int, forComponent component : Int, reusing view : UIView?) -> UIView {
        let imageView = UIImageView(image : imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    // 피커뷰 룰렛의 세로 이미지 크기 변경
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    
}

