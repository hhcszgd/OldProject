//
//  String+extension.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/11.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import CryptoSwift

extension String {
    //MARK: -MD5算法
    func md5() ->String!{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)//如果报错就在bridgeing-header中加上#import <CommonCrypto/CommonDigest.h>
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
    ///解码
//    func aesDecrypt(key: String) throws -> [String: String]? {
        //        let key = "4974949650676986"
//        let iv = key
//        //        let str = "uLjChSYtNCkPYkKV9kmkP5GCA/rAbHHCWRWaVxQC36VrX/voRhvV1RhVNGq1lHBR4Wb7uzU97DMT3qe4rSIVNQ=="
//        let data1 = self.data(using: String.Encoding.utf8)!
//        let data = Data(base64Encoded: data1)!
//
//        let decrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).decrypt([UInt8](data))
//        let decryptedData = Data(decrypted)
//        let result = String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
//        let josnData = result.data(using: String.Encoding.utf8)
//        do {
//            let dict = try JSONSerialization.jsonObject(with: josnData!, options: JSONSerialization.ReadingOptions.mutableContainers)
//            if let josnDic = dict as? [String: String] {
//                return josnDic
//            }else {
//                return nil
//            }
//        } catch {
//            return nil
//        }
        
//    }
    ///MARK: Unicode转中文
    var unicodeStr:String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = ("\"" + tempStr2) + "\""
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: PropertyListSerialization.MutabilityOptions(), format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
    ///MARK:计算多行字符串的size
    func sizeWith(font : UIFont , maxSize : CGSize) -> CGSize {
        var tempMaxSize = CGSize.zero
        if maxSize == CGSize.zero {
            tempMaxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        }else{
            tempMaxSize = maxSize
        }
        let attribute = Dictionary(dictionaryLiteral: (NSAttributedStringKey.font,font) )
        let size = self.boundingRect(with: tempMaxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin , NSStringDrawingOptions.usesFontLeading], attributes: attribute, context: nil).size
        return  size
    }
    ///MARK:计算多行字符串的size
    func sizeWith(font : UIFont , maxWidth : CGFloat) -> CGSize {
        var tempMaxSize = CGSize.zero
        if maxWidth == 0 {
            tempMaxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        }else{
            tempMaxSize = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))
        }
        let attribute = Dictionary(dictionaryLiteral: (NSAttributedStringKey.font,font) )
        let size = self.boundingRect(with: tempMaxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin , NSStringDrawingOptions.usesFontLeading], attributes: attribute, context: nil).size
        return  size
    }
    
    func firstCharactorWithString() -> String {
        if #available(iOS 9.0, *) {
            if let str1 = self.applyingTransform(StringTransform.toLatin, reverse: false) as? String {
                if let str2 = str1.applyingTransform(.stripCombiningMarks, reverse: false) as? String {
                    let index = str2.index(str2.startIndex, offsetBy: 1)
                    let str3 = str2.prefix(upTo: index)
                    return String.init(str3)
                    
                }
                
            }
            return ""
        }else {
            
            var str = NSMutableString.init(string: self) as CFMutableString
            CFStringTransform(str, nil, kCFStringTransformToLatin, false)
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
            let str2 = CFStringCreateWithSubstring(nil, str, CFRangeMake(0, 1))
            return String(str2!)
        }
    }
    
  
    
    
    
    //MARK:计算单行字符串的size
    func sizeSingleLine(font : UIFont ) -> CGSize  {
        return self.size(withAttributes: Dictionary(dictionaryLiteral: (NSAttributedStringKey.font,font) ))
    }
    
}
