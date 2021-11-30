//
//  SwiftCharacterViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/11/25.
//

import Foundation
import UIKit

class SwiftCharacterViewController: MJBaseViewController {
    
    // block
    typealias voidClosure = () -> Void
    @objc var BtnClosure:voidClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let commitBtn = UIButton(type: .custom)
        commitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        commitBtn.setTitleColor(.black, for: .normal)
        commitBtn.setTitle("123", for: .normal)
        commitBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(commitBtn)
        commitBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        // 1.有条件的for循环
        for subView in view.subviews {
            if let button = subView as? UIButton {
                
                button.setTitle("234", for: .normal)
            }
        }
        // 优秀1
        for case let button as UIButton in view.subviews {
            
            button.setTitle("345", for: .normal)
        }
        // 优秀2  暂时不可用
//        for button in view.subviews where button is UIButton {
//            //不可描述的事情
//            button.setTitle("456", for: .normal)
//        }
        
        // 2.遍历
        for index in 0..<view.subviews.count {
            
            let subView = view.subviews[index]
            subView.backgroundColor = .cyan
        }
        // 优秀
        for (index, subView) in view.subviews.enumerated() {
            
            print(index)
            subView.backgroundColor = .red
        }
        
        // 只用到一个时，另一个用“_”代替
        for (index, _) in view.subviews.enumerated() {
            
            print("haha：\(index)")
        }
        
        // 3.过滤
        let weaModel1 = WeatherModel()
        weaModel1.cityName = "11"
        weaModel1.text_day = "内容1"
        
        let weaModel2 = WeatherModel()
        weaModel2.cityName = "22"
        weaModel2.text_day = "内容2"
        let weaArr = [weaModel1, weaModel2]
        
        if let weaModel = weaArr.filter({$0.cityName == "22"}).first {
            print(weaModel.text_day)
        }
        // 优秀 first(where: )
        if let weaModel = weaArr.first(where: { $0.cityName == "22"}) {
            print(weaModel.text_day)
        }
        
        if !weaArr.filter({ $0.cityName == "11"}).isEmpty {
            print(true)
        }
        // 优秀 contains(where: )
        if weaArr.contains(where: { $0.cityName == "11" }) {
            print(true)
        }
        
        func removeAllData(name: String) {
            
        }
        
        // forEach
        weaArr.forEach { removeAllData(name: $0.cityName)}
        
        // 计算属性
        let string = Date().formattedString
        print(string)
        
    }
    
    @objc func btnAction() {
        
        self.BtnClosure!()
    }
}


class YourManager {

    static var shared: YourManager {
        get{
            return YourManager()
        }
        set(shared){
            print("222")
        }
    }
}

extension Date {
    
    var formattedString: String {
        get {
            return "234"
        }
        set(formattedString){
            print(formattedString)
        }
    }
    
}
