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
    
    // 위도 경도 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span : Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)       // 위도, 경도 값을 매개변수로 함수 호출
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)     // 범위 값을 매개변수로 함수 호출
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)            // plocation, spanvalue 값을 매개변수로 함수 호출
        myMap.setRegion(pRegion, animated: true)
    }

    // 위치가 업데이트 되었을 때 지도에 위치 나타내기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last  // 위치가 바뀌면 마지막 위치값을 찾아낸다.
        // 마지막 위도 경도로 지도에 표시, delta 0.01은 1의 값보다 100배 확대된 값으로 표현
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
    
}

