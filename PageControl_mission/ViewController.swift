//
//  ViewController.swift
//  PageControl_mission
//
//  Created by 이재웅 on 2023/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelValue: UILabel!
    @IBOutlet var pageControlValue: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControlValue.numberOfPages = 10
        pageControlValue.currentPage = 0
        pageControlValue.pageIndicatorTintColor = UIColor.blue
        pageControlValue.currentPageIndicatorTintColor = UIColor.yellow
        
        labelValue.text = String(pageControlValue.currentPage+1)
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        labelValue.text = ("\(pageControlValue.currentPage+1)")
    }
    
}

