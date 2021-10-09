//
//  MessageTabCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/7.
//

import UIKit

class MessageTabCell: UITableViewCell {

    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.layer.cornerRadius = 10
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    lazy var nickNameLbl: UILabel = {
        let nickNameLbl = UILabel()
        nickNameLbl.textColor = .mainTextColor // UIColor.darkGray
        nickNameLbl.font = UIFont.systemFont(ofSize: 15)
        return nickNameLbl
    }()
    
    lazy var detailLbl: UILabel = {
        let detailLbl = UILabel()
        detailLbl.textColor = UIColor.gray
        detailLbl.font = UIFont.systemFont(ofSize: 13)
        return detailLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(nickNameLbl)
        nickNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(iconView)
        }
        
        contentView.addSubview(detailLbl)
        detailLbl.snp.makeConstraints { (make) in
            make.left.equalTo(nickNameLbl)
            make.bottom.equalTo(iconView)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    var model: Item? {
        didSet {
            guard let model = model else {
                return
            }
            let url = model.user.thumb.replacingOccurrences(of: ".webp", with: ".jpg")
            iconView.kf.setImage(with: URL(string: url))
            nickNameLbl.text = model.user.login
            detailLbl.text = model.content
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
