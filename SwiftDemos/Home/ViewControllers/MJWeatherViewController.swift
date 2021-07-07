//
//  MJWeatherViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SnapKit

class MJWeatherViewController: MJBaseViewController {

    
    var locationManager = CLLocationManager()
    /// 城市
    var cityLbl = UILabel()
    /// 天气
    var weaLbl = UILabel()
    /// 温度
    var temLbl = UILabel()
    var weaIcon = UIImageView()
    /// 时间
    var dateLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        self.locationInit()
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH时mm分ss秒"
        let dateStr = dateFormatter.string(from: date as Date)
        print(dateStr)
        dateLbl.text = dateStr

    }
    
    func setupUI() {
        
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "bg_normal")
        self.view.addSubview(bgImgV)
        bgImgV.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        cityLbl.text = ""
        cityLbl.font = UIFont.systemFont(ofSize: 25)
        cityLbl.textColor = .white
        self.view.addSubview(cityLbl)
        cityLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(nav_bar_h + 50)
            make.centerX.equalToSuperview()
        }
        
        weaLbl.text = ""
        weaLbl.font = UIFont.systemFont(ofSize: 25)
        weaLbl.textColor = .white
        self.view.addSubview(weaLbl)
        weaLbl.snp.makeConstraints { (make) in
            make.top.equalTo(cityLbl.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(weaIcon)
        weaIcon.snp.makeConstraints { (make) in
            make.top.equalTo(weaLbl.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        temLbl.text = ""
        temLbl.font = UIFont.systemFont(ofSize: 25)
        temLbl.textColor = .white
        self.view.addSubview(temLbl)
        temLbl.snp.makeConstraints { (make) in
            make.top.equalTo(weaIcon.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        dateLbl.text = ""
        dateLbl.font = UIFont.systemFont(ofSize: 20)
        dateLbl.textColor = .white
        self.view.addSubview(dateLbl)
        dateLbl.snp.makeConstraints { (make) in
            make.top.equalTo(temLbl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }

    func loadWeather(city:String) {
        let paras:[String : Any] = ["key":"osoydf7ademn8ybv",
                                    "location":city,
                                    "language":"zh-Hans",
                                    "start":0,
                                    "days":1]
        AF.request("https://api.thinkpage.cn/v3/weather/daily.json", method: .get, parameters: paras).responseJSON { (response) in
            
            switch(response.result) {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    
                    self.updateData(json: json)
                case .failure(let error):
                    print("Error message:\(error)")
            }
        }
    }
    
    func updateData(json:JSON) {
        
        let weather = WeatherModel()
        
        let cityName = json["results"][0]["location"]["name"].stringValue
        weather.cityName = cityName
        
        let iconCode = json["results"][0]["daily"][0]["code_day"].stringValue
        weather.code_day = iconCode
        
        let wea = json["results"][0]["daily"][0]["text_day"].stringValue
        weather.text_day = wea
        
        let low = json["results"][0]["daily"][0]["low"]
        let height = json["results"][0]["daily"][0]["high"]
        weather.temperature = "\(low)°C / \(height)°C"
        
        updateWeatherUI(model: weather)
    }
    
    func updateWeatherUI(model:WeatherModel) {
        cityLbl.text = model.cityName
        weaLbl.text = model.text_day
        weaIcon.image = UIImage(named: model.code_day)
        temLbl.text = model.temperature
    }

}

extension MJWeatherViewController:CLLocationManagerDelegate {
    
    func locationInit() {
        // 定位
        locationManager.delegate = self
        // 精确度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 权限
        locationManager.requestWhenInUseAuthorization()
        // 请求一次位置
        locationManager.requestLocation()
        //        locationManager.startUpdatingLocation()
    }
    
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
