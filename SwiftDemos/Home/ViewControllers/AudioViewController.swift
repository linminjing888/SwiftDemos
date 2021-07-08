//
//  MJAudioViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit
import AVFoundation
import AVKit

class AudioViewController: MJBaseViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let playAudioBtn = UIButton(type: .custom)
        playAudioBtn.setTitle("PlayAudio", for: .normal)
        playAudioBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        playAudioBtn.backgroundColor = .orange
        playAudioBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        self.view.addSubview(playAudioBtn)
        
        let pauseAudioBtn = UIButton(type: .custom)
        pauseAudioBtn.setTitle("PauseAudio", for: .normal)
        pauseAudioBtn.frame = CGRect(x: 100, y: 300, width: 100, height: 40)
        pauseAudioBtn.backgroundColor = .orange
        pauseAudioBtn.addTarget(self, action: #selector(pauseAudio), for: .touchUpInside)
        self.view.addSubview(pauseAudioBtn)
        
        let playVideoBtn = UIButton(type: .custom)
        playVideoBtn.setTitle("PlayVideo", for: .normal)
        playVideoBtn.frame = CGRect(x: 100, y: 400, width: 100, height: 40)
        playVideoBtn.backgroundColor = .orange
        playVideoBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.view.addSubview(playVideoBtn)
        
        initAudio()
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
        if audioPlayer?.isPlaying == true {
            return
        }
        audioPlayer?.play()
    }
    
    @objc func pauseAudio() {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
        }
    }
    
    @objc func playVideo() {
        
        guard let urlStr = URL(string: "http://video.mzcfo.com/android/kuaisucaigou.mp4") else {
            return
        }
        
        let player = AVPlayer(url: urlStr)
        let playVC = AVPlayerViewController()
        playVC.player = player
        self.present(playVC, animated: true, completion: nil)

    }
}
