//
//  ReadBottomBarView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/27.
//

import UIKit

class ReadBottomBarView: UIView {

    lazy var menuSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = UIColor.theme
        slider.minimumTrackTintColor = UIColor.theme
        slider.isContinuous = false
        return slider
    }()
    
    lazy var deviceButton: UIButton = {
        let deviceBtn = UIButton(type: .custom)
        deviceBtn.setImage(UIImage(named: "readerMenu_changeScreen_horizontal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return deviceBtn
    }()
    
    lazy var lightBtn: UIButton = {
        let lightButton = UIButton(type: .custom)
        lightButton.setImage(UIImage(named: "readerMenu_luminance")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return lightButton
    }()
    
    lazy var chapterButton: UIButton = {
        let chapterButton = UIButton(type: .custom)
        chapterButton.setImage(UIImage(named: "readerMenu_catalog")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return chapterButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(menuSlider)
        menuSlider.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 40))
            make.height.equalTo(30)
        }
    
        let btnArr = [deviceButton, lightBtn, chapterButton]
        for i in 0...btnArr.count - 1 {
            let btn = btnArr[i]
            let padding = (SCREEN_WIDTH - 180)/4
            
            btn.frame = CGRect(x: padding + CGFloat(i) * padding * 2, y: 50, width: 60, height: 60)
            addSubview(btn)
            
        }
        
    }

}
