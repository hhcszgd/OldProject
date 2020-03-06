//
//  ProfileTopView.swift
//  Project
//
//  Created by 张凯强 on 2017/11/28.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class ProfileTopView: UIView {

    let noLoginUserImg: UIImage = UIImage.init(named: "headportraitlogo")!
    init(frame: CGRect, viewModel: ProfileViewModel) {
        super.init(frame: frame)
        //阴影透明度
        self.layer.borderColor = UIColor.colorWithHexStringSwift("f4f4f4").cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.white
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        
        
        let backControl = UIControl.init()
        self.addSubview(backControl)
        
        backControl.addTarget(self, action: #selector(backControlClick), for: .touchUpInside)
        var leftImageWidth: CGFloat = 0
        switch DDDevice.type {
        case .iPhone4, .iPhone5:
             leftImageWidth = 60
        default:
             leftImageWidth = 80
        }
        
        self.leftImageView.contentMode = UIViewContentMode.scaleToFill
        self.leftImageView.layer.masksToBounds = true
        
        self.leftImageView.layer.cornerRadius = leftImageWidth / 2.0 * SCALE
        self.leftImageView.image = noLoginUserImg
        self.leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24 * SCALE)
            make.top.equalToSuperview().offset(12 * SCALE)
            make.width.equalTo(leftImageWidth)
            make.height.equalTo(leftImageWidth)
        }
        backControl.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(20 * SCALE)
            make.centerY.equalTo(self.leftImageView.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        self.userName.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftImageView.snp.centerY)
            make.left.equalTo(self.leftImageView.snp.right).offset(18 * SCALE)
        }
        
        self.loginBtn.snp.updateConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(20 * SCALE)
            make.centerY.equalTo(self.leftImageView.snp.centerY)
            
        }
        
        let imgW = (self.arrowToRight.image?.size.width) ?? 20
        let imgH = (self.arrowToRight.image?.size.height) ?? 20
        self.arrowToRight.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24 * SCALE)
            make.centerY.equalTo(self.leftImageView.snp.centerY)
            make.width.equalTo(imgW)
            make.height.equalTo(imgH)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(22.5 * SCALE)
            make.right.equalToSuperview().offset(-22.5 * SCALE)
            make.top.equalTo(self.leftImageView.snp.bottom).offset(10 * SCALE)
            make.height.equalTo(1)
        }
        
        self.aboutMe.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalTo(self.achievement.snp.left)
            make.width.equalTo(self.achievement.snp.width)
        }
        self.achievement.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(self.aboutMe.snp.right)
            make.right.equalTo(self.content.snp.left)
            make.top.equalTo(self.lineView.snp.bottom)
            make.width.equalTo(self.content.snp.width)
        }
        self.content.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.top.equalTo(self.lineView.snp.bottom)
            make.left.equalTo(self.achievement.snp.right)
        }
        
        
        
        
        
        
        //用户信息改变的情况下
        viewModel.accountModel.subscribe(onNext: { [weak self](account) in
            if account.nickName == nil {
                self?.userName.text = "尚未设置用户名"
            }else {
                self?.userName.text = account.nickName
            }
            
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //根据登录状态来改变
        viewModel.isLogin.asObservable().subscribe(onNext: { [weak self](bo) in
            self?.loginBtn.isHidden = bo
            self?.userName.isHidden = !bo
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        self.aboutMe.addTarget(self, action: #selector(aboutClick), for: .touchUpInside)
        self.achievement.addTarget(self, action: #selector(achievementClick), for: .touchUpInside)
        self.content.addTarget(self, action: #selector(contentClick), for: .touchUpInside)
        self.viewModel = viewModel
        
        self.viewModel.aboutMe.subscribe(onNext: { [weak self](text) in
            self?.aboutMe.subTitle = text
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        self.viewModel.achieve.subscribe(onNext: { [weak self](text) in
            self?.achievement.subTitle = text
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        self.viewModel.conment.subscribe(onNext: { [weak self](text) in
            self?.content.subTitle = text
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
    }
    var viewModel: ProfileViewModel!
    
    
    @objc func backControlClick() {
        var action: String!
        if DDAccount.share().isLogin {
            action = "userInfo"
        }else {
            action = "login"
        }
        self.viewModel.headerClick.onNext(action)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @objc func aboutClick() {
        let model = CustomDetailModel.init()
        model.actionKey = "aboutMe"
        model.isNeedJudge = true
        self.viewModel.tap.onNext(model)
    }
    
    @objc func achievementClick() {
        let model = CustomDetailModel.init()
        model.actionKey = "achieve"
        model.isNeedJudge = true
        self.viewModel.tap.onNext(model)
    }
    @objc func contentClick() {
        let model = CustomDetailModel.init()
        model.actionKey = "content"
        model.isNeedJudge = true
        self.viewModel.tap.onNext(model)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var loginBtn: UILabel = {
        let con = UILabel.init(frame: CGRect.zero)
        con.text = "登录 / 注册"
        con.font = UIFont.systemFont(ofSize: 17)
        con.textAlignment = NSTextAlignment.center
        con.textColor = UIColor.colorWithHexStringSwift("4e4e4e")
        con.sizeToFit()
        self.addSubview(con)
        return con
    }()
    lazy var arrowToRight: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "Getinto"))
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var rankingImage: UIImageView = {
        let image = UIImageView.init()
        self.addSubview(image)
        return image
    }()
    lazy var userName: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.colorWithHexStringSwift("4e4e4e")
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()
    lazy var leftImageView: UIImageView = {
        let image = UIImageView.init()
        self.addSubview(image)
        image.contentMode = UIViewContentMode.scaleAspectFit
        return image
    }()
    
    
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.colorWithHexStringSwift("e2e2e2")
        self.addSubview(view)
        return view
    }()
    lazy var aboutMe: ProfileBtn = {
        let btn = ProfileBtn.init(frame: CGRect.zero)
        btn.title = DDLanguageManager.text("aboutMe")
        btn.image = UIImage.init(named: "About_us")
        btn.subTitle = "0"
        self.addSubview(btn)
        return btn
    }()
    lazy var achievement: ProfileBtn = {
        let btn = ProfileBtn.init(frame: CGRect.zero)
        btn.title = DDLanguageManager.text("achievement")
        btn.image = UIImage.init(named: "achievement_icon")
        btn.subTitle = "0"
        self.addSubview(btn)
        return btn
    }()
    lazy var content: ProfileBtn = {
        let btn = ProfileBtn.init(frame: CGRect.zero)
        btn.title = DDLanguageManager.text("content")
        btn.image = UIImage.init(named: "content_icon")
        btn.subTitle = "0"
        self.addSubview(btn)
        return btn
    }()
    
    

}
