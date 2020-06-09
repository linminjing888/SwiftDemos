//
//  CustomPushTransition.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/9.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DetailViewController
            let container = transitionContext.containerView
            
            let snapshotView = fromVC.selectedCell.imgVi.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = container.convert(fromVC.selectedCell.imgVi.frame, from: fromVC.selectedCell)
            fromVC.selectedCell.imgVi.isHidden = true
            
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.alpha = 0
            
            container.addSubview(toVC.view)
            container.addSubview(snapshotView!)
            toVC.bannerImgVi.layoutIfNeeded()
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions(), animations: {
                snapshotView?.frame = toVC.bannerImgVi.frame
                fromVC.view.alpha = 0
                toVC.view.alpha = 1
            }) { (finish) in
                snapshotView?.frame = toVC.bannerImgVi.frame
                fromVC.selectedCell.imgVi.isHidden = false
                toVC.bannerImgVi.image = toVC.img
                snapshotView?.removeFromSuperview()
                
                transitionContext.completeTransition(true)
            }
        }
    

}
