//
//  PlayerView.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/3.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PlayerView: UIView, MediaUtilDelegate {
    
    enum PlayStatus {
        case start
        case pause
    }
    
    var mp3Path = "http://xiaohe-online.oss-cn-beijing.aliyuncs.com/emulation/audios/homework/02DF4E50AF20688B4F0F0464EF625B381528885269.mp3"
    
    /// 记录加载状态
    var loading: Bool = false
    
    var playerManager: AVPlayerManager!
    
    var totalTime: Double?
    
    var sliderIndex: Float?
    
    var playLoadingImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage.init(named: "bg_roll_startImage")
        imageview.isHidden = true
        return imageview
    }()
    
    var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setImage(UIImage.init(named: "crm_contact_playstart"), for: .normal)
        playButton.setImage(UIImage.init(named: "crm_contact_playpause"), for: .selected)
        return playButton
    }()
    
    var slider: Slider = {
        let slider = Slider.init(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.backgroundColor = .clear
        slider.isContinuous = false
        return slider
    }()
    
    var playTimeLab: UILabel = {
        let playtimeLab = UILabel()
        playtimeLab.text = "00:00"
        playtimeLab.textColor = CommonColor("007AFF")
        playtimeLab.font = UIFont.systemFont(ofSize: 10)
        return playtimeLab
    }()
    
    var allTimeLab: UILabel = {
        let allTimeLab = UILabel()
        allTimeLab.text = "--:--"
        allTimeLab.textColor = CommonColor("007AFF")
        allTimeLab.font = UIFont.systemFont(ofSize: 10)
        return allTimeLab
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
        playerManager = AVPlayerManager()
        
        addAllView()
        playButton.addTarget(self, action: #selector(playButtonAction(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchDragInside(_:)), for: .touchDragInside)
    }
    
    @objc func playButtonAction(_ btn: UIButton) {
        
//        if !btn.isSelected && loading == true {
//            loading = false
//            removeImageAnumation()
//        }
//
//        if !btn.isSelected && loading == false {
//            loading = true
//            startImageAnumation()
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//                btn.isSelected = !btn.isSelected
//                self.loading = false
//                self.removeImageAnumation()
//            }
//        }
//
//        if btn.isSelected {
            btn.isSelected = !btn.isSelected
//            // 处理关闭/暂停
//
            if btn.isSelected {
                let url = URL(string: mp3Path)
                playerManager.playAndBackCMTime(url!) { (currentTime, totalTime, cmtime) in
                    self.playTimeLab.text = self.timeInHHMMSS(currentTime)
                    self.allTimeLab.text = self.timeInHHMMSS(totalTime)
                    
                    self.sliderIndex = Float(currentTime/totalTime)
                    self.slider.setValue(self.sliderIndex!, animated: true)
                    self.totalTime = totalTime
                }
            } else {
                playerManager.stop()
                self.totalTime = nil
                self.slider.setValue(0, animated: false)
            }
//        }
    }
    
    
    @objc func sliderTouchDragInside(_ sender: UISlider) {
        print("开始滑动")
        if self.sliderIndex != nil {
            if self.sliderIndex != sender.value {
                self.playerManager.pause()
            }
        }
        
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
    
        if let playerItem = playerManager.player?.currentItem, let total = totalTime  {
            
            switch playerItem.status {
            case .readyToPlay:
//                playerManager.player?.pause()
                playerManager.player?.seek(to: playerManager.getCMTime(total * Double(slider.value)), completionHandler: { (finished) in
                        self.playerManager.goOn()
                })
            default:
                break
            }
        }
    }
    
    func addAllView() {
        
        self.addSubview(playLoadingImageView)
        playLoadingImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.width.height.equalTo(50)
        }
        
        self.addSubview(playButton)
        playButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(12)
            $0.width.height.equalTo(44)
        }
        
        slider.setThumbImage(UIImage.init(named: "dot"), for: .normal)
        slider.maximumTrackTintColor = CommonColor("#E1E1E1")
        slider.minimumTrackTintColor = CommonColor("#007aff")
        self.addSubview(slider)
        slider.snp.makeConstraints{
            $0.left.equalToSuperview().offset(69)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview().offset(-2)
        }
        
        self.addSubview(playTimeLab)
        playTimeLab.snp.makeConstraints{
            $0.left.equalTo(slider)
            $0.top.equalTo(slider.snp.bottom).offset(-9)
            $0.height.equalTo(14)
        }
        
        self.addSubview(allTimeLab)
        allTimeLab.snp.makeConstraints{
            $0.right.equalTo(slider)
            $0.top.equalTo(playTimeLab)
            $0.height.equalTo(playTimeLab)
        }
    }
}

extension PlayerView {
    
    func startImageAnumation() {
        playLoadingImageView.isHidden = false
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 8 * Double.pi
        anim.duration = 4
        anim.repeatCount = MAXFLOAT
        //            anim.isRemovedOnCompletion = true
        anim.isCumulative = true
        playLoadingImageView.layer.add(anim, forKey: nil)
        UIView.animate(withDuration: 0.4) {
            //                M_PI
            self.playLoadingImageView.transform = self.playLoadingImageView.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    
    func removeImageAnumation() {
        playLoadingImageView.layer.removeAllAnimations()
        playLoadingImageView.isHidden = true
    }
    
}
