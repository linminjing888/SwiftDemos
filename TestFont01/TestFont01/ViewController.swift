//
//  ViewController.swift
//  TestFont01
//
//  Created by MinJing_Lin on 2020/4/8.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel()
    var fontNameArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printAllFontNames()
        
        label.text = "Hello World"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.centerX.equalTo(self.view)
        }
    
        let changeBtn = UIButton(type: .custom);
        changeBtn.setTitle("change", for: .normal)
        changeBtn.backgroundColor = .cyan
        changeBtn.addTarget(self, action: #selector(changeFont), for: .touchUpInside)
        self.view.addSubview(changeBtn)
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(label).offset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
        }
        
    }

    
    @objc func changeFont() {
        let count:Int = fontNameArr.count
        let number:Int = Int(arc4random()) % count
        label.font = UIFont(name: fontNameArr[number], size: 30)
    }
    
    func printAllFontNames() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
//                print("==== \(fontName)")
                fontNameArr.append(fontName)
            }
        }
    }

}

