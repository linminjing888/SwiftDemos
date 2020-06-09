//
//  CustomPushTransition.swift
//  CustomTransition
//
//  Created by MinJing_Lin on 2020/6/9.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

// https://www.jianshu.com/p/cd0095024658 蛮详细的

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //1.获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ViewController
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DetailViewController
        let container = transitionContext.containerView
            
        // 创建一个 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let snapshotView = fromVC.selectedCell.imgVi.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = container.convert(fromVC.selectedCell.imgVi.frame, from: fromVC.selectedCell)
        fromVC.selectedCell.imgVi.isHidden = true
            
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
            
        // 都添加到 container 中。注意顺序不能错了
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
            //一定要记得动画完成后执行此方法，让系统管理 navigation
            transitionContext.completeTransition(true)
        }
    }
    

}
