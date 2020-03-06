//
//  DDItem3VC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
let mainColor = UIColor.colorWithHexStringSwift("fe5f5f")
class DDItem3VC: GDNormalVC {
    let bag = DisposeBag()
    lazy var topView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.colorWithHexStringSwift("fe5f5f")
        self.view.addSubview(view)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.naviBar.isHidden = true
        viewMolde.getData()
        if DDAccount.share().isLogin {
            self.viewMolde.getUserInfo()
        }
        self.view.backgroundColor = UIColor.white
        
        
        
      
        
        
        //布局
        let topViewPropert = CGFloat(155) / CGFloat(375)
        
        self.topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(topViewPropert)
        }
        self.view.addSubview(self.useHomeBtn)
        self.useHomeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DDnavigationStateHeight)
            make.right.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        let topOverViewWidthPropert = CGFloat(345) / CGFloat(375)
        let topOverViewPropert = CGFloat(190) / CGFloat(345)
        let cellWidth = SCREENWIDTH * topOverViewWidthPropert
        let cellHeight = cellWidth * (CGFloat(45) / CGFloat(345))

        let left: CGFloat = (SCREENWIDTH - cellWidth) / 2.0
        let topOverY: CGFloat = (DDDevice.type == .iphoneX) ? 88 : 64
        let topOverWidth: CGFloat = topOverViewWidthPropert * SCREENWIDTH
        let topOverHeight: CGFloat = topOverWidth * topOverViewPropert

    
        let topOverView = ProfileTopView.init(frame: CGRect.init(x: left, y: topOverY, width: topOverWidth, height: topOverHeight), viewModel: viewMolde)

        self.view.addSubview(topOverView)
        
        var middleViewHeight: CGFloat = CGFloat(viewMolde.middleItems.value.count) * cellHeight
        let middleX = (SCREENWIDTH - cellWidth) / 2.0
        let middleY = topOverView.frame.maxY + CGFloat(12) * SCALE
        let middleView = ProfileMiddleView.init(frame: CGRect.init(x: middleX, y: middleY, width: cellWidth, height: middleViewHeight), viewModel: viewMolde)
        
        
        self.view.addSubview(middleView)

        
        
        let bottomHeight = CGFloat(viewMolde.bottomItems.value.count) * cellHeight
        let bottomY: CGFloat = middleView.max_Y + CGFloat(27)
        let bottomView = ProfileBottomView.init(frame: CGRect.init(x: left, y: bottomY, width: cellWidth, height: bottomHeight), viewModel: viewMolde)
        self.view.addSubview(bottomView)
        
        
        
        
        
        self.viewMolde.tap.subscribe(onNext: { (model) in
            self.cellClick(model: model)

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    
        self.viewMolde.headerClick.subscribe(onNext: { (action) in
            self.headerClick(action: action)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
    }
    
    
    
    
    
    @objc func toUserHomeInfo(btn: UIButton) {
        let userHome = UserHomeVC()
        self.navigationController?.pushViewController(userHome, animated: true)
    }
    
    
    
    func headerClick(action: String) {
        mylog(action)
        if action == "userInfo" {
            let model = CustomDetailModel.init()
            model.isNeedJudge = true
            model.actionKey = "userInfo"
            DDShowManager.skip(current: self, model: model)
            
        }
        if action == "login" {
            let vc = LoginVC()
            vc.viewModel.loginResult.subscribe({ [weak self](event) in
                guard let result = event.element else {
                    return
                }
                self?.viewMolde.isLogin.value = result
                
            })
            
//            let loginNa = LoginNaviVC.init(rootVC: vc)
            self.navigationController?.pushViewController(vc, animated: true)
//            self.present(loginNa, animated: true, completion: nil)
        }
        
    }
    
    
    
    func cellClick(model: CustomDetailModel) {
        let action = model.actionKey
        
        switch action {
        case "evaluate":
            self.evaluateJump()
        case "recomment":
            SharManage.shar.share()
        case "aboutMe":
            DDShowManager.skip(current: self, model: model)
        case "content":
            DDShowManager.skip(current: self, model: model)
        case "achieve":
            DDShowManager.skip(current: self, model: model)
        case "business":
            DDShowManager.skip(current: self, model: model)
        default:
            
            break
            
        }
    }
    ///评价跳转
    func evaluateJump() {
        let str = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1242747678"
        let url = URL.init(string: str)
        if url != nil {
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewMolde.accountModel.onNext(DDAccount.share())
        self.viewMolde.isLogin.value = DDAccount.share().isLogin
        self.navigationController?.navigationBar.isHidden = true
    }
    
    lazy var useHomeBtn: UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "Userhomepage"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(toUserHomeInfo(btn:)), for: .touchUpInside)
        return btn
    }()
    
    
    let viewMolde: ProfileViewModel = ProfileViewModel()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
