//
//  MyHeaderView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/7.
//

import UIKit

class MyHeaderView: UIView {

    private lazy var bgImgvi: UIImageView = {
        let bgImgVi = UIImageView()
        bgImgVi.contentMode = .scaleAspectFill
        return bgImgVi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(bgImgvi)
        bgImgvi.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        bgImgvi.image = UIImage(named: "mine_bg_for_boy")
    }

}
