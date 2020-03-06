//
//  ChangeSexVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/14.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class ChangeSexVC: GDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "sex")
        self.setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        let topImageView = UIImageView.init()
        self.view.addSubview(topImageView)
        let image = UIImage.init(named: "genderbig_icon")
        let imgW = image?.size.width ?? 55
        let imgH = image?.size.height ?? 55
        
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DDNavigationBarHeight + 25)
            make.centerX.equalToSuperview()
            make.width.equalTo(imgW)
            make.height.equalTo(imgH)
        }
        topImageView.image = image
        
        self.enterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        self.inputSex.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.enterLabel.snp.bottom).offset(15)
            make.width.equalTo(SCREENWIDTH - 40)
            make.height.equalTo(50)
        }
        self.inputSex.sexSelect.asObservable().subscribe(onNext: { [weak self](type) in
            switch type {
            case .men:
                self?.sex = 1
            case .women:
                self?.sex = 2
            case .secrecy:
                self?.sex = 3
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        self.trueBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-TabBarHeight - 10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        
        
    }
    
    var sex: Int = 1
    
    @objc func trueAction(btn: UIButton) {
        let account = DDAccount.share()
        guard let id = account.id else {
            return
        }
        let paramete = ["l": LCode, "c": CountryCode, "type": ChangeUserInfo.sex.rawValue, "sex": self.sex, "member_id": id] as [String: Any]
        NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<RegisterModel>.deserialize(from: dict)
            if model?.status == 301 {
                
                account.sex = self?.sex
                account.save()
                self?.navigationController?.popViewController(animated: true)
            }
            }, onError: { (error) in
                GDAlertView.alert("修改昵称失败", image: nil, time: 1, complateBlock: nil)
        }, onCompleted: {
            
        }, onDisposed: nil)
        
    }
    
    
    lazy var trueBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("true"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(trueAction(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var enterLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("3b3b3b")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = DDLanguageManager.text("selectSex")
        self.view.addSubview(label)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var inputSex: InputSexTwo = {
        let sex = InputSexTwo.init(frame: CGRect.zero)
        self.view.addSubview(sex)
        return sex
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
