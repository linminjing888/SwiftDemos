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
        detailVC.delegate = self
        return detailVC
    }()
    
    private lazy var chapterVC: ContentChapterViewController = {
        let chapterVC = ContentChapterViewController()
        chapterVC.delegate = self
        return chapterVC
    }()
    
    private lazy var commentVC: ContentCommentViewController = {
        let commentVC = ContentCommentViewController()
        commentVC.delegate = self
        return commentVC
    }()
    
    private lazy var pageVC: MJPageViewController = {
        return MJPageViewController(titles: ["详情","目录","评论"], vcs: [detailVC, chapterVC, commentVC], pageStyle: .topTabBar)
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var header: BookDetailHeaderView = {
        return BookDetailHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navigationBarY + 150))
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    private var detailStatic: DetailStaticModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let group = DispatchGroup()
        
        group.enter()
        view.backgroundColor = UIColor.background
        ApiLoadingProvider.request(MJApi.detailStatic(comicid: 3166), model: DetailStaticModel.self) { [weak self] (detailStatic) in
            
            self?.detailStatic = detailStatic
            
            let name = detailStatic?.comic?.name ?? "-"
            self?.title = name
        
            self?.detailVC.detailStatic = detailStatic
            self?.chapterVC.detailStatic = detailStatic
            self?.commentVC.detailStatic = detailStatic
            
            self?.chapterVC.reloadData()
            
            self?.header.comicStatic = detailStatic?.comic
            
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
//            self?.detailVC.reloadData()
//            self.chapterVC.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.changeOrientationTo(landscapeRight: false)
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
        mainScrollView.contentOffset = CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height)
    }
    
    
    private func setupUI() {
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges).priority(.low)
            make.top.equalToSuperview()
        }
        
        let contentView = UIView()
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-navigationBarY)
        }
        
        addChild(pageVC)
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainScrollView.parallaxHeader.view = header
        mainScrollView.parallaxHeader.height = navigationBarY + 150
        mainScrollView.parallaxHeader.minimumHeight = navigationBarY
        mainScrollView.parallaxHeader.mode = .fill
    }
}

extension BookDetailViewController: ComicViewWillEndDraggingDelegate {
    
    func comicViewWillEndDragging(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: -self.mainScrollView.parallaxHeader.minimumHeight), animated: true)
        }else if scrollView.contentOffset.y < 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height), animated: true)
        }
    }
    
}

extension BookDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            if #available(iOS 15.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithTransparentBackground() // 重置背景和阴影颜
                navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                navBarAppearance.backgroundImage = UIImage(named: "nav_bg");
                navBarAppearance.shadowImage = UIImage();
                
                navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigationController?.navigationBar.standardAppearance = navBarAppearance
                self.navigationController?.navigationBar.isTranslucent = true;
            }else{
                navigationController?.barStyle(.theme)
            }
            navigationItem.title = detailStatic?.comic?.name
        }else {
            navigationController?.barStyle(.clear)
            navigationItem.title = ""
        }
    }
}
