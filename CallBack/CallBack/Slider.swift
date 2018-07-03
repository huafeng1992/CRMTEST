//
//  Slider.swift
//  CallBack
//
//  Created by 华峰 on 2018/7/4.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit

class Slider: UISlider {
    
    var isTouch: Bool = false
    
    var touchesBeganEventBack: ((UISlider) -> Void)?
    var touchesEndedEventBack: ((UISlider) -> Void)?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouch = true
        if touchesBeganEventBack != nil {
            touchesBeganEventBack!(self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouch = false
        if touchesEndedEventBack != nil {
            touchesEndedEventBack!(self)
        }
    }
}
