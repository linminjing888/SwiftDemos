//
//  ViewController.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/8.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var collectionView : UICollectionView!
    var dataSource : Array<CollectionCellModel>!
    var selectedCell : CollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.setupUI()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.delegate = self
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        self.view.addSubview(collectionView)
    }
    
    func setupData() {
        dataSource = Array<CollectionCellModel>()
        for _ in 0..<10 {
            let model = CollectionCellModel()
            model.image = UIImage(named: "icon")
            dataSource.append(model)
        }
        collectionView.reloadData()
    }

}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        cell.configCell(model: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        let detailVC = DetailViewController()
        detailVC.img = self.selectedCell.imgVi.image
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}

extension ViewController : UINavigationControllerDelegate {
  
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == UINavigationController.Operation.push {
//            return CustomPushTransition()
//        }else{
//            return nil
//        }
//    }
}

