//
//  PerfectUserInfoVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/6.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class PerfectUserInfoVC: GDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        mylog("进入个人信息页面")
        self.naviBar.attributeTitle =  GDNavigatBar.attributeTitle(text: "perfectUserInfo")
        self.setUI()
        self.naviBar.backBtn.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    //布局
    func setUI() {
        let skipBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        self.naviBar.rightBarButtons = [skipBtn]
        skipBtn.addTarget(self, action: #selector(skipAction(btn:)), for: .touchUpInside)
        skipBtn.setTitle(DDLanguageManager.text("skip"), for: .normal)
        skipBtn.backgroundColor = UIColor.clear
        self.view.backgroundColor = backColor
        self.mainView.backgroundColor = UIColor.white
        self.mainView.addSubview(self.nickNameInput)
        self.nickNameInput.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }

        
        self.mainView.addSubview(self.sexInput)
        self.sexInput.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.nickNameInput.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        let submitPropert: CGFloat = CGFloat(85) / CGFloat(670)
        let submitHeight = submitPropert * (SCREENWIDTH - 40)
        self.submitBtn.frame = CGRect.init(x: 20, y: self.mainView.max_Y + 20, width: SCREENWIDTH - 40, height: submitHeight)
        
        self.sexInput.sexSelect.asObservable().subscribe { [weak self](event) in
            guard let sex = event.element else {
                return
            }
            switch sex {
            case .women:
                self?.sex = 2
            case .men:
                self?.sex = 1
            case .secrecy:
                self?.sex = 3
            default:
                break
            }
        }
        
    }
    
    var sex: Int = 2
    
    @objc func skipAction(btn: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    @objc func submit(btn: UIButton) {
        if self.nickNameInput.text.count <= 0 {
            GDAlertView.alert(DDLanguageManager.text("nickNotNull"), image: nil, time: 1, complateBlock: nil)
            return
        }
        let ddModel = DDAccount.share()
        mylog("//////////////////////////" + ddModel.token)
        guard let memberID = ddModel.id else {
            return
        }
        let paramete = ["l": LCode, "c": CountryCode, "member_id": String(memberID), "token": ddModel.token, "nickname": self.nickNameInput.text, "sex": self.sex] as [String: AnyObject]
        NetWork.manager.requestData(router: Router.post("setMemberInformation", .member, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<DDAccount>.deserialize(from: dict)
            if model?.status == 301 {
                guard let subModel = model?.data, let nickName = subModel.nickName else {
                    return
                }
                
                configMentToken(subModel: subModel)
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
        
    }
    
    
    
    lazy var sexInput: InputSex = {
        let view = InputSex.init(frame: CGRect.zero)
        view.leftImage = UIImage.init(named: "gender_icon")
        return view
    }()
    
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
    
    lazy var nickNameInput: InputViewThree = {
        let view = InputViewThree.init(frame: CGRect.zero)
        view.leftImage = UIImage.init(named: "nickname_icon")
        view.title = DDLanguageManager.text("nickname")
        view.placeholder = DDLanguageManager.text("enterNickName")
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    

    
    lazy var submitBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("submit"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(submit(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(btn)
        return btn
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
