//
//  ContentDetailViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/20.
//

import UIKit

class ContentDetailViewController: MJBaseViewController {

    weak var delegate: ComicViewWillEndDraggingDelegate?
    
    var detailStatic: DetailStaticModel?
    var guessLike: GuessLikeModel?
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = UIColor.mainBgColor
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.register(DescriptionTabCell.self, forCellReuseIdentifier: "desCellId")
        tab.register(GuessLikeTabCell.self, forCellReuseIdentifier: "guessId")
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBgColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }

}

extension ContentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.comicViewWillEndDragging(scrollView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailStatic != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return DescriptionTabCell.heightt(detailStatic: detailStatic)
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "desCellId", for: indexPath) as! DescriptionTabCell
            cell.model = detailStatic
            cell.selectionStyle = .none
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "guessId", for: indexPath) as! GuessLikeTabCell
            cell.model = guessLike
            cell.didSelectClosure { (comic) in
                print(comic.name as Any)
            }
            return cell
        }
    }
    
}
