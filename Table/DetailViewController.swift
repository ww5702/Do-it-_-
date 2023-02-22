//
//  DetailViewController.swift
//  Table
//
//  Created by 이재웅 on 2023/02/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 테이블뷰에서 텍스트를 받아올 함수
    var receiveItem = ""

    @IBOutlet var lblItem: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
    }
    
    func receiveItem(_ item : String) {
        receiveItem = item
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
