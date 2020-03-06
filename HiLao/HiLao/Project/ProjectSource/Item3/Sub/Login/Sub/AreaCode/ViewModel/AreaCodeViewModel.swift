//
//  AreaCodeViewModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/26.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
class AreaCodeViewModel: NSObject {
    func getData(){
        let url = "getAreaCode"
        let para = ["l": LCode, "c": CountryCode] as [String: AnyObject]
        NetWork.manager.requestData(router: Router.post(url, BaseUrlStr.api, para)).subscribe(onNext: { [weak self](dict) in
            guard let dataArr = dict["data"] as? [[String: AnyObject]] else {
                return
            }
            let array = dataArr.flatMap({ (dict) -> AreaCodeModel? in
                return AreaCodeModel.deserialize(from: dict)
            }).filter({ (model) -> Bool in
                return model != nil
            })
            print(dict)
            let section = SectionModel<String, AreaCodeModel>.init(model: "a", items: array)
            self?.items.value = [section]

            
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
        
        
    }
    
    var items = Variable<[SectionModel<String, AreaCodeModel>]>.init([SectionModel<String, AreaCodeModel>]())
}
