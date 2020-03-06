//
//  GDGTPShopCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
import XMPPFramework
import SDWebImage
class GDGTPShopCell: GDBaseCell {
    var shoplogo: UIImageView = UIImageView.init()
    var shopName: UILabel = UILabel.init()
    var collectionBtn: UIButton = UIButton.init()
    var colsultBtn: UIButton = UIButton.init()
    var sharBtn: UIButton = UIButton.init()
    var allGood: PShopCellBtn = PShopCellBtn.init(frame: CGRect.zero)
    var shangxin: PShopCellBtn = PShopCellBtn.init(frame: CGRect.zero)
    var attention: PShopCellBtn = PShopCellBtn.init(frame: CGRect.zero)
    var shop_id: String?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(changCollectionBtnStatus), name: NSNotification.Name.init("LOGINSUCCESS"), object: nil)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        shoplogo.layer.masksToBounds = true
        shoplogo.contentMode = UIViewContentMode.scaleAspectFit
        shoplogo.layer.cornerRadius = 6
        self.contentView.addSubview(shoplogo)
        
        shopName.font =  GDFont.systemFont(ofSize: 14)
        shopName.textColor = UIColor.colorWithHexStringSwift("333333")
        shopName.backgroundColor = UIColor.white
        shopName.textAlignment = NSTextAlignment.left
        shopName.numberOfLines = 2
        shopName.sizeToFit()
        self.contentView.addSubview(shopName)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapToShop))
        let taptwo = UITapGestureRecognizer.init(target: self, action: #selector(tapToShop))
        shoplogo.isUserInteractionEnabled = true
        shopName.isUserInteractionEnabled = true
        shoplogo.addGestureRecognizer(tap)
        shopName.addGestureRecognizer(taptwo)
        
        
        
        
        
        
        self.contentView.addSubview(collectionBtn)
        collectionBtn.setImage(UIImage.init(named: "icon_collect-1"), for: UIControlState.normal)
        collectionBtn.setImage(UIImage.init(named: "icon_collect_sel"), for: UIControlState.selected)
        collectionBtn.addTarget(self, action: #selector(collection(btn:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(colsultBtn)
        colsultBtn.setImage(UIImage.init(named: "icon_consult-1"), for: UIControlState.normal)
        colsultBtn.addTarget(self, action: #selector(consult(btn:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(sharBtn)
        sharBtn.setImage(UIImage.init(named: "icon_share2-1"), for: UIControlState.normal)
        sharBtn.addTarget(self, action: #selector(shar(btn:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(allGood)
        allGood.addTarget(self, action: #selector(actionToAllGood(btn:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(shangxin)
        shangxin.addTarget(self, action: #selector(actionToshangxin(btn:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(attention)
//        attention.addTarget(self, action: <#T##Selector#>, for: UIControlEvents.touchUpInside)
        
        self.shoplogo.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(10)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(10)
            _ = make?.width.equalTo()(80)
            _ = make?.height.equalTo()(40)
        }
//        let shopNameWidth = screenW - 80 - 
        
        
        sharBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.shoplogo.mas_top)?.setOffset(5)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(-10)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
        }
        
        colsultBtn.mas_makeConstraints { (make) in
            _ = make?.centerY.equalTo()(self.sharBtn)
            make?.right.equalTo()(self.sharBtn.mas_left)?.setOffset(-5)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
        }
        
        collectionBtn.mas_makeConstraints { (make) in
            _ = make?.centerY.equalTo()(self.sharBtn)
            make?.right.equalTo()(self.colsultBtn.mas_left)?.setOffset(-5)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
        }
        shopName.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.shoplogo.mas_right)?.setOffset(10)
            make?.right.equalTo()(self.collectionBtn.mas_left)?.setOffset(-10)
            make?.top.equalTo()(self.shoplogo.mas_top)?.setOffset(0)
        }
        
        
        
        allGood.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(38 * scale)
            make?.top.equalTo()(self.shoplogo.mas_bottom)?.setOffset(20)
            _ = make?.width.equalTo()(60)
            _ = make?.height.equalTo()(30)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(-20)
        }
        
        
        shangxin.mas_makeConstraints { (make) in
            _ = make?.centerY.equalTo()(self.allGood)
            _ = make?.centerX.equalTo()(self.contentView)
            _ = make?.width.equalTo()(60)
            _ = make?.height.equalTo()(30)
        }
        attention.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(-38 * scale)
            _ = make?.centerY.equalTo()(self.allGood)
            _ = make?.width.equalTo()(60)
            _ = make?.height.equalTo()(30)
        }
        
        
    }
    func changCollectionBtnStatus() {
        if UserInfo.share().isLogin {
            //判断店铺是否被收藏
            if let shopID = self.shop_id {
                let paramete  = ["member_id": UserInfo.share().member_id as AnyObject, "shop_id": shopID as AnyObject]
                GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.POST, urlString: "IsShopCollect", parameters: paramete, success: { (result) in
                    //status < 0店铺已经被收藏，店铺没有被收藏
                    if result.status < 0{
                        //店铺被收藏
                        
                        self.collectionBtn.isSelected = true
                    }else {
                        self.collectionBtn.isSelected = false
                    }

                }, failure: { (error) in
                    self.collectionBtn.isSelected = false
                })
            }
            
        }else {
            //不登录的情况下都显示没有收藏
            self.collectionBtn.isSelected = false
        }
    }
    
    
    
    var shopModel: GDGTPShopModel = GDGTPShopModel.init(dict: ["data": "" as AnyObject]){
        didSet{
            if let shop_id = shopModel.shop_id {
                self.shop_id = shop_id
            }
            if let url = shopModel.img {
                self.shoplogo.sd_setImage(with: imgStrConvertToUrl(url), placeholderImage: placeholderImage, options: [SDWebImageOptions.cacheMemoryOnly, SDWebImageOptions.retryFailed])
            }
            if let shopName = shopModel.shop_name {
                self.shopName.text = shopName
            }
            if let items = shopModel.items {
                if let itemsModel = items as? [GDGTPShopSubModel] {
                    allGood.subModel = itemsModel[0]
                    shangxin.subModel = itemsModel[1]
                    attention.subModel = itemsModel[2]
                }
            }
            
            self.changCollectionBtnStatus()
        }
    }
    
    
    func configmentUI() {
        
    }
    func tapToShop() {
        let model = GDBaseModel.init(dict: nil)
        model.actionkey = "HShopVC"
        if let shopID = self.shop_id {
            model.keyparamete = ["paramete": shopID] as AnyObject
        }
        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "jump" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
    }
    
    
    
    func collection(btn: UIButton) {
        if UserInfo.share().isLogin {
            
            
            
            if btn.isSelected {
                //如果已经收藏了就取消收藏
                if let shopID = self.shop_id {
                    let paramete = ["member_id": UserInfo.share().member_id as AnyObject, "shop_id": String.init(format: "[%@]", shopID) as AnyObject, "_method": "delete" as AnyObject]
                    GDNetworkManager.shareManager.requestDataFromNewWork(.POST, urlString: "ShopCollect", parameters: paramete, success: { (result) in
                        if result.status > 0 {
                            alert(message: "取消收藏", timeInterval: 1)
                            btn.isSelected = false
                        } else {
                            alert(message: "取消收藏失败", timeInterval: 1)
                            btn.isSelected = true
                        }
                    }, failure: { (error) in
                        btn.isSelected = false
                    })
                }
                
            }else {
                //如果没有收藏就收藏
                if let shopID = self.shop_id {
                    let paramete = ["member_id": UserInfo.share().member_id as AnyObject, "shop_id": shopID as AnyObject]
                    GDNetworkManager.shareManager.requestDataFromNewWork(.POST, urlString: "ShopCollect", parameters: paramete, success: { (result) in
                        if result.status > 0 {
                            btn.isSelected = true
                            alert(message: "添加收藏", timeInterval: 1)
                        } else {
                            btn.isSelected = false
                            alert(message: "添加收藏失败", timeInterval: 1)
                        }
                    }, failure: { (error) in
                        btn.isSelected = false
                    })
                }
            }
            
        }else {
            btn.isSelected = false
            let login = LoginNavVC.init(loginNavVC: ())
            GDKeyVC.share.present(login!, animated: true, completion: nil)
        }
    }
    func consult(btn: UIButton) {
        let model = GDBaseModel.init(dict: nil)
        model.actionkey = "NewChatVC"
        if let sellerName = shopModel.seller_login_name {
             let xm = XMPPJID.init(user: sellerName, domain: "jabber.zjlao.com", resource: nil)
            if let xmpp = xm {
                model.keyparamete = ["paramete": xmpp] as AnyObject
                let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "chat" as Any]
                NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
            }
        }
       
        
        
    }
    func shar(btn: UIButton) {
        let model = GDBaseModel.init(dict: nil)
        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "shopShar" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
    }
    func actionToAllGood(btn: PShopCellBtn) {
        let model = GDBaseModel.init(dict: nil)
        model.actionkey = "HAllGoodsVC"
        if let shopID = self.shop_id {
            model.keyparamete = ["paramete": shopID] as AnyObject
        }
        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "allGoods" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
    }
    func actionToshangxin(btn: PShopCellBtn) {
        let model = GDBaseModel.init(dict: nil)
        model.actionkey = "HAllGoodsVC"
        if let shopID = self.shop_id {
            model.keyparamete = ["paramete": shopID, "shangxin": shopID, "VCName": "HGoodVC"] as AnyObject
        }
        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "shangxin" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

class PShopCellBtn: GDBaseControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        subTitleLabel.font = UIFont.systemFont(ofSize: 13)
        subTitleLabel.textColor = UIColor.colorWithHexStringSwift("333333")
        subTitleLabel.backgroundColor = UIColor.white
        subTitleLabel.textAlignment = NSTextAlignment.center
        
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.colorWithHexStringSwift("999999")
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(subTitleLabel)
        self.addSubview(titleLabel)
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.frame.size.height / CGFloat(2.0)
        self.subTitleLabel.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: height)
        self.titleLabel.frame = CGRect.init(x: 0, y: height, width: self.frame.size.width, height: height)
    }
    
    var subModel: GDGTPShopSubModel = GDGTPShopSubModel.init(dict: ["data": "" as AnyObject]){
        didSet{
            if let num = subModel.num {
                self.subTitleLabel.text = num
            }
            if let title = subModel.name {
                self.titleLabel.text = title
            }
            
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
