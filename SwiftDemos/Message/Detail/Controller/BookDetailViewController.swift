//
//  BookDetailViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import UIKit

protocol ComicViewWillEndDraggingDelegate: class {
    
    func comicViewWillEndDragging (_ scrollView: UIScrollView)
}

class BookDetailViewController: MJBaseViewController {

    private lazy var detailVC: ContentDetailViewController = {
        let detailVC = ContentDetailViewController()
        return detailVC
    }()
    
    lazy var chapterVC: ContentChapterViewController = {
        let chapterVC = ContentChapterViewController()
        chapterVC.delegate = self
        return chapterVC
    }()
    
    lazy var commentVC: ContentCommentViewController = {
        let commentVC = ContentCommentViewController()
        commentVC.delegate = self
        return commentVC
    }()
    
    private lazy var pageVC: MJPageViewController = {
        return MJPageViewController(titles: ["详情","目录","评论"], vcs: [detailVC, chapterVC, commentVC], pageStyle: .topTabBar)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        view.backgroundColor = UIColor.background
        ApiLoadingProvider.request(MJApi.detailStatic(comicid: 3166), model: DetailStaticModel.self) { [weak self] (detailStatic) in
            
            let name = detailStatic?.comic?.name ?? "-"
            self?.title = name
            
            self?.detailVC.detailStatic = detailStatic
//            self?.detailVC.reloadData()
            self?.chapterVC.detailStatic = detailStatic
            self?.commentVC.detailStatic = detailStatic
            
            ApiProvider.request(MJApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0, thread_id: detailStatic?.comic?.thread_id ?? 0, page: -1), model: CommentListMode.self) { (commentList) in
                
                self?.commentVC.commentList = commentList
                group.leave()
            }
            
        }
        group.enter()
        ApiProvider.request(MJApi.guessLike, model: GuessLikeModel.self) { (guessData) in
            self.detailVC.guessLike = guessData
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.detailVC.reloadData()
        }
        
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
}

extension BookDetailViewController: ComicViewWillEndDraggingDelegate {
    
    func comicViewWillEndDragging(_ scrollView: UIScrollView) {
        print("333")
    }
    
}
