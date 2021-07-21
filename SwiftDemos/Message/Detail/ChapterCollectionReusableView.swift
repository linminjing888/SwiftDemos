//
//  ChapterCollectionReusableView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/21.
//

import UIKit

/// 定义闭包
typealias ChapterHeaderSortClosure = (_ button: UIButton) -> Void

class ChapterCollectionReusableView: UICollectionReusableView {
    
    private var sortClosure: ChapterHeaderSortClosure?
    
    private lazy var chapterlbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    lazy var sortBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("倒序", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(sortBtnAction(button:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        addSubview(sortBtn)
        sortBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(44)
        }
        
        addSubview(chapterlbl)
        chapterlbl.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(sortBtn.snp.left).offset(-10)
        }
    }
    
    @objc fileprivate func sortBtnAction(button: UIButton) {
        guard let sortClosure = sortClosure else { return }
        sortClosure(button)
    }
    
    func sortClosure(_ closure: @escaping ChapterHeaderSortClosure) {
        sortClosure = closure
    }
    
    var model: DetailStaticModel? {
        didSet {
            guard let model = model else { return }
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            chapterlbl.text = "目录 \(format.string(from: Date(timeIntervalSince1970: model.comic?.last_update_time ?? 0))) 更新 \(model.chapter_list?.last?.name ?? "")"
            
        }
    }
    
}
