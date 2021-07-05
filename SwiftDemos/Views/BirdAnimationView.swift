//
//  BirdAnimationView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/5.
//

import UIKit

class BirdAnimationView: UIView {

    
    
    var backgroundView: UIView!
    var maskView: UIView!
    var animationView: UIView!
    
    backgroundView = UIView(frame:  .frame)
    backgroundView.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
    self.window!.addSubview(backgroundView)

    animationView = UIView(frame: backgroundView.frame)
    animationView.backgroundColor = UIColor.white
    backgroundView.addSubview(animationView)

    let logoLayer = CALayer()
    logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    logoLayer.position = backgroundView.center
    logoLayer.contents = UIImage(named: "logo")?.cgImage
    animationView.layer.mask = logoLayer
//
//        maskView = UIView(frame: backgroundView.bounds)
//        maskView.backgroundColor = .white
//        animationView.addSubview(maskView)

    let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
    logoAnimation.beginTime = CACurrentMediaTime() + 0.5
    logoAnimation.duration = 1
    logoAnimation.keyTimes = [0, 0.4, 1]
    logoAnimation.delegate = self
    logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 3000, height: 3000))]
    logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
    logoAnimation.fillMode = CAMediaTimingFillMode.forwards
    logoLayer.add(logoAnimation, forKey: "zoomAnimation")
//
    let logoOpacityAnimation = CABasicAnimation(keyPath: "opacity")
    logoOpacityAnimation.beginTime = CACurrentMediaTime() + 0.5
    logoOpacityAnimation.duration = 1
    logoOpacityAnimation.fromValue = 1
    logoOpacityAnimation.toValue = 0
    logoOpacityAnimation.delegate = self
    backgroundView.layer.add(logoOpacityAnimation, forKey: "opacityAnimation")

}
