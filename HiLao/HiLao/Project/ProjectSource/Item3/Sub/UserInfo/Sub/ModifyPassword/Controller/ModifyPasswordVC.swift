//
//  ModifyPasswordVC.swift
//  Project
//
//  Created by 张凯强 on 2017/11/26.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class ModifyPasswordVC: GDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "forgetPassword")
        let mainView = UIView.init()
        self.view.addSubview(mainView)
        mainView.frame = CGRect.init(x: 20, y: DDNavigationBarHeight + 20, width: SCREENWIDTH - 40, height: 52.5 * 3)
        mainView.layer.cornerRadius = 6
        mainView.layer.masksToBounds = true
        mainView.layer.borderColor = lineColor.cgColor
        mainView.layer.borderWidth = 1
        
        mainView.addSubview(oldPassword)
        mainView.addSubview(nowPassword)
        mainView.addSubview(replyPassword)
        oldPassword.frame = CGRect.init(x: 0, y: 0, width: mainView.bounds.size.width, height: 52.5)
        nowPassword.frame = CGRect.init(x: 0, y: oldPassword.max_Y, width: mainView.bounds.size.width, height: 52.5)
        replyPassword.frame = CGRect.init(x: 0, y: nowPassword.max_Y, width: mainView.bounds.size.width, height: 52.5)
        oldPassword.leftTitle = DDLanguageManager.text("oldPassword")
        nowPassword.leftTitle = DDLanguageManager.text("newPassword")
        replyPassword.leftTitle = DDLanguageManager.text("againPassword")
        
        
        
        self.resetBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).offset(20)
            make.width.equalTo(mainView.bounds.size.width)
            make.height.equalTo(40)
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func clickAction(btn: UIButton) {
        guard let id = DDAccount.share().id else {
            return
        }
        let paramete = ["l": LCode, "c": CountryCode, "member_id": id, "type": "password"] as [String: Any]
        NetWork.manager.requestData(router: Router.post("member/upUserList", .memberNoPassPort, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<DDAccount>.deserialize(from: dict)
            if model?.status == 301 {
                let account = DDAccount.share()
                account.password = self?.nowPassword.text
                account.save()
                
                self?.navigationController?.popViewController(animated: true)
                
            }
            }, onError: { (error) in
                mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
    }
    deinit {
        mylog("销毁")
    }
    
    lazy var oldPassword: InputVIew = {
        let input = InputVIew.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 52.5))
        self.view.addSubview(input)
        return input
    }()
    lazy var nowPassword: InputVIew = {
        let input = InputVIew.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(input)
        return input
    }()
    lazy var replyPassword: InputVIew = {
        let input = InputVIew.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        self.view.addSubview(input)
        return input
    }()
    
    lazy var resetBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("resetPassword"), for: .normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(clickAction(btn:)), for: .touchUpInside)
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
