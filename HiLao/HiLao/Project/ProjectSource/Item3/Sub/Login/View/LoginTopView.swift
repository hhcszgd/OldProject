//
//  LoginTopView.swift
//  Project
//
//  Created by 张凯强 on 2017/11/30.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class LoginTopView: UIView, UITextFieldDelegate {

    init(frame: CGRect, viewModel: LoginViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
        self.backControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
        self.backgroundColor = UIColor.white
        let topViewPropert = CGFloat(305) / CGFloat (375)
        let width = frame.size.width
        let topViewH: CGFloat = width * topViewPropert
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: topViewH))
        self.addSubview(topView)
        topView.backgroundColor = mainColor
        
        let imageView = UIImageView.init()
        topView.addSubview(imageView)
        guard let image = UIImage.init(named: "wavylines") else {
            return
        }
        topView.isUserInteractionEnabled = false
        let imgW: CGFloat = image.size.width
        let imgH: CGFloat = image.size.height
        let imgPropert = imgH / imgW
        let imgHeight = width * imgPropert
        imageView.image = image
        imageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(imgHeight)
        }
        let logoImage = UIImageView.init()
        topView.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(83)
            make.height.equalTo(90)
        }
        logoImage.backgroundColor = UIColor.white
        
        let bottomView = UIView.init()
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        
        
        let loginName: InputVIew = InputVIew.init(frame: CGRect.init(x: 25, y: SCALE * 30, width: width - 50, height: 40))
        bottomView.addSubview(loginName)
        loginName.leftImage = UIImage.init(named: "loginuser_icon")
        loginName.placeholder = "请输入手机号码或邮箱"
        
        let loginPassword: InputVIew = InputVIew.init(frame: CGRect.init(x: 25, y: loginName.max_Y + 10, width: width - 50, height: 40))
        loginPassword.leftImage = UIImage.init(named: "loginpassword_icon")
        loginPassword.placeholder = "请输入6~20位密码"
        bottomView.addSubview(loginPassword)
        
        loginName.textField.rx.text.orEmpty.subscribe(onNext: { (text) in
            viewModel.userName = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        loginPassword.textField.rx.text.orEmpty.subscribe(onNext: { (text) in
            viewModel.password = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        bottomView.addSubview(self.loginBtn)
        bottomView.addSubview(self.forgetBtn)
        bottomView.addSubview(self.registerBtn)
        let loginBtnPropert = CGFloat(43) / CGFloat(325)
        let height = (width - 50) * loginBtnPropert
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.top.equalTo(loginPassword.snp.bottom).offset(30 * SCALE)
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
        }
    
        
        self.forgetBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.loginBtn.snp.left).offset(0)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        self.registerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.loginBtn.snp.right).offset(0)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(5)
            make.width.equalTo(88)
            make.height.equalTo(44)
        }


        
        self.userName = loginName
        self.password = loginPassword
        self.userName.textField.delegate = self
        self.password.textField.delegate = self
        
    }
    var userName: InputVIew!
    var password: InputVIew!
    ///delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mylog("将要开始编辑")
        self.viewModel.textFieldStatus.onNext("begin")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.viewModel.textFieldStatus.onNext("end")
        
        return true
    }
    
    
    @objc func loginAction(btn: UIButton) {
        self.viewModel.login()
        
        
    }
    
    @objc func registerAction(btn: UIButton) {
        self.viewModel.action.onNext("register")
    }
    @objc func foregetPasswordAction(btn: UIButton) {
        self.viewModel.action.onNext("forget")
    }
    @objc func resignFirstResponderAction() {
        self.userName.textField.resignFirstResponder()
        self.password.textField.resignFirstResponder()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    lazy var backControl: UIControl = {
        let control = UIControl.init()
        self.addSubview(control)
        control.addTarget(self, action: #selector(resignFirstResponderAction), for: .touchUpInside)
        return control
    }()
    
    lazy var registerBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("注册", for: UIControlState.normal)
        let color = UIColor.colorWithRGB(red: 3, green: 131, blue: 254)
        btn.setTitleColor(color, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(registerAction(btn:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    
    lazy var forgetBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("忘记密码?", for: UIControlState.normal)
        let color = UIColor.colorWithRGB(red: 3, green: 131, blue: 254)
        btn.setTitleColor(color, for: UIControlState.normal)
        btn.titleLabel?.font = font13
        btn.addTarget(self, action: #selector(foregetPasswordAction(btn:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    lazy var loginBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("login"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(loginAction(btn:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    var viewModel: LoginViewModel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
