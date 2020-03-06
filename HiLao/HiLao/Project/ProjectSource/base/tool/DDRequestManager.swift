//
//  DDRequestManager.swift
//  ZDLao
//
//  Created by WY on 2017/10/17.
//  Copyright © 2017年 com.16lao. All rights reserved.
/*
 status = 1;
 id = 4;
 name = JohnLock;
 token = 5ebfcf173717960b25b270f06c401d20;
 avatar = http://f0.ugshop.cn/FilF9WGuUGZW5eX-WtfvpFoeTsaY;
 */

import UIKit
import Alamofire
import CoreLocation
class DDRequestManager: NSObject {
//    let baseUrl = "http://api.hilao.cc/"
    let hostSurfix  = "cc"
//    let baseUrl = "http://member.hilao.cc/"
let client = COSClient.init(appId: "1252043302", withRegion: "bj")
    var token : String? = "token"
    static let share : DDRequestManager = DDRequestManager()
    private func performRequest(url : String,method:HTTPMethod , parameters: Parameters? ,  print : Bool = false  ) -> DataRequest? {
        var parameters = parameters
        parameters?["l"] = DDLanguageManager.languageIdentifier
        parameters?["c"] = DDLanguageManager.countryCode
        let url = replaceHostSurfix(urlStr: url, surfix: hostSurfix)
        if let url  = URL(string: url){
            let result = Alamofire.request(url , method: HTTPMethod.post , parameters: parameters ).responseJSON(completionHandler: { (response) in
                if print{mylog(response.debugDescription.unicodeStr)}
                switch response.result{
                case .success :
                    break
                    
                case .failure :
//                    GDAlertView.alert("error", image: nil , time: 2, complateBlock: nil )//请求超时处理
                    break
                }
            })
            return result
        
//                .responseJSON(completionHandler: { (response) in
//                mylog(String.init(data: response.data ?? Data(), encoding: String.Encoding.utf8))
//                mylog("print request result -->:\(response.result)")
//                "xx".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//                let testOriginalStr = "http://www.hailao.com/你好世界"
//                let urlEncode = testOriginalStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//                let urlDecodeStr = urlEncode?.removingPercentEncoding
//                mylog("encode : \(urlEncode)")
//                mylog("decode : \(urlDecodeStr)")
//                
//                let tt = "\\U751f\\U6210key\\U6210\\U529f"
////                mylog("tttt\(tt.u)")
//            })
        }else{return nil }
    }
    private  func replaceHostSurfix( urlStr : String , surfix : String = "cn") -> String {
//        var urlStr = "http://www.baidu.com/fould/index.html?name=name"
        var urlStr  = urlStr
        if let url = URL(string: urlStr) {
            var host = url.host ?? ""
            let http = url.scheme ?? "" //http or https
            let index = host.index(host.endIndex, offsetBy: -3)
            let willReplaceStr = "\(http)://\(host)"
            let willReplaceRange = willReplaceStr.startIndex..<willReplaceStr.endIndex
            host.removeSubrange(index..<host.endIndex)
            if !host.hasSuffix("."){host = "\(host)."}
            host.append(contentsOf: surfix)
            let destinationStr  = "\(http)://\(host)"
            urlStr.replaceSubrange(willReplaceRange, with: destinationStr)
            mylog("converted:\(urlStr)")
        }
        return urlStr
    }
  
    /*
    获取验证码key值
     作者：张宏雷
     接口地址： http://api.hilao.dev/passport/getValidateCodeKey
     */
//    @discardableResult
//    func getKey() -> DataRequest? {
//        let url  =  "http://api.hilao.cn/passport/getValidateCodeKey"
//        let para = ["l":"zh_cn" , "c":"110"]
//        return performRequest(url: url , method: HTTPMethod.post, parameters: para)
//    }
    /*
     作者：张宏雷
     接口地址： http://api.hilao.cc/index/index
     请求方式：POST
     l    是    String    语言代码
     c    是    Int    国家id
     lon    是    String    用户经度坐标
     lat    是    String    用户纬度坐标
     
     */
    @discardableResult
    func homePageTopData(_ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://api.hilao.cc/index/index"
        let para = ["lon" : longtitude , "lat" : latitude]
        return  performRequest(url: url , method: HTTPMethod.post, parameters: para , print : print )
    }
    
    /// 获取周边商家
    ///
    /// - 接口api:http://api.hilao.cc/index/nearbyShop
    /// - requestMetho : POST
    @discardableResult
    func homepageNearbyShops(page:Int ,coordinate:CLLocationCoordinate2D? = nil,_ print : Bool = false ) -> DataRequest? {
        var longtitude : String = ""
        var latitude : String = ""
        let location = DDLocationManager.share.locationManager.location
         longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
         latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        if let unWrapCoordinate = coordinate {
            longtitude = "\(unWrapCoordinate.longitude)"
            latitude = "\(unWrapCoordinate.latitude)"
        }
        let url  =  "http://api.hilao.cc/index/nearbyShop"
        let para = ["lon" : longtitude , "lat" : latitude , "p" : "\(page)"]
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    ///  搜索主页
    ///
    /// http://api.hilao.cc/index/searchIndex
    ///POST
    @discardableResult
    func hotSearch(_ print : Bool = false ) -> DataRequest? {
        let url  =  "http://api.hilao.cc/Search/searchIndex"
        let para = [ "member_id" : DDAccount.share().id ?? 0  , "token" : DDAccount.share().token] as [String : Any]
//        let para = [ "member_id" : 95  , "token" : "101faa72fd8cd4f1cdb5ef3ca6e8d49c29cd36e9"] as [String : Any]
        
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    ///   搜索（*结果数据有待确定）
    ///
    ///接口地址： http://api.hilao.cc/index/search
    ///请求方式：POST
    @discardableResult
    func performSearchShop(keyword : String , _ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://api.hilao.cc/search/search"
        var  para = [ "lon" : longtitude , "lat" : latitude ,  "keyword":keyword  , "token" : DDAccount.share().token]
        if let userID =  DDAccount.share().id {
            para["member_id"] = "\(userID)"
        }
        
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /// 店铺详情
    
    @discardableResult
    func shopDetail(shopID : String , _ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://shop.hilao.cc/shop/shopinfo"
        var  para = [ "lon" : longtitude , "lat" : latitude ,  "shop_id":shopID  , "token" : DDAccount.share().token]
        if let userID =  DDAccount.share().id {
            para["member_id"] = "\(userID)"
        }
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /// 互动
    @discardableResult
    func huDong(page : Int , _ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://interactive.hilao.cc/Index/interactive"
        let  para = [ "lng" : longtitude , "lat" : latitude ,  "page":"\(page)"  ]
        return performRequest(url: url , method: HTTPMethod.get, parameters: para, print : print )
    }
    /// 评论详情页分两个接口
    /// 第一个是:评论本身
    ///    http://comment.hilao.dev/comment/commentinfo
    @discardableResult
    func commentDetail(commentID : String , _ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://comment.hilao.cc/comment/commentinfo"
        let  para = [ "lng" : longtitude , "lat" : latitude ,  "comment_id": commentID  ]
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /// 第二个是:给这条评论的回复列表
    ///    http://comment.hilao.dev/comment/commentinfo
    @discardableResult
    func commentReplyList(commentID : String , _ print : Bool = false ) -> DataRequest? {
        let location = DDLocationManager.share.locationManager.location
        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://comment.hilao.cc/comment/commentreplylist"
        let  para = [ "lng" : longtitude , "lat" : latitude ,  "comment_id": commentID  ]
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /// 获取评论标签
    /// url http://shop.hilao.dev/ShopClassify
    @discardableResult
    func getCommentLabels(classify_pid : String , _ print : Bool = false ) -> DataRequest? {
//        let location = DDLocationManager.share.locationManager.location
//        let longtitude = String.init(format: "%.08f", arguments: [(location?.coordinate.longitude) ?? 0])
//        let latitude = String.init(format: "%.08f", arguments: [(location?.coordinate.latitude) ?? 0])
        let url  =  "http://shop.hilao.cc/ShopClassify"
        let  para = [ "classify_pid": classify_pid  ]
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    
    /// 写评论
    /// url http://comment.hilao.dev/comment
    /// requestMethod : post
    @discardableResult
    func writeComment(parametes : (shop_id:String,shop_name:String , content:String,is_img:Int ,images:String?,type:Int , score:Int) , _ print : Bool = false ) -> DataRequest? {
        let url  =  "http://comment.hilao.cc/comment"
        var  para = [
            "shop_id": parametes.shop_id,
            "shop_name":parametes.shop_name ,
            "content":parametes.content,
            "is_img" :parametes.is_img,
            "type" : parametes.type,
            "score" : parametes.score,
            "token" : DDAccount.share().token
            ] as [String : Any]
        if let images  = parametes.images {
            para["images"] = images
        }
        if let memberID = DDAccount.share().id {
            para["member_id"] = "\(memberID)"
        }
        if let memberName = DDAccount.share().nickName {
            para["member_id"] = "\(memberName)"
        }
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /// request sign
    func requestTencentSign( _ print : Bool = false ) -> DataRequest? {
        let url  =  "http://api.hilao.cc/index/getTencentObjectStorageSignature"
        let  para = [ String:String ]()
        return performRequest(url: url , method: HTTPMethod.post, parameters: para, print : print )
    }
    
    /*
     let tenxunAppid = "1252043302"
     let tenxunAppKey = "2ae4806abe0f1ae393564456ff1130b5"
     let bukey: String = "hilao"
     let regin: String = "bj"
     http://api.hilao.cc/index/getTencentObjectStorageSignature
     post
     */
    func uploadMediaToTencentYun(image:UIImage ,progressHandler:@escaping ( Int,  Int, Int)->(),compateHandler : @escaping (_ imageUrl:String?)->())  {
        let docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        if let realDocuPath = docuPath  {
            let filePath = realDocuPath + "/tempImage.png"
            let filePathUrl = URL(fileURLWithPath: filePath, isDirectory: true )
            do{
                let _ = try UIImageJPEGRepresentation(image, 0.5)?.write(to: filePathUrl)
                self.requestTencentSign(true)?.responseJSON(completionHandler: { (response) in
                    guard  let dict =  response.value as? [String:AnyObject] else{
                        compateHandler(nil); return}
                    guard let sign = dict["data"] as? [String] else {compateHandler(nil);return}
                    guard let signStr = sign.first  else{compateHandler(nil);return}
                    var fileNameInServer = "\(Date().timeIntervalSince1970 )"
                    if fileNameInServer.contains("."){
                        if let index = fileNameInServer.index(of: "."){
                            fileNameInServer.remove(at: index)
                        }
                    }
                    let uploadTask = COSObjectPutTask.init(path: filePath, sign: signStr, bucket: "hilao", fileName: fileNameInServer, customAttribute: "temp", uploadDirectory: nil, insertOnly: true)
                    
                    self.client?.completionHandler = {(/*COSTaskRsp **/resp, /*NSDictionary */context) in
                        if let  resp = resp as? COSObjectUploadTaskRsp{
//                            mylog(context)
//                            mylog(resp.descMsg)
//                            mylog(resp.fileData)
//                            mylog(resp.data)
//                            mylog(resp.sourceURL)//发给服务器
//                            mylog(resp.httpsURL)
//                            mylog(resp.objectURL)
                            compateHandler(resp.sourceURL)
//                            if (resp.retCode == 0) {
//                                //sucess
//                            }else{
//
//                            }
                        }
                    };
                    self.client?.progressHandler = {( bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                        progressHandler(Int(bytesWritten), Int(totalBytesWritten), Int(totalBytesExpectedToWrite))
//                        mylog("\(bytesWritten)---\(totalBytesWritten)---\(totalBytesExpectedToWrite)")
                        //progress
                    }
                    self.client?.putObject(uploadTask)
                    
                    
                })
                
               
                
                
            }catch{
                mylog(error)
                compateHandler(nil)
            }
            
//            let filePath = realDocuPath.append//appendingPathComponent("Account.data")
        }
    }
    
    
    
    
    
    
    
    
    let result = SessionManager.default
}


extension DDRequestManager{
    func test () {
        
        result.session.configuration.timeoutIntervalForRequest = 2
        result.request(URL(string:"http://api.hailao.cc/index/index")!, method: HTTPMethod.post, parameters: ["hi":"lao"] , headers: HTTPHeaders()).responseJSON { (response) in
            switch response.result{
            case .success :
                break
                
            case .failure :
                GDAlertView.alert("error", image: nil , time: 2, complateBlock: nil )//请求超时处理
                dump(response)
                break
            }
            
        }
        
    }
}









//    func initInfo()   {
//        let url = baseUrl + "init"
//        let did = UIDevice.current.identifierForVendor?.uuidString
//        let para = ["deviceid" : did! , "app_type" : "2" ]
////        Alamofire.request(url , method: HTTPMethod.post, parameters: para ).responsePropertyList{ (result) in
//////                        DefaultDataResponse
////            print("request result : \(result.data)")
////            }.responseString { (response) in
////                print("responseString resulw \(type(of: response.result.va)) data\(response.value)    error \(response.error)")
////        }
//        Alamofire.request(url, method: HTTPMethod.post, parameters: para  ).response(completionHandler: { (response) in
//            print("dataByte : \(response.data)")
//        }).responseJSON(completionHandler: { (response) in
//            print("JSON : \(response)")
//            if let dict = response.value as? [String : AnyObject]{
//                print("DICT : \(dict["status"])")
//            }
//        }).responsePropertyList() { (dataResponse) in
//            print("response : \(dataResponse)")
//        }
//    }
