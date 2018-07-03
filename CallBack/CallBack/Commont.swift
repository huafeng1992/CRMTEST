//
//  Commont.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/3.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func colorWithHexString(hex:String) ->UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func colorWithHexString(hex:String, alph:CGFloat) -> UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alph))
    }
}

extension UIButton {
    
    func buttonCategoryTypeLeft(mars: CGFloat) {
        
        //需要在外部修改标题背景色的时候将此代码注释
        self.titleLabel?.backgroundColor = self.backgroundColor
        self.imageView?.backgroundColor = self.backgroundColor
        let titleSize: CGSize? = self.titleLabel?.bounds.size
        let imageSize: CGSize? = self.imageView?.bounds.size
        let interval: CGFloat = 1.0
        self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleSize?.width)! + interval, 0, -((titleSize?.width)! + interval))
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -((imageSize?.width)! + interval), 0, (imageSize?.width)! + interval)
    }
    
//    func buttonCategoryTypeBottom(mars: CGFloat) {
//
//        self.contentHorizontalAlignment = .center //使图片和文字水平居中显示
//
//        let imageViewWidth: CGFloat = self.imageView?.width ?? 0
//        let imageViewHeight: CGFloat = self.imageView?.height ?? 0
//
//        self.titleEdgeInsets = .init(top: (imageViewHeight + mars/2), left: -(imageViewWidth) , bottom: -mars/2, right: 0.0) //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//
//        let titleLabelWidth: CGFloat = self.titleLabel?.width ?? 0
//        let titleLabelHeight: CGFloat = self.titleLabel?.height ?? 0
//        self.imageEdgeInsets = .init(top: -(titleLabelHeight + mars)/2 , left: titleLabelWidth/2, bottom: (titleLabelHeight + mars)/2, right: -(titleLabelWidth/2) )//图片距离右边框距离减少图片的宽度，其它不边
//    }
}

func CommonColor(_ colorStr: String) -> UIColor {
    return UIColor.colorWithHexString(hex: colorStr)
}
