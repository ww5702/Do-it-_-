//
//  ViewController.swift
//  Map
//
//  Created by 이재웅 on 2023/02/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    //지도 보여주기
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization()             // 위치 데이터를 추적하기 위해 사용자의 승인
        locationManager.startUpdatingLocation()                     // 위치 업데이트를 시작
        myMap.showsUserLocation = true                              // 위치 보기 값을 true로 설정
    }


    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
    
}

