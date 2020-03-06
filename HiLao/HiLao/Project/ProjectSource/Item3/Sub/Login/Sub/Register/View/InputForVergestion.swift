//
//  InputForVergestion.swift
//  Project
//
//  Created by 张凯强 on 2017/12/2.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class InputForVergestion: InputViewTwo {

    override init(frame: CGRect, model: RegisterViewModel) {
        super.init(frame: frame, model: model)
        self.verticalLine.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-100)
            
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(1)
        }
        self.verification.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.left.equalTo(self.verticalLine.snp.right)
        }
        self.textField.snp.updateConstraints { (make) in
            
            make.left.equalTo(self.leftImageView.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            
            make.right.equalToSuperview().offset(-110)
        }
        self.viewModel = model
        
        self.viewModel.type.asObservable().subscribe { [weak self](event) in
            self?.time?.invalidate()
            self?.leftTime = 60
            self?.verification.isEnabled = true
        }
        
        self.textField.rx.text.orEmpty.subscribe(onNext: { [weak self](text) in
            self?.viewModel.code = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    
    }
    var viewModel: RegisterViewModel!
    var leftTime: Int = 60
    
    override func getVerification(btn: UIButton) {
        ///首先判断手机号或者是邮箱输入是否正确
        if !self.viewModel.getCode() {
            return
        }
        btn.isEnabled = false
        btn.setTitle("\(self.leftTime)秒后重新发送", for: .disabled)
        
        time = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
        
    }
    func stop() {
        leftTime = 60
        self.verification.isEnabled = true
        self.time?.invalidate()
        
    }
    
    @objc func tickDown() {
        leftTime -= 1
        self.verification.setTitle("\(self.leftTime)秒后重新发送", for: .disabled)
        if self.leftTime <= 0 {
            self.time?.invalidate()
            leftTime = 60
            self.verification.isEnabled = true
            self.verification.setTitle("获取验证码", for: .normal)
        }
        
    }
    
    var time: Timer?
    override var leftImage: UIImage? {
        didSet{
            if let leftImage = leftImage {
                let width = leftImage.size.width
                let height = leftImage.size.height
                self.leftImageView.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(20)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(width)
                    make.height.equalTo(height)
                })
                self.leftImageView.image = leftImage
            }
        }
    }
    override var model: InputViewModel?{
        didSet{
            super.model = model
            
 
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
