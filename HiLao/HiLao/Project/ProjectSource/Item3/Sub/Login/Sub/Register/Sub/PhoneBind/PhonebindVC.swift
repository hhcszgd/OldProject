//
//  PhonebindVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/7.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class PhonebindVC: GDNormalVC {
    
    let viewModel = RegisterViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.codeType.value = .setmobile
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "phonebind")
        self.naviBar.backBtn.isHidden = true
        self.setUI()
        //15313375314
        // Do any additional setup after loading the view.
    }
    //布局
    func setUI() {
        self.view.backgroundColor = backColor
        self.view.addSubview(topImageView)
        topImageView.image = UIImage.init(named: "gray-icon")
        let size = topImageView.image?.size
        let imageW = size?.width ?? 100
        let imageH = size?.height ?? 100
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DDNavigationBarHeight + 20)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageW)
            make.height.equalTo(imageH)
        }
        
        self.propmtLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.topImageView.snp.bottom).offset(15)
        }
        
        self.mainView.backgroundColor = UIColor.white
        
        inputForPhone = InputViewForPhone.init(frame: CGRect.zero, model: viewModel)
        self.mainView.addSubview(inputForPhone)
       
        
        inputVergestion = InputForVergestion.init(frame: CGRect.zero, model: viewModel)
        self.mainView.addSubview(inputVergestion)
        inputForPhone.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        inputVergestion.snp.makeConstraints { (make) in
            make.top.equalTo(self.inputForPhone.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        
        
        let Propert: CGFloat = CGFloat(210) / CGFloat(670)
        let Height = Propert * (SCREENWIDTH - 40)
        self.mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self.propmtLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREENWIDTH - 40)
            make.height.equalTo(Height)
        }
        let p = CGFloat(86) / CGFloat(670)
        self.verificationBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.mainView.snp.bottom).offset(20)
            make.width.equalTo(SCREENWIDTH - 40)
            make.height.equalTo(p * (SCREENWIDTH - 40))
        }
        
        self.inputForPhone.textField.rx.text.orEmpty.asObservable().subscribe { (event) in
            guard let text = event.element else {
                return
            }
            self.mobile = text
        }
        
        
        self.inputVergestion.textField.rx.text.orEmpty.asObservable().subscribe { (event) in
            guard let text = event.element else {
                return
            }
            self.code = text
        }
        
        
        self.inputForPhone.leftImage = UIImage.init(named: "uer_icon")
        self.inputForPhone.textField.placeholder = "请输入手机号码"
        self.inputVergestion.leftImage = UIImage.init(named: "validation_icon")
        self.inputVergestion.placeholder = "请输入验证码"
        
    }
    
    var mobile: String = ""
    var code: String = ""
    
    @objc func verificationAction(btn: UIButton) {
        if mobile.count <= 0 {
            GDAlertView.alert(DDLanguageManager.text("phoneNoNull"), image: nil, time: 1, complateBlock: nil)
        }
        let ddModel = DDAccount.share()
        mylog("token" + ddModel.token)
        guard let memberID = ddModel.id else {
            return
        }
        let paramete = ["l": LCode, "c": CountryCode, "member_id": String(memberID), "token": ddModel.token, "mobile": self.mobile, "code": self.code] as [String: AnyObject]
        NetWork.manager.requestData(router: Router.post("setMemberMoile", .member, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<DDAccount>.deserialize(from: dict)
            if model?.status == 601 {
                guard let subModel = model?.data, let mobile = subModel.mobile else {
                    return
                }
                configMentToken(subModel: subModel)
                ddModel.actionKey = "perfect"
                DDShowManager.skip(current: self, model: ddModel)
            }else {
                self?.inputVergestion.stop()
            }
            
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
        
    }
    
    
    
    let topImageView = UIImageView.init()
    lazy var propmtLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.font = font13
        label.textAlignment = .center
        label.textColor = UIColor.colorWithHexStringSwift("666666")
        label.text = DDLanguageManager.text("propmt")
        label.numberOfLines = 0
        self.view.addSubview(label)
        return label
    }()
    
    var inputForPhone: InputViewForPhone!
    var inputVergestion: InputForVergestion!
    
    lazy var mainView: UIView = {
        let left: CGFloat = 20
        let top: CGFloat = 25 + DDNavigationBarHeight
        let width: CGFloat = SCREENWIDTH - 40
        let propert: CGFloat = CGFloat(210) / CGFloat(670)
        let height: CGFloat = width * propert
        let view = UIView.init(frame: CGRect.init(x: left, y: top, width: width, height: height))
        self.view.addSubview(view)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = lineColor.cgColor
        return view
        
        
    }()
    lazy var verificationBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("verification"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(verificationAction(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(btn)
        return btn
    }()
    deinit {
        mylog("手机号绑定页面销毁")
    }

}
