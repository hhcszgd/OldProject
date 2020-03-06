//
//  ChangePhoneVC.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/5.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
let changePhone = "changePhone"
class ChangePhoneVC: GDNormalVC {
    let viewModel = RegisterViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

        // Do any additional setup after loading the view.
    }
    func setUI() {
        let X: CGFloat = 20
        let Y: CGFloat = DDNavigationBarHeight + 20
        let width: CGFloat = SCREENWIDTH - 40
        let height: CGFloat = 115
        let mainview = ChangePhoneView.init(frame: CGRect.init(x: X, y: Y, width: width, height: height), viewModel: self.viewModel)
        self.view.addSubview(mainview)
        
        
        self.clickBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREENWIDTH - 40)
            make.height.equalTo(40)
            make.top.equalTo(mainview.snp.bottom).offset(40)
        }
        
        self.interactive()
    }
    
    func interactive() {
        self.viewModel.jumpToSelectCode.subscribe { [weak self](event) in
            //            guard let action = event.element else {
            //                return
            //            }
            
            let selectAreaCode = SelectAreaCodeVC()
            selectAreaCode.modelSelect.subscribe({ [weak self](model) in
                guard let mo = model.element else {
                    return
                }
                guard let areaCode = mo.area else {
                    return
                }
                self?.viewModel.returnAreaCode.value = areaCode
                
            })
            self?.navigationController?.pushViewController(selectAreaCode, animated: true)
            
            
        }
        
    }
    
    
    
    @objc func clickAction(btn: UIButton)  {
        guard let type = self.keyModel?.type else {
            return
        }
        guard let step = self.keyModel?.step else {
            return
        }
        let account = DDAccount.share()
        guard let id = account.id else {
            return
        }
        //判断页面的布局
        let action = (type, step)
        switch action {
        case ("bindPhone", ""):
            
            
            let paramete = ["l": LCode, "c": CountryCode, "type": ChangeUserInfo.mobile.rawValue, "mobile": self.viewModel.phoneText.value, "member_id": id, "code": self.viewModel.code] as [String: Any]
            NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 301 {
                    
                    account.mobile = self?.viewModel.phoneText.value
                    account.save()
                    self?.navigationController?.popViewController(animated: true)
                }
                }, onError: { (error) in
                    GDAlertView.alert("", image: nil, time: 1, complateBlock: nil)
            }, onCompleted: {
                
            }, onDisposed: nil)
            
        case ("bindEmail", ""):
            let paramete = ["l": LCode, "c": CountryCode, "type": ChangeUserInfo.email.rawValue, "email": self.viewModel.emailText.value, "member_id": id, "code": self.viewModel.code] as [String: Any]
            NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 301 {
                    
                    account.email = self?.viewModel.emailText.value
                    account.save()
                    self?.navigationController?.popViewController(animated: true)
                }
                }, onError: { (error) in
                    GDAlertView.alert("", image: nil, time: 1, complateBlock: nil)
            }, onCompleted: {
                
            }, onDisposed: nil)
        case ("changePhone", "next"):
             let paramete = ["l": LCode, "c": CountryCode, "mobile": self.viewModel.phoneText.value, "code": self.viewModel.code] as [String: Any]
             NetWork.manager.requestData(router: Router.post("checkMobileCode", .member, paramete)).subscribe(onNext: { (dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 241 {
                    self.keyModel?.step = "finish"
                    DDShowManager.skip(current: self, model: self.keyModel!)
                }else {
                    
                }
             }, onError: { (error) in
                mylog(error)
             }, onCompleted: {
                mylog("结束")
             }, onDisposed: {
                mylog("回收")
             })
        case ("changePhone", "finish"):
            let paramete = ["l": LCode, "c": CountryCode, "type": ChangeUserInfo.mobile.rawValue, "mobile": self.viewModel.phoneText.value, "member_id": id, "code": self.viewModel.code] as [String: Any]
            NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 301 {
                    
                    account.mobile = self?.viewModel.phoneText.value
                    account.save()
                    self?.navigationController?.removeFromParentViewController()
                    self?.navigationController?.popViewController(animated: true)
                }
                }, onError: { (error) in
                    GDAlertView.alert("", image: nil, time: 1, complateBlock: nil)
            }, onCompleted: {
                
            }, onDisposed: nil)
        case ("changeEmail", "next"):
            let paramete = ["l": LCode, "c": CountryCode, "email": self.viewModel.emailText.value, "code": self.viewModel.code] as [String: Any]
            NetWork.manager.requestData(router: Router.post("checkEmailCode", .member, paramete)).subscribe(onNext: { (dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 241 {
                    self.keyModel?.step = "finish"
                    DDShowManager.skip(current: self, model: self.keyModel!)
                }
            }, onError: { (error) in
                mylog(error)
            }, onCompleted: {
                mylog("结束")
            }, onDisposed: {
                mylog("回收")
            })
        case ("changeEmail", "finish"):
            let paramete = ["l": LCode, "c": CountryCode, "type": ChangeUserInfo.email.rawValue, "email": self.viewModel.emailText.value, "member_id": id, "code": self.viewModel.code] as [String: Any]
            NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
                let model = BaseModel<RegisterModel>.deserialize(from: dict)
                if model?.status == 301 {
                    
                    account.email = self?.viewModel.emailText.value
                    account.save()
                    self?.navigationController?.removeFromParentViewController()
                    self?.navigationController?.popViewController(animated: true)
                }
                }, onError: { (error) in
                    GDAlertView.alert("", image: nil, time: 1, complateBlock: nil)
            }, onCompleted: {
                
            }, onDisposed: nil)        default:
            
            break
        }
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let type = self.keyModel?.type else {
            return
        }
        guard let step = self.keyModel?.step else {
            return
        }
        //判断页面的布局
        let action = (type, step)
        self.configUI(type: action)
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: type)
        self.viewModel.changeType.value = type
       
        
    }
    
    func configUI(type: (String, String)) {
        switch type {
        case ("bindPhone", ""):
            self.clickBtn.setTitle(DDLanguageManager.text("bindPhone"), for: .normal)
            self.viewModel.type.value = RegisterType.phone
            self.viewModel.codeType.value = CodeType.setmobile
        case ("bindEmail", ""):
            self.clickBtn.setTitle(DDLanguageManager.text("bindEmail"), for: .normal)
            self.viewModel.type.value = RegisterType.email
            self.viewModel.codeType.value = CodeType.setmobile
        case ("changePhone", "next"):
            self.clickBtn.setTitle(DDLanguageManager.text("next"), for: .normal)
            self.viewModel.type.value = RegisterType.phone
            self.viewModel.codeType.value = CodeType.setmobile
            if let phone = DDAccount.share().mobile, phone.count > 0 {
                self.viewModel.phoneText.value = phone
            }
        case ("changePhone", "finish"):
            self.clickBtn.setTitle(DDLanguageManager.text("bind"), for: .normal)
            self.viewModel.type.value = RegisterType.phone
            self.viewModel.codeType.value = CodeType.setmobile
        case ("changeEmail", "next"):
            if let email = DDAccount.share().email, email.count > 0 {
                self.viewModel.emailText.value = email
            }
            self.clickBtn.setTitle(DDLanguageManager.text("next"), for: .normal)
            self.viewModel.type.value = RegisterType.email
            self.viewModel.codeType.value = CodeType.setmobile
        case ("changeEmail", "finish"):
            self.clickBtn.setTitle(DDLanguageManager.text("bind"), for: .normal)
            self.viewModel.type.value = RegisterType.email
            self.viewModel.codeType.value = CodeType.setmobile
        default:
            
            break
        }
    }
    
    
    lazy var clickBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(clickAction(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(btn)
        return btn
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        mylog("销毁")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
