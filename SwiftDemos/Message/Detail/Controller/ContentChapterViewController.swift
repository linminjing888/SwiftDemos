//
//  ContentChapterViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/20.
//

import UIKit

class ContentChapterViewController: MJBaseViewController {
    
    private var isPositive: Bool = true
    
    var detailStatic: DetailStaticModel?
    
    weak var delegate: ComicViewWillEndDraggingDelegate?
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 30)/2, height: 40)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChapterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.register(ChapterCollectionCell.self, forCellWithReuseIdentifier: "collectionId")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

}

extension ContentChapterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.comicViewWillEndDragging(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailStatic?.chapter_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionId", for: indexPath) as! ChapterCollectionCell
        if isPositive {
            cell.chapterStatic = detailStatic?.chapter_list?[indexPath.row]
        } else {
            cell.chapterStatic = detailStatic?.chapter_list?.reversed()[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath) as! ChapterCollectionReusableView
        header.model = detailStatic
        header.sortClosure { [weak self] (button) in
            if self?.isPositive == true {
                self?.isPositive = false
                button.setTitle("正序", for: .normal)
            } else {
                self?.isPositive = true
                button.setTitle("倒序", for: .normal)
            }
            self?.collectionView.reloadData()
        }
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
        let index = isPositive ? indexPath.row : (detailStatic?.chapter_list?.count)! - indexPath.row - 1
        let VC = ChapterReadViewController(detailStatic: detailStatic, selectIndex: index)
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
}

extension ContentChapterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 44)
    }
}
