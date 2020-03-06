//
//  Factory.swift
//  zjlao
//
//  Created by 张凯强 on 2016/11/7.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//
import UIKit
import MBProgressHUD
import Masonry
import Foundation
let goodsLabelColor = "333333"
let sellerNameColor = "333333"
let priceColor = "e95513"
let sales_monthColor = "999999"
/**快递价格*/
let postageColor = "999999"

extension String{
    /** 自定义计算多行(含单行)的字符串尺寸 */
    public func sizeWith(font strFont:UIFont, maxSize strMaxSize:CGSize) -> CGSize{
        let attr = [NSFontAttributeName:strFont]
        let str:NSString = (self as NSString)
        return str.boundingRect(with: strMaxSize, options: [NSStringDrawingOptions.usesFontLeading ,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attr, context: nil).size
        
        
    }
    /**自定义计算多行（含单行）改变行间距字间距后的字符串尺寸*/
    public func sizeWithAttribute(attribute: [String: Any]?, maxSize: CGSize) -> CGSize{
        let str:NSString = (self as NSString)
        return str.boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attribute, context: nil).size
    }
    
    func changelineSpaceAndWordSpace(lineSpace: CGFloat, wordSpace: CGFloat, font: UIFont, maxSize: CGSize) -> (textSize: CGSize, mutableStr: NSMutableAttributedString)? {
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        
        let attribute = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSKernAttributeName: wordSpace] as [String : Any]
        //属性字符串添加行间距属性
        let mutableStr: NSMutableAttributedString = NSMutableAttributedString.init(string: self, attributes: attribute)
        let size: CGSize = self.sizeWithAttribute(attribute: attribute, maxSize: maxSize)
        return (size, mutableStr)
    }
    
}


extension NSString {
    public func sizeWith(font strFont:UIFont, maxSize strMaxSize:CGSize) -> CGSize{
        let attr = [NSFontAttributeName:strFont]
        return self.boundingRect(with: strMaxSize, options: [NSStringDrawingOptions.usesFontLeading ,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attr, context: nil).size
        
        
    }
    
    
    
    
    
    
}
extension UIImage{
    class func creatImageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndPDFContext()
        return theImage
    }
}

func delePrice(price: NSString) -> NSMutableAttributedString{
    if price.length < 3 {
        return NSMutableAttributedString.init(string: "免费")
    }
    if var p = price as String? {
        p.insert(".", at: p.index(p.endIndex, offsetBy: -2))
        p.insert("￥", at: p.startIndex)
        //如果是整数那么去除小数点
        if p.hasSuffix(".00") {
            let range = p.index(p.endIndex, offsetBy: -3)..<p.endIndex
            p.removeSubrange(range)
        }
        let attributP: NSMutableAttributedString = NSMutableAttributedString.init(string: p)
        //如果还存在小数点
        
        if p.contains(".") {
            attributP.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], range: NSRange.init(location:  price.length + 1 + 1 - 2 , length: 2))
            
            
        }
        attributP.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
        
        return attributP
    }
    
}
/**在屏幕上面显示提示语句*/
func alert(message mess:String, timeInterval time: Int) -> (){
    let pro = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    pro.hide(animated: true, afterDelay: TimeInterval(time))
    pro.detailsLabel.text = mess
//    pro.detailsLabel.textColor = UIColor.black
//    pro.detailsLabel.backgroundColor = UIColor.clear
//    pro.detailsLabel.font = UIFont.boldSystemFont(ofSize: 17)
    pro.mode = MBProgressHUDMode.text
//    pro.backgroundColor = UIColor.clear
    
}



