//
//  NetWork.swift
//  RxSwiftLearn
//
//  Created by 张凯强 on 2017/9/29.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
enum BaseUrlStr: String {
    case member = "http://member.hilao.cc/passport/"
    case memberNoPassPort = "http://member.hilao.cc/"
    case apiLogin = "http://api.hilao.dev/login/"
    case api = "http://api.hilao.cc/index/"
    case apiMember = "http://api.hilao.dev/member/"
    case interactive = "http://interactive.hilao.cc/"
    case shopShopExamine = "http://shop.hilao.cc/Shopexamine/"
    
}

///检查手机号码是否存在
let checkPhone = "checkPhone"
///检查邮箱是否存在
let checkEmail = "checkEmail"
///获取验证码key的值
let getValidateCodeKey = "getValidateCodeKey"
///获取图片地址
let getValidateCodeImg = "getValidateCodeImg"
///检测验证码
let checkValidateCode = "checkValidateCode"
///发送短信验证码
let sandMobileCode = "sandMobileCode"
/// 检测短信验证码
let checkMobileCode = "checkMobileCode"
///发送邮件验证码
let sandEmailCode = "sandEmailCode"
///检查邮件验证码
let checkEmailCode = "checkEmailCode"
///手机注册
let mobileRegister = "mobileRegister"
///邮箱注册
let emailRegister = "emailRegister"
///设置用户信息
let setMemberInformation = "setMemberInformation"

let TOKEN: String = "INITTOKEN"
enum Router: URLRequestConvertible {
    ///get请求
    case get(String, BaseUrlStr, AnyObject?)
    ///post请求
    case post(String, BaseUrlStr, [String: Any]?)
    
    ///URLRequestConvertible 代理方法
    func asURLRequest() throws -> URLRequest {
        ///请求方式
        var method: HTTPMethod {
            switch self {
            case .get:
                return HTTPMethod.get
            case .post:
                return HTTPMethod.post
            }
        }
        ///请求参数
        var params: [String: Any]? {
            switch self {
            case .get:
                return [:]
            case var .post(urlStr, _, dict):
                if dict != nil {
                    dict!["l"] = LCode
                    dict!["c"] = CountryCode
                }
                mylog(dict)
               return dict
                
            }
        }
        ///请求的网址
        var url: URL {
            var URLStr: String = ""
            switch self {
            case let .get(urlStr, baseUrl, num):
                URLStr = baseUrl.rawValue + urlStr + (num != nil ? "/\(num!)" : "")
            case let .post(urlStr, baseUrl, _):
                URLStr = baseUrl.rawValue + urlStr
            }
           
            
            let url = URL.init(string: URLStr)
            return url!
            
            
            
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        
        let encoding = URLEncoding.default
        return try encoding.encode(request, with: params)
    }
    
    
//    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var request = try urlRequest.asURLRequest()
//        guard let parameters = parameters else { return urlRequest
//        }
//        ///把参数编码到url的情况
//        if let method = HTTPMethod.init(rawValue: urlRequest.httpMethod ?? "GET"),  {
//            <#statements#>
//        }
//    }
//
    
    
    
    
}
enum NetWorkStatus {
    ///不清楚
    case unknow
    ///蜂窝数据
    case wwan
    ///wifi
    case wifi
    ///不可达
    case notReachable
}
enum NetWorkError: Error {
    ///数据格式错误
    case formatError
    ///已经初始化
    case repeadInit
}
class NetWork {
    static let manager = NetWork.init()
    private init() {
        
    }
    
    func requestData(router: Router) -> Observable<[String: AnyObject]> {
        return Observable<[String: AnyObject]>.create({ [weak self](observer) -> Disposable in
            //数据处理
            let request = Alamofire.request(router).responseJSON(completionHandler: { (result) in
                switch result.result {
                case .success(let value):
                    
                    guard let dict = value as? [String: AnyObject] else {
                        observer.onError(NetWorkError.formatError)
                        return
                    }
                    mylog(dict)
                    observer.onNext(dict)
                case .failure(let error):
                    mylog(error)
                    observer.onError(error)
                    
                }
            })
            
            
            return Disposables.create {
                request.cancel()
            }
            
            
            
        })
    }
   
    
}


//var appid: String {
//    get {
//        if let result = UserDefaults.standard.value(forKey: APPID) as? String, result.characters.count > 0 {
//            return result
//            
//        }else {
//            return "nil"
//        }
//    }
//}

