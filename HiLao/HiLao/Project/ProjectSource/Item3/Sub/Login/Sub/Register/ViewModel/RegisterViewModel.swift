//
//  RegisterViewModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/28.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
enum RegisterType: String {
    case phone = "phone"
    case email = "email"
}
enum RegisterVCType: String {
    case forget = "forget"
    case register = "register"
}
enum CodeType: String {
    case register = "register"
    case forgetpass = "forgetpass"
    case setmobile = "setmobile"
}

class RegisterViewModel: NSObject {
    var loginViewModel = LoginViewModel()
    var inputTextObservable: Observable<String>!
    var codeType: Variable<CodeType> = Variable<CodeType>.init(CodeType.register)
    var phoneText: Variable<String> = Variable<String>.init("")
    var emailText: Variable<String> = Variable<String>.init("")
    var code: String = ""
    var passWord: String = ""
    var againPassWord: String = ""
    var jumpToSelectCode: PublishSubject<String> = PublishSubject<String>.init()
    ///返回区号
    var returnAreaCode: Variable<String> = Variable<String>.init("86")
    //
    var textFieldStatus: PublishSubject<String> = PublishSubject<String>.init()
    var type: Variable<RegisterType> = Variable<RegisterType>.init(RegisterType.phone)
    
    var resigetionAction: PublishSubject<String> = PublishSubject<String>.init()
    var codeKey: Variable<String> = Variable<String>.init("")
    
    
    
    func getCodeKey() {
        let paramete = ["l": LCode, "c": CountryCode] as [String: AnyObject]
        NetWork.manager.requestData(router: Router.post("getValidateCodeKey", BaseUrlStr.member, paramete)).subscribe(onNext: { [weak self](dict) in
            print(dict)
            guard let data = dict["data"] as? [String: AnyObject] else {
            
                return
            }
            
            if let value = data["key"] as? String {
                self?.codeKey.value = value
            }
        }, onError: { (error) in
            GDAlertView.alert("获取验证码失败", image: nil, time: 1, complateBlock: nil)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
    }
    ///获取验证码
    func getCode() -> Bool{
        switch self.type.value {
        case RegisterType.phone:
            if self.phoneText.value.count <= 0 {
                GDAlertView.alert(DDLanguageManager.text("phoneNoNull"), image: nil, time: 1, complateBlock: nil)
                return false
            }
            
            let paramete = ["mobile": self.phoneText.value, "type": self.codeType.value.rawValue, "l": LCode, "c": CountryCode] as [String: AnyObject]
            NetWork.manager.requestData(router: Router.post("sandMobileCode", .member, paramete)).subscribe(onNext: { (dict) in
                mylog(dict)
                let model = BaseModel<GDModel>.deserialize(from: dict)
                
                GDAlertView.alert(model?.message, image: nil, time: 1, complateBlock: nil)
                
                
                
            }, onError: { (error) in
                mylog("获取验证码失败")
            }, onCompleted: {
                mylog("结束")
            }, onDisposed: {
                mylog("回收")
            })
            return true
        case RegisterType.email:
            if self.emailText.value.count <= 0 {
                GDAlertView.alert(DDLanguageManager.text("emailNoNull"), image: nil, time: 1, complateBlock: nil)
                return false
            }
            
            let paramete = ["email": self.emailText.value, "type": self.codeType.value.rawValue, "l": LCode, "c": CountryCode] as [String: AnyObject]
            
            NetWork.manager.requestData(router: Router.post("sandEmailCode", .member, paramete)).subscribe(onNext: { (dict) in
                let model = BaseModel<GDModel>.deserialize(from: dict)
                mylog(dict)
                GDAlertView.alert(model?.message, image: nil, time: 1, complateBlock: nil)
            }, onError: { (error) in
                mylog(error)
            }, onCompleted: {
                mylog("结束")
            }, onDisposed: {
                mylog("回收")
            })
            return true
        
        
            
        default:
            break
        }

        
    }

    func register() {
        
        
        
        
        if self.codeKey.value.count <= 0 {
            GDAlertView.alert("获取验证码失败，不能注册", image: nil, time: 1, complateBlock: nil)
            return
        }
        guard let versionCode = Int(self.code) else {
            GDAlertView.alert("验证码格式不对", image: nil, time: 1, complateBlock: nil)
            return
        }
        if passWord != againPassWord {
            GDAlertView.alert("两次密码输入不一致", image: nil, time: 1, complateBlock: nil)
            return
        }
        

        
        if self.type.value == RegisterType.phone {
            
            if self.vcType.value == RegisterVCType.forget {
                let parameter = ["mobile": self.phoneText.value, "code": versionCode, "password": passWord, "repassword": self.againPassWord, "l": LCode, "c": CountryCode] as? [String: Any]
                NetWork.manager.requestData(router: Router.post("login/forgetPassM", .memberNoPassPort, parameter)).subscribe(onNext: { (dict) in
                
                }, onError: { (error) in
                    
                }, onCompleted: {
                    mylog("结束")
                }, onDisposed: {
                    mylog("回收")
                })
                
            }else {
                let paramete = ["mobile": self.phoneText.value, "code": versionCode, "password": passWord, "country_code": self.returnAreaCode.value, "key": self.codeKey.value, "l": LCode, "c": CountryCode] as [String: AnyObject]
                NetWork.manager.requestData(router: Router.post("mobileRegister", .member, paramete)).subscribe(onNext: { (dict) in
                    let model = BaseModel<DDAccount>.deserialize(from: dict)
                    self.registerNext(model: model)
                    
                    
                    
                }, onError: { (error) in
                    mylog(error)
                }, onCompleted: {
                    mylog("结束")
                }, onDisposed: {
                    mylog("回收")
                })
            }
            
            
        }
        
        if self.type.value == RegisterType.email {
            
            
            if vcType.value == RegisterVCType.forget {
                let paramete = ["l": LCode, "c": CountryCode, "email": self.emailText.value, "code": versionCode, "password": passWord, "repassword": self.againPassWord] as [String: Any]
                NetWork.manager.requestData(router: Router.post("login/forgetPassE", .memberNoPassPort, paramete)).subscribe(onNext: { (dict) in
                    
                }, onError: { (error) in
                    mylog(error)
                }, onCompleted: {
                    mylog("结束")
                }, onDisposed: {
                    mylog("回收")
                })
                
                
            }else {
                let paramete = ["email": self.emailText.value, "code": versionCode, "password": passWord, "country_code": self.returnAreaCode.value, "key": self.codeKey.value, "l": LCode, "c": CountryCode] as [String: Any]
                
                
                
                
                NetWork.manager.requestData(router: Router.post("emailRegister", .member, paramete)).subscribe(onNext: { (dict) in
                    
                    
                    let model = BaseModel<DDAccount>.deserialize(from: dict)
                    self.registerNext(model: model)
                }, onError: { (error) in
                    mylog(error)
                }, onCompleted: {
                    mylog("结束")
                }, onDisposed: {
                    mylog("回收")
                })
            }
            
            
        }
        
        
        
    }
    
    
    
    func registerNext(model: BaseModel<DDAccount>?) {
        
        guard let subModel = model?.data else {
            return
        }
        configMentToken(subModel: subModel)
        //获取系统语言
        
        let currentLanguage = DDLanguageManager.gotcurrentSystemLanguage()

        
        if self.type.value == .phone {
            subModel.actionKey = "perfect"
            
            mylog("传值跳转到设置个人信息页面")
            self.perfectUserInfo.onNext(subModel)
            self.perfectUserInfo.onCompleted()
        }
        
        if self.type.value == .email {
            if currentLanguage == "zh-Hans" {
                subModel.actionKey = "phoneBind"
                self.bindPhone.onNext(subModel)
            }else {
                subModel.actionKey = "perfect"
                self.perfectUserInfo.onNext(subModel)
                self.perfectUserInfo.onCompleted()
            }
            
        }
        
        GDAlertView.alert(model?.message, image: nil, time: 1, complateBlock: nil)
        
    }
    var vcType: Variable<RegisterVCType> = Variable<RegisterVCType>.init(RegisterVCType.register)
    ///返回
    var back: PublishSubject<String> = PublishSubject<String>.init()
    ///跳转到完善信息页面
    var perfectUserInfo: PublishSubject<DDAccount> = PublishSubject<DDAccount>.init()
    ///跳转到绑定手机页面
    var bindPhone: PublishSubject<DDAccount> = PublishSubject<DDAccount>.init()
    
    //页面类型
    var changeType: Variable<String> = Variable<String>.init("changePhone")
    
    
}
func configMentToken(subModel: DDAccount) {
    guard let id = subModel.id else {
        return
    }
    
    let ID = String(id)
    let nickName = subModel.nickName ?? ""
    let mobile = subModel.mobile ?? ""
    let email = subModel.email ?? ""
    var sex = ""
    if let sexInt = subModel.sex {
        sex = String(sexInt)
    }
    let countryid = subModel.countryID ?? ""
    let countryColde = subModel.countryCode ?? ""
    let create_at = subModel.creatAt ?? ""
    let saltCodel = subModel.saltCode ?? ""
    let password = subModel.password ?? ""
    let subSHA1 = (password + saltCodel).sha1()
    
    
    let token = (ID + nickName + mobile + email + sex + countryid + countryColde + create_at + subSHA1).sha1()
    subModel.token = token
    subModel.save()
    
    
    
}
