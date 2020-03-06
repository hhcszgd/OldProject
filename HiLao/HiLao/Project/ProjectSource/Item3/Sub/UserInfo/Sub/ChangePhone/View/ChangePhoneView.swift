//
//  ChangePhoneView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/14.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class ChangePhoneView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, viewModel: RegisterViewModel) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.layer.borderColor = lineColor.cgColor
        self.layer.borderWidth = 1
        self.viewModel = viewModel
        let width: CGFloat = frame.size.width
        let height: CGFloat = frame.size.height / 2.0
        inputForPhone = InputViewForPhone.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height), model: viewModel)
        self.addSubview(inputForPhone)
        
        inputForEmail = InputViewTwo.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height), model: viewModel)
        self.addSubview(inputForEmail)
        let observal = inputForEmail.textField.rx.text.orEmpty.asObservable()
        observal.subscribe(onNext: { (text) in
            viewModel.emailText.value = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        viewModel.phoneText.asObservable().subscribe(onNext: { [weak self](text) in
            self?.inputForPhone.textField.text = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        viewModel.emailText.asObservable().subscribe(onNext: { [weak self](text) in
            self?.inputForEmail.textField.text = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        viewModel.changeType.asObservable().subscribe(onNext: { [weak self](type) in
            switch type {
            case "changePhone", "bindPhone":
                self?.inputForPhone.isHidden = false
                self?.inputForEmail.isHidden = true
            case "changeEmail", "bindEmail":
                self?.inputForPhone.isHidden = true
                self?.inputForEmail.isHidden = false
            default:
                break
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        inputVergestion = InputForVergestion.init(frame: CGRect.init(x: 0, y: height, width: width, height: height), model: viewModel)
        self.addSubview(inputVergestion)
        
        
        self.config()
        
    }
    
    func config() {
        self.inputForEmail.leftImage = UIImage.init(named: "email")
        self.inputForEmail.textField.placeholder = "请输入邮箱"
        self.inputForPhone.leftImage = UIImage.init(named: "uer_icon")
        self.inputForPhone.textField.placeholder = "请输入手机号码"
        self.inputVergestion.leftImage = UIImage.init(named: "validation_icon")
        self.inputVergestion.placeholder = "请输入验证码"
    }
    
    
    var viewModel: RegisterViewModel!
    var inputForPhone: InputViewForPhone!
    var inputVergestion: InputForVergestion!
    var inputForEmail: InputViewTwo!
}
