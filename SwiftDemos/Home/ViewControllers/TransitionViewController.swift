//
//  TransitionViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/8.
//

import UIKit

class TransitionViewController: MJBaseViewController {

    var collectionView: UICollectionView!
    var dataArr : Array<TransitionModel>!
    var selectedCell: TransCollectionCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()

    }
    
    override func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - nav_bar_h), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        
        collectionView.register(TransCollectionCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    func setupData() {
        dataArr = Array()
        for _ in 0..<10 {
            let model = TransitionModel()
            model.image = UIImage(named: "icon")
            dataArr.append(model)
        }
        collectionView.reloadData()
    }

}

extension TransitionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = collectionView.cellForItem(at: indexPath) as? TransCollectionCell
        let detail = TransDetailViewController()
        detail.img = self.selectedCell.imgVi.image
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
}

extension TransitionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TransCollectionCell
        cell.configCell(model: dataArr[indexPath.row])
        return cell
    }
    
}

extension TransitionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


extension TransitionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationController.Operation.push {
            return CustomPushTransition()
        }else {
            return nil
        }
    }
}
