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

    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let openBtn = UIButton(type: .custom)
        openBtn.setTitle("PalyVideo", for: .normal)
        openBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        openBtn.backgroundColor = .cyan
        openBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.view.addSubview(openBtn)
        
        let playAudioBtn = UIButton(type: .custom)
        playAudioBtn.setTitle("PlayAudio", for: .normal)
        playAudioBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        playAudioBtn.backgroundColor = .cyan
        playAudioBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        self.view.addSubview(playAudioBtn)
        
        let pauseAudioBtn = UIButton(type: .custom)
        pauseAudioBtn.setTitle("PauseAudio", for: .normal)
        pauseAudioBtn.frame = CGRect(x: 100, y: 300, width: 100, height: 40)
        pauseAudioBtn.backgroundColor = .cyan
        pauseAudioBtn.addTarget(self, action: #selector(pauseAudio), for: .touchUpInside)
        self.view.addSubview(pauseAudioBtn)
        
        initAudio()
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
    
    func initAudio() {
        let audioPath = Bundle.main.path(forResource: "live", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch {
            audioPlayer = nil
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error")
        }
    }
    
    @objc func playAudio() {
        audioPlayer?.play()
    }
    
    @objc func pauseAudio() {
        audioPlayer?.pause()
    }
    
}

