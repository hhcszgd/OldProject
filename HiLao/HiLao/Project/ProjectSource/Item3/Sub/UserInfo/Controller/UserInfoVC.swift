//
//  UserInfoVC.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/3.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
enum UserInfoType: String {
    case name = "name"
    case sex = "sex"
    case country = "country"
    case phone = "phone"
    case email = "eamil"
    case password = "password"
    case qq = "qq"
    case wechat = "wechat"
    case webo = "webo"
}

class UserInfoVC: GDNormalVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let viewModel = UserInfoVModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getData()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text:"userInfo")
            

        setUI()
        self.interactive()
        // Do any additional setup after loading the view.
    }

    var headerImage: UserHeaderImage!
    var nickName: UserInfoCell!
    var sex: UserInfoCell!
    var country: UserInfoCell!
    var mobile: UserInfoCell!
    var email: UserInfoCell!
    var password: UserInfoCell!
    var qq: UserBindCell!
    var weibo: UserBindCell!
    var wechat: UserBindCell!
    
    func setUI() {
        self.scroll.backgroundColor = UIColor.white
        let width = SCREENWIDTH - 30
        self.headerImage = UserHeaderImage.init(frame: CGRect.init(x: 15, y: 20, width: width, height: 72), viewModel: self.viewModel)
        self.scroll.addSubview(headerImage)
        
        self.scroll.addSubview(self.middleViewOne)
        self.middleViewOne.frame = CGRect.init(x: 15, y: headerImage.max_Y + 20, width: width, height: 150)
        
        self.nickName = UserInfoCell.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 50), viewModel: self.viewModel)
        
        nickName.model = self.viewModel.name
        
        self.sex = UserInfoCell.init(frame: CGRect.init(x: 0, y: nickName.max_Y, width: width, height: 50), viewModel: self.viewModel)
        sex.model = self.viewModel.sex
        country = UserInfoCell.init(frame: CGRect.init(x: 0, y: sex.max_Y, width: width, height: 50), viewModel: self.viewModel)
        country.model = self.viewModel.country
        
        
        
        self.middleViewOne.addSubview(nickName)
        self.middleViewOne.addSubview(sex)
        self.middleViewOne.addSubview(country)
        
        
        self.scroll.addSubview(self.middleViewTwo)
        self.middleViewTwo.frame = CGRect.init(x: 15, y: self.middleViewOne.max_Y + 20, width: width, height: 150)
        mobile = UserInfoCell.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 50), viewModel: self.viewModel)
        
        mobile.model = self.viewModel.telephone
        
        email = UserInfoCell.init(frame: CGRect.init(x: 0, y: mobile.max_Y, width: width, height: 50), viewModel: self.viewModel)
        email.model = self.viewModel.email
        password = UserInfoCell.init(frame: CGRect.init(x: 0, y: email.max_Y, width: width, height: 50), viewModel: self.viewModel)
        password.model = self.viewModel.password
        
        self.middleViewTwo.addSubview(mobile)
        self.middleViewTwo.addSubview(email)
        self.middleViewTwo.addSubview(password)
        
        
        self.scroll.addSubview(self.bottomView)
        
        self.bottomView.frame = CGRect.init(x: 15, y: self.middleViewTwo.max_Y + 20, width: width, height: 162)
        
        qq = UserBindCell.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 54), viewModel: self.viewModel)

        qq.model = self.viewModel.qq
        self.bottomView.addSubview(qq)
        
        weibo = UserBindCell.init(frame: CGRect.init(x: 0, y: qq.max_Y, width: width, height: 54), viewModel: self.viewModel)
        weibo.model = self.viewModel.webe
        self.bottomView.addSubview(weibo)
        
        wechat = UserBindCell.init(frame: CGRect.init(x: 0, y: weibo.max_Y, width: width, height: 54), viewModel: self.viewModel)
        wechat.model = self.viewModel.wechat
        
        self.bottomView.addSubview(wechat)
        self.scroll.contentSize = CGSize.init(width: 0, height: self.bottomView.max_Y)
        
        
        
        self.view.addSubview(self.loginOut)
        self.loginOut.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-TabBarHeight)
            make.height.equalTo(40)
            make.width.equalTo(SCREENWIDTH - 60)
            make.centerX.equalToSuperview()
            
        }
        
        
    }
    
    func interactive() {
        self.viewModel.uploadImage.subscribe(onNext: { [weak self](action) in
//            UploadPicturesTool.changeHeadPortrait(current: self!)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        self.viewModel.click.subscribe(onNext: { [weak self](model) in
            self?.dealItemClick(model: model)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.name.leftSubTitle = DDAccount.share().nickName
        self.nickName.model = self.viewModel.name
        self.viewModel.setSex()
        self.sex.model = self.viewModel.sex
        self.viewModel.configMobile()
        self.mobile.model = self.viewModel.telephone
        
    }
    
    
    func dealItemClick(model: CustomDetailModel) {
        switch model.actionKey {
        case "name":
            DDShowManager.skip(current: self, model: model)
        case "sex":
            mylog("选择性别")
            DDShowManager.skip(current: self, model: model)
        case "country":
            mylog("选择国家")
        case "phone":
            //判断是否绑定手机号码
            if let mobilestr = DDAccount.share().mobile, mobilestr.count > 0 {
                model.type = "changePhone"
                model.step = "next"
            }else {
                model.type = "bindPhone"
            }
            DDShowManager.skip(current: self, model: model)
        case "email":
            model.actionKey = "phone"
            //判断是否绑定邮箱
            if let emailstr = DDAccount.share().email, emailstr.count > 0 {
                model.type = "changeEmail"
                model.step = "next"
            }else {
                model.type = "bindEmail"
            }
            DDShowManager.skip(current: self, model: model)
        case "password":
            DDShowManager.skip(current: self, model: model)
        case "qq":
            mylog("qq")
        case "wechat":
            mylog("wechat")
        case "webo":
            mylog("webo")
        
        default:
            break
        }
    }
    
    
    
  
    
    lazy var middleViewOne: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderColor = lineColor.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    lazy var middleViewTwo: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderColor = lineColor.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    lazy var bottomView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderColor = lineColor.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var loginOut: GDControl = {
        let control = GDControl.init(frame: CGRect.zero)
        control.addTarget(self, action: #selector(loginOutClick), for: .touchUpInside)
        let label = UILabel.init(frame: control.bounds)
        label.text = "退出当前登录"
        label.textAlignment = .center
        label.font = font17
        label.textColor = UIColor.white
        label.backgroundColor = mainColor
        control.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        control.layer.masksToBounds = true
        control.layer.cornerRadius = 6
        


        return control
    }()
    
    
    @objc func loginOutClick() {
        mylog("退出当前账号")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    lazy var scroll: UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar - 50))
        view.delegate = self
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        self.view.addSubview(view)
        return view
    }()
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
