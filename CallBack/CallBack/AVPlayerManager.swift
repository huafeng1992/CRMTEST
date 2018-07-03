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
    
    var timeObserve: Any?
    
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
    
    /// 播放并回调监听时间
    ///
    /// - Parameter url: <#url description#>
    func playAndBackCMTime(_ url: URL, observer: @escaping (_ currentTime: Double, _ totalTime: Double, _ cmtime: CMTime) -> Void) {
        play(url)
        if player != nil {
            timeObserve = player!.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: { (cmtime) in
                
                let current = Double(CMTimeGetSeconds(cmtime))
                var total: Double = 0
                print(cmtime)
                
                // 获取总时长
                let currentItem = self.player?.currentItem
                let loadedRanges = currentItem?.seekableTimeRanges
                if loadedRanges != nil {
                    if loadedRanges!.count > 0 {
                        let range: CMTimeRange = loadedRanges![0] as! CMTimeRange
                        let duration: Float64 = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration)
                        total = Double(duration)
                    }
                }
                
//                NSArray* loadedRanges = currentItem.seekableTimeRanges;
//                if (loadedRanges.count > 0)
//                {
//                    CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];
//                    Float64 duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);
//                    // 当前播放总时间
//                    NSLog(@"duration:%g", duration);
//                }
                
                print("**** total:\(total)")
                observer(current, total, cmtime)
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
            
            let item = AVPlayerItem.init(url: url)
            
            print(CMTimeGetSeconds(item.duration))
            player = AVPlayer.init(playerItem: item)
            
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
            if timeObserve != nil {
                player!.removeTimeObserver(timeObserve!)
                timeObserve = nil
            }
            player!.rate = 0
            player = nil
        }
    }
}

extension AVPlayerManager {
    
    func getCMTime(_ duration: Double) -> CMTime {
        let cmtime = CMTime.init(seconds: duration, preferredTimescale: 1)
        return cmtime
    }
}
