//
//  UIColor+Extension.swift
//  Weibo
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    class func colorWithHexStringSwift(_ colorStr:String) -> UIColor{
        if colorStr.characters.count < 6{
            return UIColor.clear
        }
        var color:String = colorStr
        
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if colorStr.hasPrefix("0x") {
            color  = colorStr.substring(from: colorStr.characters.index(colorStr.startIndex, offsetBy: 2))
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if colorStr.hasPrefix("#") {
            color = colorStr.substring(from: colorStr.characters.index(colorStr.startIndex, offsetBy: 1))
        }
        if color.characters.count != 6 {
            return UIColor.clear
        }
        let index = color.startIndex
        let index2 = color.characters.index(color.startIndex, offsetBy: 2)
        
        
        let red:String = color.substring(with: (index ..< index2))
        let green:String = color.substring(with: (color.characters.index(color.startIndex, offsetBy: 2) ..< color.characters.index(color.startIndex, offsetBy: 4)))
        let blue:String = color.substring(with: (color.characters.index(color.startIndex, offsetBy: 4) ..< color.characters.index(color.startIndex, offsetBy: 6)))
        var r:CUnsignedInt = 0 ,g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: red).scanHexInt32(&r)
        Scanner(string: green).scanHexInt32(&g)
        Scanner(string: blue).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
    class func backGroundColor() -> UIColor {
        return UIColor.init(red: 244.0/256.0, green: 244.0/256.0, blue: 244.0/256.0, alpha: 1)
    }
    
    
    
    class func randomClr() -> UIColor {
        
//        let r = CGFloat(random() % 255) / 255.0
//        let g = CGFloat(random() % 255) / 255.0
//        let b = CGFloat(random() % 255) / 255.0
        let r = CGFloat(arc4random_uniform(225)) / 255.0
        let g = CGFloat(arc4random_uniform(225)) / 255.0
        let b = CGFloat(arc4random_uniform(225)) / 255.0
        let randomColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return randomColor
    }
    
  }
