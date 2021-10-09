//
//  TransDetailViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/8.
//

import UIKit

class TransDetailViewController: MJBaseViewController {

    var img: UIImage!
    var bannerImgVi: UIImageView!
    let desText = "郭：大伙来都是听相声的\n于：bai哎\n郭：人不少啊，我很欣du慰啊\n于：老词\n郭：多来啊，多捧啊，多捧咱们这些说相声的人\n于：相声演员\n郭：于。。。什么来着？\n于：忘了？于谦\n郭：哎，对了，对不起啊，我不怎么看这个法制进行时，你知道么\n于：跟法制进行时有什么关系啊\n郭：闹不清\n于：于谦\n郭：很有发展的一个相声演员，大伙多捧捧，我托付您了，谢谢各位\n于：这位还真向着我\n郭：我很喜欢你们这行的，相声好啊，弘扬真善美"
    
    fileprivate var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerImgVi = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        bannerImgVi.center.x = self.view.center.x
        self.view.addSubview(bannerImgVi)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 410, width: self.view.frame.width, height: self.view.frame.height - 430 - nav_bar_h))
        textView.text = desText
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.mainTextColor
        self.view.addSubview(textView)
        
        self.navigationController?.delegate = self
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureAction(edgePan:)))
        edgePanGesture.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgePanGesture)

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

extension TransDetailViewController: UINavigationControllerDelegate {
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
