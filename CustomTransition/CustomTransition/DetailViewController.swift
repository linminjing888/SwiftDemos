//
//  DetailViewController.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/8.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var bannerImgVi : UIImageView!
    var img : UIImage!
    let RothkoDesciption = "郭：大伙来都是听相声的\n于：bai哎\n郭：人不少啊，我很欣du慰啊\n于：老词\n郭：多来啊，多捧啊，多捧咱们这些说相声的人\n于：相声演员\n郭：于。。。什么来着？\n于：忘了？于谦\n郭：哎，对了，对不起啊，我不怎么看这个法制进行时，你知道么\n于：跟法制进行时有什么关系啊\n郭：闹不清\n于：于谦\n郭：很有发展的一个相声演员，大伙多捧捧，我托付您了，谢谢各位\n于：这位还真向着我\n郭：我很喜欢你们这行的，相声好啊，弘扬真善美"
    
    fileprivate var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        bannerImgVi = UIImageView(frame: CGRect(x: 10, y: 50, width: 400, height: 400))
        bannerImgVi.center.x = self.view.center.x
        self.view.addSubview(bannerImgVi)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 500, width: self.view.frame.width, height: self.view.frame.height - 500))
        textView.text = RothkoDesciption
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = UIColor.black
        textView.textColor = UIColor.white
        self.view.addSubview(textView)
        
        self.navigationController?.delegate = self
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureAction(edgePan:)))
        edgePanGesture.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgePanGesture)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func edgePanGestureAction(edgePan:UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
            
        if edgePan.state == UIGestureRecognizer.State.began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        } else if edgePan.state == UIGestureRecognizer.State.changed {
            self.percentDrivenTransition?.update(progress)
        } else if edgePan.state == UIGestureRecognizer.State.cancelled || edgePan.state == UIGestureRecognizer.State.ended {
            
            // 加上这句判断，会有bug
//            if progress > 0.5 {
//                self.percentDrivenTransition?.finish()
//            } else {
//                self.percentDrivenTransition?.cancel()
//            }
            
            self.percentDrivenTransition?.finish()
            self.percentDrivenTransition = nil
        }
    }

}

extension DetailViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationController.Operation.pop {
            return CustomPopTransition()
        }
        else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is CustomPopTransition {
            return self.percentDrivenTransition
        }
        else {
            return nil
        }
    }
}
