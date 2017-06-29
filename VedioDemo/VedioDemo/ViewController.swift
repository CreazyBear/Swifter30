//
//  ViewController.swift
//  VedioDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit


class ViewController: UIViewController {
    
    fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel: Float = 1.0
    fileprivate let contentURL : URL = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
    fileprivate var startTime: CGFloat = 0.0
    fileprivate var duration: CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        moviePlayer.view.frame = view.frame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubview(toBack: moviePlayer.view)
        setMoviePlayer(contentURL)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupVedio() {
        moviePlayerSoundLevel = 1.0
        moviePlayer.view.alpha = 0.8
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: moviePlayer.player?.currentItem)
    }
    
    fileprivate func setMoviePlayer(_ url: URL){
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            if let path = videoPath as URL? {
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        self.moviePlayer.player = AVPlayer(url: path)
                        self.moviePlayer.player?.play()
                        self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
                    }
                }
            }
        }
    }
    
    @objc
    func playerItemDidReachEnd() {
        moviePlayer.player?.seek(to: kCMTimeZero)
        moviePlayer.player?.play()
    }

}

