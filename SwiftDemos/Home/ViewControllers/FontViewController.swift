//
//  MJFontViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit
import SnapKit

class MJFontViewController: MJBaseViewController {

    let label = UILabel()
    var fontNameArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        printAllFontNames()
        
        let imageView = UIImageView(image: UIImage(named: "icon"))
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(nav_bar_h + 20)
        }
        
        label.text = "123456789"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.centerX.equalTo(self.view)
        }
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("change", for: .normal)
        changeBtn.backgroundColor = .cyan
        changeBtn.addTarget(self, action: #selector(changeFont), for: .touchUpInside)
        self.view.addSubview(changeBtn)
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottomMargin).offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        
    }
    
    @objc func changeFont() {
        let count:Int = fontNameArr.count - 1
        let ran = Int.random(in: 0...count)
        label.font = UIFont(name: fontNameArr[ran], size: 30)
        print("==== \(fontNameArr[ran])")
        
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
