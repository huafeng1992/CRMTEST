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
    
    var player: AVPlayer?
    
    var url: URL?
    
    var playcallBackFinished: (() -> Void)?
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    /// 播放结束
    @objc func playbackFinished() {
        if playcallBackFinished != nil {
            playcallBackFinished!()
        }
    }
}

extension AVPlayerManager {
    
    func play(_ url: URL) {
        
        if (url.absoluteString.contains(".amr")) {
            print("播放amr资源")
//            let wav = VoiceConverter_change.download(inWAV: url.absoluteString)
//            let urlpath = URL.init(fileURLWithPath: wav!)
//            player = AVPlayer.init(url: urlpath)
        } else {
            player = AVPlayer.init(url: url)
        }
        
        player!.play()
    }
    
    func pause() {
        if player != nil {
            player!.pause()
        }
    }
    
    func stop() {
        
        if player != nil {
            pause()
            player!.rate = 0
            player = nil
        }
    }
}
