//
//  BookDetailViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import UIKit

class BookDetailViewController: MJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        ApiLoadingProvider.request(MJApi.detailStatic(comicid: 3166), model: DetailStaticModel.self) { (detailStatic) in
            
            let name = detailStatic?.comic?.name ?? "-"
            print(name)
            self.title = name
        }
        
    }
    

}
