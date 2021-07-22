//
//  CommentListTabCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/22.
//

import UIKit

class CommentListTabCell: UITableViewCell {
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.layer.cornerRadius = 20
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.textColor = UIColor.gray
        nickNameLabel.font = UIFont.systemFont(ofSize: 13)
        return nickNameLabel
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = UIColor.black
        return textView
    }()

    var viewModel: CommentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            iconView.kf.setImage(with: URL(string: (viewModel.model?.face)!))
            nickNameLabel.text = viewModel.model?.nickname
            contentTextView.text = viewModel.model?.content_filter
        }
    }
    
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
        
        contentView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(iconView)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(nickNameLabel)
            make.bottom.greaterThanOrEqualToSuperview().offset(-10)
        }
        
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

class CommentViewModel {
    var model: CommentModel?
    var height: CGFloat = 0
    
    convenience init(model: CommentModel) {
        self.init()
        self.model = model
        
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.text = model.content_filter
        let height = textView.sizeThatFits(CGSize(width: SCREEN_WIDTH - 70, height: CGFloat.infinity)).height
        self.height = max(60, height + 45)
        
    }
    
    required init() {}
    
}
