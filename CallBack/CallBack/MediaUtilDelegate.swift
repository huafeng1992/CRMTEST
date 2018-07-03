//
//  MediaUtilDelegate.swift
//  BaonahaoSchool
//
//  Created by 王华峰 on 2018/6/11.
//  Copyright © 2018年 XiaoHeTechnology. All rights reserved.
//

import Foundation

protocol MediaUtilDelegate { }
extension MediaUtilDelegate {
    
    // 处理时间 以 分:m 秒:s 标记
    func timeChange(_ duration: Double) -> String {
        let timeInt = Int(duration)
        if timeInt < 60 {
            return "\(timeInt)s"
        } else if timeInt >= 60 {
            let m = timeInt/60
            let s = duration.truncatingRemainder(dividingBy: 60)
            return "\(m)m\(Int(s))s"
        } else {
            return ""
        }
    }
    
    // 处理时间 以 分:' 秒:" 标记
    func timeChangInTime(_ duration: Double) -> String {
        
        let timeInt = Int(duration)
        if timeInt < 60 {
            return "00'\(getFormat(timeInt))\""
        } else if timeInt >= 60 {
            let m = timeInt/60
            let s = duration.truncatingRemainder(dividingBy: 60)
            return "\(getFormat(m))'\(getFormat(Int(s)))\""
        } else {
            return ""
        }
    }
    
    // 处理时间 以 00:00:00 标记
    func timeInHHMMSS(_ duration: Double) -> String {
        if duration.isNaN {
            return "--:--"
        }
        let timeInt = Int(duration)
        if timeInt < 60 * 60 {
            if timeInt < 60 {
                return "00:\(getFormat(timeInt))"
            } else {
                let m = timeInt/60
                let s = duration.truncatingRemainder(dividingBy: 60)
                return "\(getFormat(m)):\(getFormat(Int(s)))"
            }
        } else {
            let m = timeInt/60
            let h = m/60
            let s = duration.truncatingRemainder(dividingBy: 60)
            return "\(getFormat(h)):\(getFormat(m-h*60)):\(getFormat(Int(s)))"
        }
    }
    
    private func getFormat(_ timeInt: Int) -> String {
        if timeInt < 10 {
            return "0\(timeInt)"
        } else {
            return "\(timeInt)"
        }
    }
}
