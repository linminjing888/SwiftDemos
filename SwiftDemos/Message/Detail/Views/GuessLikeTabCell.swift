//
//  GuessLikeTabCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/23.
//

import UIKit

typealias GuessLikeSelectClosure = (_ comic: BookModel) -> Void

class GuessLikeTabCell: UITableViewCell {
    
    private var didSelectClosure: GuessLikeSelectClosure?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.background
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GuessLikeCollectionCell.self, forCellWithReuseIdentifier: "collectionId")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let titleLbl = UILabel()
        titleLbl.text = "猜你喜欢"
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
            make.height.equalTo(20)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.left.bottom.right.equalToSuperview()
        }
        
    }
    
    var model: GuessLikeModel? {
        didSet{
            self.collectionView.reloadData()
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
    
    func didSelectClosure(closure: GuessLikeSelectClosure?) {
        didSelectClosure = closure
    }

}

extension GuessLikeTabCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionId", for: indexPath) as! GuessLikeCollectionCell
        cell.model = model?.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let book = model?.comics?[indexPath.row], let didSelectClosure = didSelectClosure else { return }
        didSelectClosure(book)
    }
    
}

extension GuessLikeTabCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 50) / 4
        let height = collectionView.frame.height - 10
        return CGSize(width: width, height: height)
    }
}
