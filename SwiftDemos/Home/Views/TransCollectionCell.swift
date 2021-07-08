//
//  TransCollectionCell.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/8.
//

import UIKit

class TransCollectionCell: UICollectionViewCell {
    
    var imgVi: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgVi = UIImageView(frame: self.bounds)
        contentView.addSubview(imgVi)
        
    }
    
    func configCell(model: TransitionModel) {
        
        imgVi.image = model.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
