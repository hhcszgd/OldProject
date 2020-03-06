//
//  UserInfoVModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/3.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class UserInfoVModel: NSObject {
    let name = CustomDetailModel.configModel(action: "name", leftImage: nil, leftTitle: "昵称", rightDetailTitle: "修改", rightImage: nil, arrowHidden: false, lineHidden: false, switchHidden: true)
    
    
    let sex = CustomDetailModel.configModel(action: "sex", leftImage: nil, leftTitle: "性别", rightDetailTitle: "尚未设置", rightImage: nil, arrowHidden: false, lineHidden: false, switchHidden: true)
    let country = CustomDetailModel.configModel(action: "country", leftImage: nil, leftTitle: "家乡", rightDetailTitle: "设置", rightImage: nil, arrowHidden: false, lineHidden: false, switchHidden: true)
    
    let telephone = CustomDetailModel.configModel(action: "phone", leftImage: nil, leftTitle: "手机号", rightDetailTitle: "123456789", rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
    
    let email = CustomDetailModel.configModel(action: "email", leftImage: nil, leftTitle: "邮箱", rightDetailTitle: "绑定", rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
    
    let password = CustomDetailModel.configModel(action: "password", leftImage: nil, leftTitle: "密码", rightDetailTitle: DDLanguageManager.text("change"), rightImage: nil, arrowHidden: false, lineHidden: true, switchHidden: true)
    
    let qq = CustomDetailModel.configModel(action: "qq", leftImage: UIImage.init(named: "qq_icon"), leftTitle: "qq", rightDetailTitle: "解除绑定", rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
    
    let webe = CustomDetailModel.configModel(action: "webo", leftImage: UIImage.init(named: "sina_icon"), leftTitle: nil, rightDetailTitle: "绑定", rightImage: nil, arrowHidden: true, lineHidden: true, switchHidden: true)
    let wechat = CustomDetailModel.configModel(action: "wechat", leftImage: UIImage.init(named: "wechat_icon"), leftTitle: nil, rightDetailTitle: "绑定", rightImage: nil, arrowHidden: true, lineHidden: true, switchHidden: true)
    func getData() {
        let headImg = CustomDetailModel.configModel(action: "headerImg", leftImage: nil, leftTitle: "头像", rightDetailTitle: nil, rightImage: UIImage.init(), arrowHidden: true, lineHidden: true, switchHidden: true)
        
        name.leftSubTitle = "尚未设置昵称"
        name.subTitleColor = ashColor
        name.left = 15
        sex.left = 15
        country.left = 15
        telephone.left = 15
        email.left = 15
        password.left = 15
        ///性别
        
        self.setSex()
        self.configMobile()
        self.configEmail()
        
        
        
    
        
    }
    ///设置性别 
    func setSex() {
        let sexInt = DDAccount.share().sex ?? 0
        var sexStr: String = ""
        switch sexInt {
        case 0:
            sexStr = "尚未设置"
        case 1:
            sexStr = "男"
        case 2:
            sexStr = "女"
        case 2:
            sexStr = "保密"
        default:
            break
        }
        self.sex.rightDetailTitle = sexStr
       
        
    }

    
    
    func configMobile(){
        let mobiel = DDAccount.share().mobile ?? ""
        if mobiel.count <= 0 {
             self.telephone.rightDetailTitle = DDLanguageManager.text("bind")
            return
        }
        let str = mobiel as NSString
        let prefix = str.substring(to: 3) as String
        let suffix = str.substring(from: str.length - 4) as String
        let result = prefix + "xxxx" + suffix
        self.telephone.rightDetailTitle = result
        
    }
    func configEmail(){
        let email = DDAccount.share().email ?? ""
        if email.count <= 0 {
            self.email.rightDetailTitle = DDLanguageManager.text("bind")
            return
        }
        
        self.email.rightDetailTitle = email
        
    }
    let uploadImage: PublishSubject<String> = PublishSubject<String>.init()
    let click: PublishSubject<CustomDetailModel> = PublishSubject<CustomDetailModel>.init()
    
    func setName(viewController: UIViewController) {
        let alertVC = UIAlertController.init(title: "请输入昵称", message: "昵称不能包含特殊字符", preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "昵称"
        }
        
        
        let actionTrue = UIAlertAction.init(title: "确定", style: .default) { (acton ) in
            mylog("确定")
        }
        let actionCancle = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            mylog("取消")
        }
        alertVC.addAction(actionCancle)
        alertVC.addAction(actionTrue)
        viewController.present(alertVC, animated: true, completion: nil)
        
        
    }
//    var uploadImage: PublishSubject<
    
    
    
    
    var items: [[CustomDetailModel]] = []
    
    
    
}
