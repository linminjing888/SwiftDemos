//
//  CollectionViewCell.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/8.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imgVi : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgVi = UIImageView(frame: self.bounds)
        self.addSubview(imgVi)
    }
    
    func configCell(model:CollectionCellModel) {
        
        imgVi.image = model.image;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
