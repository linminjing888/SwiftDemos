//
//  BookDetailHeaderView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/26.
//

import UIKit

class BookDetailHeaderView: UIView {

    private lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        bgView.isUserInteractionEnabled = true
        bgView.contentMode = .scaleAspectFill
        bgView.blurView.setup(style: .dark, alpha: 0.9).enable()
        return bgView
    }()
    
    private lazy var coverView: UIImageView = {
        let coverView = UIImageView()
        coverView.contentMode = .scaleAspectFill
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        coverView.layer.borderColor = UIColor.white.cgColor
        coverView.layer.borderWidth = 1
        return coverView
    }()
    
    private lazy var nameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.textColor = UIColor.white
        nameLbl.font = UIFont.systemFont(ofSize: 16)
        return nameLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 20, right: 0))
            make.width.equalTo(90)
            make.height.equalTo(120)
        }
        
        bgView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(coverView.snp.right).offset(20)
            make.right.greaterThanOrEqualToSuperview().offset(-20)
            make.centerY.equalTo(coverView)
            make.height.equalTo(20)
        }
    }
    
    var comicStatic: ComicStaticModel? {
        didSet{
            guard let comicStatic = comicStatic else { return }
            bgView.kf.setImage(with: URL(string: comicStatic.cover ?? ""), placeholder: UIImage(named: "normal_placeholder_v"))
            coverView.kf.setImage(with: URL(string: comicStatic.cover ?? ""), placeholder: UIImage(named: "normal_placeholder_v"))
            nameLbl.text = comicStatic.name
        }
    }
    
}
