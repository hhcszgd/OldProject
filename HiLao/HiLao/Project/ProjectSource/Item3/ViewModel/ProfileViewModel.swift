//
//  ProfileViewModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/29.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class ProfileViewModel: NSObject {
    var isLogin: Variable<Bool> = Variable<Bool>.init(DDAccount.share().isLogin)
    var identifierItems: Variable<[String]> = Variable<[String]>.init(["header", "other", "help", "business", "evaluate", "recomment", "set"])
    var jump: PublishSubject<[String: AnyObject]> = PublishSubject<[String: AnyObject]>.init()
    
    
    func getData() {
        let help = CustomDetailModel.configModel(action: "help", leftImage: UIImage.init(named: "Help_icon"), leftTitle: "帮助中心", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        help.isNeedJudge = true
        
        let business = CustomDetailModel.configModel(action: "business", leftImage: UIImage.init(named: "Settled_icon"), leftTitle: "商家入驻", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        business.isNeedJudge = true
        let evaluate = CustomDetailModel.configModel(action: "evaluate", leftImage: UIImage.init(named: "Praise_icon"), leftTitle: "给个好评", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        let recomment = CustomDetailModel.configModel(action: "recomment", leftImage: UIImage.init(named: "Recommend_icon"), leftTitle: "推荐给朋友", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: true, switchHidden: true)
    
        let set = CustomDetailModel.configModel(action: "set", leftImage: UIImage.init(named: "Setup_icon"), leftTitle: "设置", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: true, switchHidden: true)
        
        middleItems.value = [help, business, evaluate, recomment]
        bottomItems.value = [set]
        
    }
    var tap: PublishSubject<CustomDetailModel> = PublishSubject<CustomDetailModel>.init()
    
    var headerClick: PublishSubject<String> = PublishSubject<String>.init()

    var model: Variable<CustomDetailModel> = Variable<CustomDetailModel>.init(CustomDetailModel.init())
    func configModel(leftImage: UIImage?, leftTitle: String?, rightDetailTitle: String?, rightImage: UIImage?, arrowHidden: Bool, lineHidden: Bool) -> CustomDetailModel {
        let model = CustomDetailModel.init()
        model.arrowHidden = arrowHidden
        model.leftImage = leftImage
        model.leftTitle = leftTitle
        model.rightDetailTitle = rightDetailTitle
        model.rightImage = rightImage
        model.lineHidden = lineHidden
        return model
    }
    var aboutMe: PublishSubject<String> = PublishSubject<String>.init()
    var achieve: PublishSubject<String> = PublishSubject<String>.init()
    var conment: PublishSubject<String> = PublishSubject<String>.init()
    func getUserInfo() {
        guard let memberId = DDAccount.share().memberId else {
            return
        }
        let paramete = ["l": LCode, "c": CountryCode, "member_id": memberId, "other_member_id": memberId] as [String: Any]
        NetWork.manager.requestData(router: Router.post("userinfo", .apiMember, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<ProfileModel>.deserialize(from: dict)
            guard let subModel = model?.data else {
                return
            }
            if model?.status == 305 {
                //请求数据成功
                self?.aboutMe.onNext(subModel.aboutMe)
                self?.achieve.onNext(subModel.achieve)
                self?.conment.onNext(subModel.conment)
            }else {
                mylog("请求用户信息出错")
                
            }
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil)
        
    }
    
    
    
    var middleItems: Variable<[CustomDetailModel]> = Variable<[CustomDetailModel]>.init([CustomDetailModel]())
    
    var bottomItems: Variable<[CustomDetailModel]> = Variable<[CustomDetailModel]>.init([CustomDetailModel]())
    
    
    
    var accountModel: PublishSubject<DDAccount> = PublishSubject<DDAccount>.init()
    
    
    
}
