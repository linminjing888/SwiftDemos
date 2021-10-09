//
//  GuessLikeCollectionCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/23.
//

import UIKit

class GuessLikeCollectionCell: UICollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        return iconView
    }()
    
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.textColor = UIColor.mainTextColor
        titleLbl.font = UIFont.systemFont(ofSize: 14)
        return titleLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            make.height.equalTo(25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(titleLbl.snp.top)
        }
    }
    
    var model: BookModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(with: URL(string: model.cover ?? ""))
            titleLbl.text = model.name
        }
    }
    
}
