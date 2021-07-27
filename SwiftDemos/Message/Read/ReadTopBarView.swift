//
//  ReadTopBarView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/27.
//

import UIKit

class ReadTopBarView: UIView {

    lazy var backButton: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "nav_back_black"), for: .normal)
        return backBtn
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.textAlignment = .center
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 20))
        }
        
    }
}
