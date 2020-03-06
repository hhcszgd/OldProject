  //
//  LoginVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

@objc protocol LoginDelegate : NSObjectProtocol {
   @objc optional  func loginResult(result : Bool)
    
}
let PREVIOUSMOBILE: String = "previousMobile"
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
class LoginVC: GDNormalVC {
    let bag = DisposeBag.init()
    let viewModel = LoginViewModel.init()
    var loginResult: PublishSubject<Bool> = PublishSubject<Bool>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //获取上次用户登录的手机号
        if let previousMobile = UserDefaults.standard.value(forKey: PREVIOUSMOBILE) as? String {
            
        }else {
            
        }
        
        configNav()
        self.setUI()
        self.interactive()
    }
    
    func configNav() {
        self.navigationController?.navigationBar.isHidden = true
        self.naviBar.attributeTitle = viewModel.title
        self.naviBar.backgroundColor = UIColor.clear
        self.naviBar.showLineview = false
//        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
//        backBtn.setImage(UIImage.init(named: "back_icon"), for: .normal)
//        backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
//        backBtn.adjustsImageWhenHighlighted = false
//        self.naviBar.leftBarButtons = [backBtn]

    }
    
    
    func setUI() {
        let topViewPropet = CGFloat(305 + 253) / CGFloat(375)
        let topViewHeight = SCREENWIDTH * topViewPropet
        let topView = LoginTopView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: topViewHeight), viewModel: viewModel)
        self.view.addSubview(topView)
        
        let bottomView = LoginBottomView.init(frame: CGRect.init(x: 0, y: topViewHeight, width: SCREENWIDTH, height: SCREENHEIGHT - topView.max_Y), viewModel: viewModel)
        self.view.addSubview(bottomView)
        var keyBoardHeight: CGFloat = 0
        switch DDDevice.type {
        case .iPhone4, .iPhone5:
            keyBoardHeight = 253
        case .iPhone6:
            keyBoardHeight = 258
        case .iPhone6p:
            keyBoardHeight = 271
        default:
            keyBoardHeight = 271
        }
        //topview移动的距离
        let move = keyBoardHeight - SCREENHEIGHT + topView.max_Y
        //交互
        self.viewModel.textFieldStatus.subscribe(onNext: { [weak self](action) in
            UIView.animate(withDuration: 0.3, animations: {
                if action == "begin" {
                    topView.transform = CGAffineTransform.init(translationX: 0, y: -move)
                }
                if action == "end" {
                    topView.transform = CGAffineTransform.identity
                }
            })
            
            
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        
    }
    func interactive() {
        self.viewModel.loginBythree.subscribe(onNext: { [weak self](type) in
            self?.getUserInfoForPlatform(platformType: type)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        
        self.viewModel.action.subscribe(onNext: { [weak self](action) in
            
            let model = GDModel.init()
            model.actionKey = action
            model.type = action
            if action == "forget" {
                model.actionKey = "register"
            }
            DDShowManager.skip(current: self!, model: model)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        self.viewModel.back.subscribe { [weak self](_) in
            self?.backClick()
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    
    func getUserInfoForPlatform(platformType: UMSocialPlatformType) {
    
        UMSocialManager.default().getUserInfo(with: platformType, currentViewController: self) { (result, error) in
            guard let resp = result as? UMSocialUserInfoResponse else {
                return
            }
            if error == nil {
                let uid = resp.uid
                let openid = resp.openid
                let unionid = resp.unionId
                let usid = resp.usid
                let name = resp.name
                let gender = resp.gender
                let iconurl = resp.iconurl
                ///
                
                
            }
        }
    }
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }



    
    deinit {
        mylog("销毁")
    }
}
 
  
  
  
