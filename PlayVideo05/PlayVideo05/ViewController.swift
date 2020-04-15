//
//  ViewController.swift
//  PlayVideo05
//
//  Created by MinJing_Lin on 2020/4/15.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let openBtn = UIButton(type: .custom)
        openBtn.setTitle("PalyVideo", for: .normal)
        openBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        openBtn.backgroundColor = .cyan
        openBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.view.addSubview(openBtn)
        
    }
    
    @objc func playVideo() {
        
        guard let urlStr = URL(string: "http://video.mzcfo.com/android/kuaisucaigou.mp4") else {
            return
        }
        let player = AVPlayer(url:urlStr)
        let playViewController = AVPlayerViewController()
        playViewController.player = player
        self.present(playViewController, animated: true) {
            
        }
        
    }


}

