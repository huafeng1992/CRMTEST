//
//  CallPhone.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/3.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

struct CallCenter {
    
    static let center = CallCenter()
    
    var ctcall = CTCallCenter()
    
    func call(phone: String?) {
        
        guard let phone = phone else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let url = URL.init(string: "telprompt://" + phone)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let url = URL.init(string: "telprompt://" + phone)!
            UIApplication.shared.openURL(url)
        }
        
        ctcall.callEventHandler = {(call) in
            
            switch call.callState {
            case CTCallStateDisconnected:
                print("未接通")
            case CTCallStateConnected:
                print("通话中")
            case CTCallStateIncoming:
                print("来电中")
            case CTCallStateDialing:
                print("正在拨号")
            default:
                print("其余")
            }
            print(call.callState)
        }
    }
}
