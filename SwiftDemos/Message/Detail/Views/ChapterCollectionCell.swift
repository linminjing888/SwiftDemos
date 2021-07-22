//
//  ChapterCollectionCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/21.
//

import UIKit

class ChapterCollectionCell: UICollectionViewCell {
    
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        contentView.backgroundColor = UIColor.white
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    var chapterStatic: ChapterStaticModel? {
        didSet {
            guard let name = chapterStatic?.name else { return }
            nameLbl.text = name
        }
    }
    
}
