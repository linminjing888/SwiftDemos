//
//  BookDetailViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import UIKit

class BookDetailViewController: MJBaseViewController {

    private lazy var detailVC: ContentDetailViewController = {
        let detailVC = ContentDetailViewController()
        return detailVC
    }()
    
    lazy var chapterVC: ContentChapterViewController = {
        let chapterVC = ContentChapterViewController()
        return chapterVC
    }()
    
    lazy var commentVC: ContentCommentViewController = {
        let commentVC = ContentCommentViewController()
        return commentVC
    }()
    
    private lazy var pageVC: MJPageViewController = {
        return MJPageViewController(titles: ["详情","目录","评论"], vcs: [detailVC, chapterVC, commentVC], pageStyle: .topTabBar)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        ApiLoadingProvider.request(MJApi.detailStatic(comicid: 3166), model: DetailStaticModel.self) { (detailStatic) in
            
            let name = detailStatic?.comic?.name ?? "-"
            print(name)
            self.title = name
        }
        
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    

}
