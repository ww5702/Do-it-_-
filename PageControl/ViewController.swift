//
//  ViewController.swift
//  PageControl
//
//  Created by 이재웅 on 2023/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    var images = ["01.png", "02.png", "03.png", "04.png", "05.png"]

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count                    // 전체 페이지
        pageControl.currentPage = 0                                 // 현재 페이지
        
        pageControl.pageIndicatorTintColor = UIColor.green          // 페이지 컨트롤의 페이지를 표시하는 부분의 색깔
        pageControl.currentPageIndicatorTintColor = UIColor.red     // 페이지 컨트롤의 현재 페이지를 표시하는 부분의 색깔
        
        imgView.image = UIImage(named: images[0])
    }
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
}

