//
//  ContentCommentViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/20.
//

import UIKit
import MJRefresh

class ContentCommentViewController: MJBaseViewController {

    private var listArray = [CommentViewModel]()
    
    var detailStatic: DetailStaticModel?
    var commentList: CommentListMode? {
        didSet {
            guard let commentList = commentList?.commentList else { return }
            let viewModel = commentList.compactMap { (comment) -> CommentViewModel? in
                return CommentViewModel(model: comment)
            }
            listArray.append(contentsOf: viewModel)
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommentListTabCell.self, forCellReuseIdentifier: "commentId")
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadData))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
    }
    
    @objc func loadData() {
        
        ApiLoadingProvider.request(MJApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0,
                                                     thread_id: detailStatic?.comic?.thread_id ?? 0,
                                                     page: commentList?.serverNextPage ?? 0),
                                   model: CommentListMode.self) { (commentList) in
            if commentList?.hasMore == true {
                self.tableView.mj_footer?.endRefreshing()
            } else {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
            self.commentList = commentList
            self.tableView.reloadData()
        }
        
    }

}

extension ContentCommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        listArray[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentId", for: indexPath) as! CommentListTabCell
        cell.viewModel = listArray[indexPath.row]
        return cell
    }
    
}
