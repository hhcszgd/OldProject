//
//  OpenShopModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class OpenShopModel: GDModel {
    var indexImage: UIImage?
    var title: String?
    var image: String?
    var detail: String?
    var imageArr: [String] = []
    var reload: PublishSubject<String> = PublishSubject<String>.init()
}
extension OpenShopModel {
    class func newModel(indexImg: String, tilte: String, imgStr: String, detail: String) -> OpenShopModel {
        let model = OpenShopModel.init()
        model.indexImage = UIImage.init(named: indexImg)
        model.title = tilte
        model.image = imgStr
        model.detail = detail
        
        return model
    }
    func getModel() -> [[OpenShopModel]] {
        let model1 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "法人手持身份证件照", imgStr: "", detail: "需清晰展示五官和文字信息不可自拍、不可只拍身份证")
        let model2 = OpenShopModel.newModel(indexImg: "tagging_ii", tilte: "营业执照", imgStr: "", detail: "需文字清晰、边框完整、露出国徽，复印件需加盖印章，可用有效特许证件代替")
        let model3 = OpenShopModel.newModel(indexImg: "tagging_iii", tilte: "其它相关资质（选填）", imgStr: "", detail: "文字清晰、边框完整可用食品流通许可证代替")
        let model4 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "门脸照片", imgStr: "", detail: "需拍出完整门匾、门框(建议正对门店两米处拍摄)")
        let model5 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "店内环境图", imgStr: "", detail: "需真实反应用餐环境（收银台，用餐桌椅）")
        let model6 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "门店LOGO（选填）", imgStr: "", detail: "需体现您用餐的特色，吸引更多用户进店点餐可用商品图代替；不可用门脸图，会被驳回")
        
       return [[model1, model2, model3] ,[model4, model5, model6]]
    
        
    }
    
    func requestModel() -> Observable<[String: AnyObject]> {
        let model1 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "法人手持身份证件照", imgStr: "", detail: "需清晰展示五官和文字信息不可自拍、不可只拍身份证")
        let model2 = OpenShopModel.newModel(indexImg: "tagging_ii", tilte: "营业执照", imgStr: "", detail: "需文字清晰、边框完整、露出国徽，复印件需加盖印章，可用有效特许证件代替")
        let model3 = OpenShopModel.newModel(indexImg: "tagging_iii", tilte: "其它相关资质（选填）", imgStr: "", detail: "文字清晰、边框完整可用食品流通许可证代替")
        let model4 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "门脸照片", imgStr: "", detail: "需拍出完整门匾、门框(建议正对门店两米处拍摄)")
        let model5 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "店内环境图", imgStr: "", detail: "需真实反应用餐环境（收银台，用餐桌椅）")
        let model6 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "门店LOGO（选填）", imgStr: "", detail: "需体现您用餐的特色，吸引更多用户进店点餐可用商品图代替；不可用门脸图，会被驳回")
        return NetWork.manager.requestData(router: Router.post("shopsamplelist", .shopShopExamine, [String : Any]()))
    }
    func getOneModel() -> [OpenShopModel] {
        let model1 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "法人手持身份证照", imgStr: "", detail: "需清晰展示五官和文字信息不可自拍、不可只拍身份证")
        model1.actionKey = "idImage"
        let model2 = OpenShopModel.newModel(indexImg: "tagging_ii", tilte: "营业执照", imgStr: "", detail: "需文字清晰、边框完整、露出国徽，复印件需加盖印章，可用有效特许证件代替")
        model2.actionKey = "businessImage"
        let model3 = OpenShopModel.newModel(indexImg: "tagging_iii", tilte: "其它相关资质（选填）", imgStr: "", detail: "文字清晰、边框完整可用食品流通许可证代替")
        model3.actionKey = "qualificationImage"
        return [model1, model2, model3]
    }
    
    
    func getTwoModel() -> [OpenShopModel] {
        let model4 = OpenShopModel.newModel(indexImg: "tagging_i", tilte: "门脸照片", imgStr: "", detail: "需拍出完整门匾、门框(建议正对门店两米处拍摄)")
        model4.actionKey = "shopface"
        let model5 = OpenShopModel.newModel(indexImg: "tagging_ii", tilte: "店内环境图", imgStr: "", detail: "需真实反应用餐环境（收银台，用餐桌椅）")
        model5.actionKey = "shoplogo"
        let model6 = OpenShopModel.newModel(indexImg: "tagging_iii", tilte: "门店LOGO（选填）", imgStr: "", detail: "需体现您用餐的特色，吸引更多用户进店点餐可用商品图代替；不可用门脸图，会被驳回")
        model6.actionKey = "shop"
        return [model4, model5, model6]
        
    }
    
    
    
}
