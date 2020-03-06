//
//  LoginViewModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/25.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
class LoginViewModel: NSObject {
    ///检查密码是否正确
    func passwordlawful(input: String) -> Bool {
        let regex = "^[a-zA-Z0-9_.]{6,16}$"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: input)
        return isMatch
    }
    
    var title: NSAttributedString {
        get {
        let dict = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor.white]
            let attributeString = NSAttributedString.init(string: DDLanguageManager.text("login"), attributes: dict)
            return attributeString
            
            
            
        }
    }
    
    
    ///用户名
    var userName: String = ""
    var password: String = ""
    
    ///检查用户名。
    func userNameLawful(input: String) -> Bool {
        let regex = "^[\\u4e00-\\u9fa5a-zA-Z0-9]+"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: input)
        let sum = getSizeOfUserName(string: input)
        let isBo = (sum >= 4) && (sum <= 16)
        let mobile = mobileLawful(mobileNum: input)
        return isMatch && isBo && mobile
        
    }
    func getSizeOfUserName(string: String) -> Int {
        let str = NSString.init(string: string as NSString)
        var a = [NSString]()
        
        for i in 0..<(str.length) {
            let charStr = str.character(at: i)
            if charStr > 0x4e00 && charStr < 0x9fff {
                a.append(str.substring(with: NSRange.init(location: i, length: 1)) as NSString)
            }
        }
        let chines = a.count
        let other = string.characters.count
        let sum = chines + other
        return sum
        
    }
    
    func mobileLawful(mobileNum: String) -> Bool {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let cm = "1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let cu = "1(3[0-2]|5[256]|8[56])\\d{8}$"
        let ct = "1((33|53|77|8[09])[0-9]|349)\\d{7}$"
        let phs = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        let regextextMobile = NSPredicate.init(format: "SELF MATCHES %@", mobile)
        let regextextcm = NSPredicate.init(format: "SELF MATCHES %@", cm)
        let regextextcu = NSPredicate.init(format: "SELF MATCHES %@", cu)
        let regextextct = NSPredicate.init(format: "SELF MATCHES %@", ct)
        let regextextphs = NSPredicate.init(format: "SELF MATCHES %@", phs)
        let result: Bool = regextextMobile.evaluate(with: mobileNum) || regextextcm.evaluate(with: mobileNum) || regextextcu.evaluate(with: mobileNum) || regextextct.evaluate(with: mobileNum) || regextextphs.evaluate(with: mobileNum)
        if result {
            return true
        }else {
            return false
        }
        
        
        
        
        
    }
    
    
    
    
    ///判断登录按钮的状态
    func controlLoginBtnStatus(userName: ControlProperty<String>, password: ControlProperty<String>) -> Observable<Bool> {
        let userNameObservable = userName.map { (username) -> Bool in
            return self.userNameLawful(input: username)
        }
        let passwordObservable = password.map { (password) -> Bool in
            return self.passwordlawful(input: password)
        }
        let observable = Observable.combineLatest([userNameObservable, passwordObservable]).map { (boArr) -> Bool in
            let validValues = boArr.reduce(true, {
                $0 && $1
            })
            return validValues
            }
        return observable
    }
    
    
    
    var loginBythree: PublishSubject<UMSocialPlatformType> = PublishSubject<UMSocialPlatformType>.init()
    var action: PublishSubject<String> = PublishSubject<String>.init()
    
    var textFieldStatus: PublishSubject<String> = PublishSubject<String>.init()
    
    
    
    
    
    
    func login() {
        if self.userName.count <= 0 {
            GDAlertView.alert("用户名不能为空", image: nil, time: 1, complateBlock: nil)
            return
        }
        if self.password.count <= 0 {
            GDAlertView.alert("密码不能为空", image: nil, time: 1, complateBlock: nil)
            return
        }
        
        let paramete = ["l": LCode, "c": CountryCode, "username": self.userName, "password": self.password] as? [String: AnyObject]
        NetWork.manager.requestData(router: Router.post("login/index", .memberNoPassPort, paramete)).subscribe(onNext: { (dict) in
            let model = BaseModel<DDAccount>.deserialize(from: dict)
            guard let subModel = model?.data else {
                return
            }
            configMentToken(subModel: subModel)
            self.loginNext(model: model)
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
        
    }
    
    func loginNext(model: BaseModel<DDAccount>?) {
        if model?.status == 101 {
            self.loginResult.onNext(true)
            self.loginResult.onCompleted()
            self.back.onNext("")
            self.back.onCompleted()
            return
        }
        
        GDAlertView.alert(model?.message, image: nil, time: 1, complateBlock: nil)
    }
    var back: PublishSubject<String> = PublishSubject<String>.init()
    var loginResult: PublishSubject<Bool> = PublishSubject<Bool>.init()
    
    
}
