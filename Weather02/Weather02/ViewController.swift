//
//  ViewController.swift
//  Weather02
//
//  Created by MinJing_Lin on 2020/4/11.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    // 城市名
    var cityLabel = UILabel()
    // 天气
    var weaLabel = UILabel()
    // 温度
    var temLabel = UILabel()
    //
    var weaIcon = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        locationManager.delegate = self
        // 精确度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 权限
        locationManager.requestWhenInUseAuthorization()
        // 请求一次位置
        locationManager.requestLocation()
//        locationManager.startUpdatingLocation()
    }
    
    func setupUI() {
        
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "bg_normal")
        self.view.addSubview(bgImgV)
        bgImgV.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        cityLabel.text = ""
        cityLabel.font = UIFont.systemFont(ofSize: 25)
        cityLabel.textColor = .white
        self.view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        weaLabel.text = ""
        weaLabel.font = UIFont.systemFont(ofSize: 25)
        weaLabel.textColor = .white
        self.view.addSubview(weaLabel)
        weaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(weaIcon)
        weaIcon.snp.makeConstraints { (make) in
            make.top.equalTo(weaLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80,height: 80))
        }
        
        temLabel.text = ""
        temLabel.font = UIFont.systemFont(ofSize: 25)
        temLabel.textColor = .white
        self.view.addSubview(temLabel)
        temLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weaIcon.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    func loadWeather(city:String) {
        let paras:[String : Any] = ["key":"osoydf7ademn8ybv",
                                    "location":city,
                                    "language":"zh-Hans",
                                    "start":0,
                                    "days":1]
        
        AF.request("https://api.thinkpage.cn/v3/weather/daily.json",
                   method: .get,
                   parameters: paras).responseJSON { (response) in
                    
                       switch(response.result) {
                       case .success(let value):
                        let json = JSON(value)
                        print(json)
                        
                        self.updateData(json: json)
                    
                        case .failure(let error):
                            print("Error message:\(error)")
                            break
                        }
                    }
        
    }
    
    func updateData(json:JSON) {
        let weather = Weather()
        
        let cityName = json["results"][0]["location"]["name"].stringValue
        weather.cityName = cityName
        
        let iconCode = json["results"][0]["daily"][0]["code_day"].stringValue
        weather.code_day = iconCode
        
        let wea = json["results"][0]["daily"][0]["text_day"].stringValue
        weather.text_day = wea
        
        let low = json["results"][0]["daily"][0]["low"]
        let height = json["results"][0]["daily"][0]["high"]
        weather.temperature = "\(height)°C / \(low)°C"
        
        self.updateWeatherUI(model: weather)

    }
    
    func updateWeatherUI(model:Weather) {
        self.cityLabel.text = model.cityName
        self.weaLabel.text = model.text_day
        self.weaIcon.image = UIImage(named: "\(model.code_day)")
        self.temLabel.text = model.temperature
    }
    
}


extension ViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0]
        if location.horizontalAccuracy > 0 {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print("纬度:\(long) 经度:\(lat)")
        }
            
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let cityName = placemarks?.last?.locality
            print("城市名字:\(cityName ?? "")")
            
            self.loadWeather(city: cityName ?? "suzhou")
        }
            
//        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("获取位置失败 \(error)")
    }
    
}
