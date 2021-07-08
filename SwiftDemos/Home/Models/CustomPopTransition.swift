//
//  CustomPopTransition.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/9.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class CustomPopTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! TransDetailViewController
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! TransitionViewController
        let container = transitionContext.containerView
        
        let snapshotView = fromVC.bannerImgVi.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = container.convert(fromVC.bannerImgVi.frame, from: fromVC.view)
        fromVC.bannerImgVi.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.selectedCell.imgVi.isHidden = true
        
        container.insertSubview(toVC.view, belowSubview: fromVC.view)
        container.addSubview(snapshotView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIView.AnimationOptions(), animations: {
            snapshotView?.frame = container.convert(toVC.selectedCell.imgVi.frame, from: toVC.selectedCell)
            fromVC.view.alpha = 0
            toVC.view.alpha = 1
        }) { (finish) in
            toVC.selectedCell.imgVi.isHidden = false
            snapshotView?.removeFromSuperview()
            fromVC.bannerImgVi.isHidden = false
            
           transitionContext.completeTransition(true)
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
