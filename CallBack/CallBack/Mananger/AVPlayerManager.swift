//
//  AVPlayerManager.swift
//  BaonahaoSchool
//
//  Created by 王华峰 on 2018/6/11.
//  Copyright © 2018年 XiaoHeTechnology. All rights reserved.
//

import Foundation
import AVFoundation

class AVPlayerManager: NSObject {
    
    var audioplayer: AVAudioPlayer?
    
    var player: AVPlayer?
    
    var url: URL?
    
    var playcallBackFinished: (() -> Void)?
    
    var timeObserver: Any?
    
    var playItem: AVPlayerItem?
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    /// 播放结束
    @objc func playbackFinished() {
        stop()
        if playcallBackFinished != nil {
            playcallBackFinished!()
        }
    }
}

extension AVPlayerManager {
    
    /// 播放并回调监听时间
    ///
    /// - Parameter url:
    func playAndBackCMTime(_ url: URL, observer: @escaping (_ currentTime: Double, _ realTotalTime: Double , _ cmtime: CMTime) -> Void) {
        play(url)
        if player != nil {

            timeObserver = player!.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: { (cmtime) in
                observer(Double(CMTimeGetSeconds(cmtime)), self.getTotalTime(), cmtime)
            })
        }
    }

    func play(_ url: URL) {
        
        if (url.absoluteString.contains(".amr")) {
            print("播放amr资源")
//            let wav = VoiceConverter_change.download(inWAV: url.absoluteString)
//            let urlpath = URL.init(fileURLWithPath: wav!)
//            player = AVPlayer.init(url: urlpath)
        } else {
            
            playItem = AVPlayerItem.init(url: url)
            
            print(CMTimeGetSeconds(playItem!.duration))
            player = AVPlayer.init(playerItem: playItem)
        }
        player!.play()
    }
    
    func goOn() {
        if player != nil {
            player!.play()
        }
    }
    
    func pause() {
        if player != nil {
            player!.pause()
        }
    }
    
    func stop() {
        
        if player != nil {
            pause()
            removeObserver()
            player!.rate = 0
            player = nil
        }
    }
    
    //MARK:- 移除播放回调
    func removeObserver() {
        if timeObserver != nil {
            player!.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
    }
}

extension AVPlayerManager {

    func seek(progress: Double) {
        guard let player = player else {
            return
        }
        let currentTime = getTotalTime() * progress
        let currentCMTTime = CMTime.init(seconds: currentTime, preferredTimescale: 1)
        player.seek(to: currentCMTTime, completionHandler: { (finished) in
            self.goOn()
        })
    }
    
    func getTotalTime() -> Double {
        guard let player = player else {
            return 0
        }
        guard let playerItem = player.currentItem else {
            return 0
        }
        return CMTimeGetSeconds(playerItem.duration)
    }
}
