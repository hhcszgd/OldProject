//
//  LoginBottomView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/1.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class LoginBottomView: UIView {
    init(frame: CGRect, viewModel: LoginViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
        self.backgroundColor = UIColor.colorWithRGB(red: 242, green: 242, blue: 242)
        let leftLineView = UIView.init()
        leftLineView.backgroundColor = UIColor.colorWithRGB(red: 77, green: 77, blue: 77)
        self.addSubview(leftLineView)
        
        let rightLineView = UIView.init()
        rightLineView.backgroundColor = UIColor.colorWithRGB(red: 77, green: 77, blue: 77)
        self.addSubview(rightLineView)
        
        let label = UILabel.init()
        label.text = "第三方快捷登录"
        label.textColor = UIColor.colorWithRGB(red: 77, green: 77, blue: 77)
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(label)
        var top: CGFloat = 0
        var subTop: CGFloat = 0
        switch DDDevice.type {
        case .iPhone4, .iPhone5:
            top = 20
            subTop = 10
        default:
            top = 30
            subTop = 15
        }
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview
            make.top.equalToSuperview().offset(top)
        }
        leftLineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(label.snp.left).offset(-10)
            make.centerY.equalTo(label.snp.centerY)
            make.height.equalTo(1)
            make.width.equalTo(rightLineView.snp.width)
        }
        
        rightLineView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(label.snp.right).offset(10)
            make.centerY.equalTo(label.snp.centerY)
            make.height.equalTo(1)
            
        }

        
        self.sinaBtn.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(subTop)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(44)
        }
        self.qqBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.sinaBtn.snp.centerY)
            make.right.equalTo(self.sinaBtn.snp.left).offset(-78 * SCALE)
            make.width.height.equalTo(44)
        }
        self.wechatBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.sinaBtn.snp.right).offset(78 * SCALE)
            make.centerY.equalTo(self.sinaBtn.snp.centerY)
            make.width.height.equalTo(44)
        }

        
        
        
    }
    var viewModel: LoginViewModel!
    @objc func loginBySina() {
        self.viewModel.loginBythree.onNext(.sina)
    }
    @objc func loginByWechat() {
        self.viewModel.loginBythree.onNext(.wechatSession)
    }
    @objc func loginByQQ() {
        self.viewModel.loginBythree.onNext(.QQ)
    }
    
  
    lazy var sinaBtn: UIButton = {
        let btn = UIButton.init()
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(loginBySina), for: .touchUpInside)
        btn.setImage(UIImage.init(named: "sina_icon"), for: .normal)
        
        return btn
    }()
    lazy var wechatBtn: UIButton = {
        let btn = UIButton.init()
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(loginByWechat), for: .touchUpInside)
        btn.setImage(UIImage.init(named: "wechat_icon"), for: .normal)
        return btn
    }()
    lazy var qqBtn: UIButton = {
        let btn = UIButton.init()
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(loginByQQ), for: .touchUpInside)
        btn.setImage(UIImage.init(named: "qq_icon"), for: .normal)
        return btn
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
