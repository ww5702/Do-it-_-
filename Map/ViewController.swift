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
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span : Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)       // 위도, 경도 값을 매개변수로 함수 호출
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)     // 범위 값을 매개변수로 함수 호출
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)            // plocation, spanvalue 값을 매개변수로 함수 호출
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    // 핀 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }

    // 위치가 업데이트 되었을 때 지도에 위치 나타내기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last  // 위치가 바뀌면 마지막 위치값을 찾아낸다.
        // 마지막 위도 경도로 지도에 표시, delta 0.01은 1의 값보다 100배 확대된 값으로 표현
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        // 위치 정보 추출하여 텍스트로
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first              // placemark 값의 첫부분만 pm으로
            let country = pm!.country               // pm상수에서 나라값을 country로
            var address:String = country!           // address에 country값 대입
            if pm!.locality != nil {                // pm에 지역값이 존재하면 address에 추가
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {            // pm에 도로값이 존재하면 address에 추가
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        locationManager.stopUpdatingHeading()
    }
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
            
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.531897, longitudeValue: 126.914093, delta: 1, title: "국회의사당", strSubtitle: "서울특별시 영등포구 의사당대로 1")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "국회의사당"
            
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 37.511347, longitudeValue: 127.098602, delta: 1, title: "롯데월드", strSubtitle: "서울특별시 송파구 올림픽로 240")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "롯데월드"
        }
    }
    
}

