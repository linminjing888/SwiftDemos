//
//  DescriptionTabCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/23.
//

import UIKit

class DescriptionTabCell: UITableViewCell {

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.textColor = UIColor.darkGray
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        let titleLbl = UILabel()
        titleLbl.text = "作品介绍"
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    var model: DetailStaticModel? {
        didSet{
            guard model != nil else { return }
            textView.text = "【\(model?.comic?.cate_id ?? "")】\(model?.comic?.description ?? "")"
        }
    }
    
    class func heightt(detailStatic: DetailStaticModel?) -> CGFloat {
        var height: CGFloat = 50.0
        guard let model = detailStatic else { return height}
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 15)
        textview.text = "【\(model.comic?.cate_id ?? "")】\(model.comic?.description ?? "")"
        height += textview.sizeThatFits(CGSize(width: SCREEN_WIDTH - 30, height: CGFloat.infinity)).height
        return height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
