//
//  RegistermainView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/1.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class RegistermainView: UIView, UITextFieldDelegate {

    
    init(frame: CGRect, viewModel: RegisterViewModel) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.viewModel = viewModel
        let width: CGFloat = frame.size.width
        let height: CGFloat = frame.size.height / 4.0
        inputForPhone = InputViewForPhone.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height), model: viewModel)
        self.addSubview(inputForPhone)
        
        inputForEmail = InputViewTwo.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height), model: viewModel)
        self.addSubview(inputForEmail)
        let observal = inputForEmail.textField.rx.text.orEmpty.asObservable()
        observal.subscribe(onNext: { (text) in
            viewModel.emailText.value = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        viewModel.type.asObservable().subscribe(onNext: { [weak self](type) in
            switch type {
            case .phone:
                self?.inputForPhone.isHidden = false
                self?.inputForEmail.isHidden = true
            case .email:
                self?.inputForPhone.isHidden = true
                self?.inputForEmail.isHidden = false
            default:
                break
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        inputVergestion = InputForVergestion.init(frame: CGRect.init(x: 0, y: height, width: width, height: height), model: viewModel)
        self.addSubview(inputVergestion)
        
        self.passwrod = InputViewTwo.init(frame: CGRect.init(x: 0, y: self.inputVergestion.max_Y, width: width, height: height))
        self.addSubview(self.passwrod)
        
        self.again = InputViewTwo.init(frame: CGRect.init(x: 0, y: self.passwrod.max_Y, width: width, height: height))
        self.addSubview(self.again)
        
        self.configSubView()
        viewModel.resigetionAction.subscribe { [weak self](_) in
            self?.inputVergestion.textField.resignFirstResponder()
            self?.inputForPhone.textField.resignFirstResponder()
            self?.inputForEmail.textField.resignFirstResponder()
            self?.passwrod.textField.resignFirstResponder()
            self?.again.textField.resignFirstResponder()
        }
        
        passwrod.textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (text) in
            viewModel.passWord = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        again.textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (text) in
            viewModel.againPassWord = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        inputVergestion.textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (text) in
            viewModel.code = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
    }
    
    func configSubView() {
        
        
        self.inputForEmail.leftImage = UIImage.init(named: "email")
        self.inputForEmail.textField.placeholder = "请输入邮箱"
        self.inputForPhone.leftImage = UIImage.init(named: "uer_icon")
        self.inputForPhone.textField.placeholder = "请输入手机号码"
        self.inputVergestion.leftImage = UIImage.init(named: "validation_icon")
        self.inputVergestion.placeholder = "请输入验证码"
        
        self.passwrod.leftImage = UIImage.init(named: "password_icon")
        self.passwrod.placeholder = "请输入6-20位密码"
        self.again.leftImage = UIImage.init(named: "password_icon")
        self.again.placeholder = "请再次输入密码"
        self.again.lineView.isHidden = true
        
        self.inputForPhone.textField.delegate = self
        self.inputForEmail.textField.delegate = self
        self.inputVergestion.textField.delegate = self
        self.passwrod.textField.delegate = self
        self.again.textField.delegate = self
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.textFieldStatus.onNext("begin")
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.viewModel.textFieldStatus.onNext("end")
        return true
    }
    
    var viewModel: RegisterViewModel!
    var inputForPhone: InputViewForPhone!
    var inputVergestion: InputForVergestion!
    var inputForEmail: InputViewTwo!
    var passwrod: InputViewTwo!
    var again: InputViewTwo!
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
