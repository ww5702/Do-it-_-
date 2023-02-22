//
//  AddViewController.swift
//  Table
//
//  Created by 이재웅 on 2023/02/22.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var tfAddItem: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnAddItem(_ sender: UIButton) {
        // textfield값을 추가, 이미지파일은 일단 임의로 하나 선정
        items.append(tfAddItem.text!)
        itemsImageFile.append("clock.png")
        // 입력후 텍스트 필드 값 지우기
        tfAddItem.text = ""
        // add후 전으로 돌아가기
        _ = navigationController?.popViewController(animated: true)
    }
}
