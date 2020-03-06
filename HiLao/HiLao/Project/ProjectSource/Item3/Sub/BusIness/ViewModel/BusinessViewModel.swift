//
//  BusinessViewModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class BusinessViewModel: NSObject {
    ///获取店铺入驻列表
    func getShopList() {
        guard let memeberid = DDAccount.share().id else {
            return
        }
        
        let paramete = ["token": DDAccount.share().token, "member_id": 95] as [String: Any]
        NetWork.manager.requestData(router: Router.post("shopexaminelist", .shopShopExamine, paramete)).subscribe(onNext: { (dict) in
            let model = BaseModelForArr<BusModel>.deserialize(from: dict)
            guard let dataArr = model?.data else {
                return
            }
            if model?.status == 1321 {
                self.shopListItems.value = dataArr
            }else {
                
            }
        }, onError: { (error) in
            
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
    }
    var shopListItems: Variable<[BusModel]> = Variable<[BusModel]>.init([])
    
    
}
