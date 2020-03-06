//
//  GDInfoCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDInfoCell: GDBaseCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setSubContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var titleLabel: UILabel?
    //分享按钮
    var sharBtn: UIButton?
    //价格
    var priceLabel: UILabel?
    //lineView
    var lineView: UIView?
    //快递
    var expressCharge: UILabel?
    //销量
    var saleVolume: UILabel?
    //发货地址
    var deliveryPlace: UILabel?
    //子视图
    var contentSubView: UIView?
    
    
    func setSubContentView() {
        //设置商品描述
        titleLabel = UILabel.init()
        self.contentView.addSubview(titleLabel!)
        let font = GDCalculator.GDAdaptation(15.0)
        titleLabel?.font = UIFont.systemFont(ofSize: font)
        titleLabel?.textColor = UIColor.colorWithHexStringSwift("333333")
        titleLabel?.textAlignment = NSTextAlignment.left
        titleLabel?.backgroundColor = UIColor.white
        titleLabel?.numberOfLines = 2
        //设置分享按钮
        sharBtn = UIButton.init()
        self.contentView.addSubview(sharBtn!)
        sharBtn?.addTarget(self, action: #selector(sharClick), for: UIControlEvents.touchUpInside)
        sharBtn?.setImage(UIImage.init(named: "icon_share3"), for: UIControlState.normal)
        sharBtn?.showsTouchWhenHighlighted = false
        //布局产品描述和分享按钮
        _ = sharBtn?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(5)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
            
        })
        _ = titleLabel?.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(10)
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(10)
            make?.right.equalTo()(self.sharBtn?.mas_left)?.setOffset(0)
        })
        //价格
        priceLabel = UILabel.creatLabel(UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(15)), textColor: THEMECOLOR, backColor: UIColor.clear)
        self.contentView.addSubview(priceLabel!)
        _ = priceLabel?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.titleLabel?.mas_bottom)?.setOffset(5)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(10)
            
        })
        priceLabel?.sizeToFit()
        
        //快递
        expressCharge = UILabel.creatLabel(UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(12)), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.clear)
        expressCharge?.sizeToFit()
        self.contentView.addSubview(expressCharge!)
        _ = expressCharge?.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(10)
            make?.top.equalTo()(self.priceLabel?.mas_bottom)?.setOffset(5)
            
        })
        //销量
        saleVolume = UILabel.creatLabel(UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(11)), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.clear)
        self.contentView.addSubview(saleVolume!)
        saleVolume?.sizeToFit()
        _ = saleVolume?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.expressCharge?.mas_top)?.setOffset(0)
            _ = make?.centerX.equalTo()(self.contentView.mas_centerX)
        })
        //发货地址
        deliveryPlace = UILabel.creatLabel(UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(11)), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.clear)
        self.contentView.addSubview(deliveryPlace!)
        deliveryPlace?.sizeToFit()
        _ = deliveryPlace?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.expressCharge?.mas_top)?.setOffset(0)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(-10)
        })
        
        contentSubView = UIView.init()
        self.contentView.addSubview(contentSubView!);
        _ = contentSubView?.mas_updateConstraints({ (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
            make?.top.equalTo()(self.expressCharge?.mas_bottom)?.setOffset(0)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
            
        })
        
        
        lineView = UIView.init()
        self.contentView.addSubview(lineView!)
        lineView?.backgroundColor = UIColor.backGroundColor()
        _ = lineView?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.contentSubView?.mas_bottom)?.setOffset(0)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
            _ = make?.width.equalTo()(screenW)
            _ = make?.height.equalTo()(10)
        })
        //        _ = lineView?.mas_makeConstraints({ (make) in
        //            _ = make?.width.equalTo()(Width)
        //            _ = make?.height.equalTo()(10)
        //            make?.top.equalTo()(self.expressCharge?.mas_bottom)?.setOffset(0)
        //            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
        //            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
        //            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
        //
        //        })
        
        
        
    }
    
    //分享按钮
    func sharClick() {
        
        let userinfo = [AnyHashable("model"): infoModel as Any, AnyHashable("action"): "goodsShar" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
    }
    
    var infoModel: GDInfoModel = GDInfoModel.init(dict: ["data": "" as AnyObject]) {
        didSet{
            print(infoModel)
            if let title = infoModel.short_name {
                titleLabel?.text = title as String
            }else {
                titleLabel?.text = "暂无商品介绍"
            }
            if infoModel.price != nil {
                 priceLabel?.attributedText = dealPriceInSwift(price: infoModel.price!, firstFont: UIFont.systemFont(ofSize: 10), lastFont: UIFont.systemFont(ofSize: 10))
            }
           
            if infoModel.freight != nil {
                if (infoModel.freight?.isEqual("0"))! {
                    expressCharge?.text = "包邮"
                }else{
                    if let freight = Float(infoModel.freight!) {
                        let f = freight/100
                        expressCharge?.text = "快递: ".appendingFormat(String(f))
                    }
                }
            }else{
                expressCharge?.text = "包邮"
            }
            if let saleMonth = infoModel.sales_month {
                saleVolume?.text = "月销量\(saleMonth as String)件"
            }else {
                saleVolume?.text = "暂无销量";
            }
            if let area = infoModel.area {
                deliveryPlace?.text = area as String
            }else{
                deliveryPlace?.text = "暂无填写"
            }
            let leftPad: CGFloat = 10.0
            var totalW: CGFloat = leftPad
            var leaveW: CGFloat = screenW - leftPad - totalW
            let margin: CGFloat = 15.0
            let hmargin: CGFloat = 8.0
            var totalH: CGFloat = 10.0
            var mysize: CGSize?
            if let security = infoModel.security_range {
                if security.count > 0 {
                    for index in 0...(security.count - 1) {
                        let securityModel = security[index]
                        let size = securityModel.title?.sizeWith(font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(13)), maxSize: CGSize.init(width: screenW - 50, height: 20))
                        let height = (size?.height)! > GDCalculator.GDAdaptation(13) ? size?.height : GDCalculator.GDAdaptation(13)
                        let psize: CGSize = CGSize.init(width: (size?.width)! + GDCalculator.GDAdaptation(13), height: height!)
                        mysize = psize
                        if leaveW < psize.width {
                            totalH += psize.height + hmargin
                            totalW = leftPad
                            
                        }
                        let frame: CGRect = CGRect.init(x: totalW, y: 0, width: psize.width, height: psize.height)
                        let promotion: PromotionView = PromotionView.init(frame: frame)
                        self.contentSubView?.addSubview(promotion)
                        _ = promotion.mas_makeConstraints({ (make) in
                            make?.left.equalTo()(self.contentSubView?.mas_left)?.setOffset(totalW)
                            make?.top.equalTo()(self.contentSubView?.mas_top)?.setOffset(totalH)
                            _ = make?.width.equalTo()(psize.width)
                            _ = make?.height.equalTo()(psize.height)
                        })
                        promotion.securityModel = securityModel
                        totalW += psize.width + CGFloat(index) * margin
                        leaveW = screenW - totalW - leftPad
                        
                        
                    }
                    
                }
                if security.count == 0 {
                    if let size = mysize {
                        totalH += size.height + 10
                    }
                }else {
                    totalH = 10
                }
                
            }
            
            _ = self.contentSubView?.mas_updateConstraints({ (make) in
                _ = make?.height.equalTo()(totalH)
            })
            
            
        }
    }
    
}



class PromotionView: GDBaseControl {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.colorWithHexStringSwift("999999")
        titleLabel.font = UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(11))
        self.backgroundColor = UIColor.white
        _ = imageView.mas_makeConstraints({ (make) in
            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(12))
            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(12))
            make?.left.equalTo()(self.mas_left)?.setOffset(0)
            _ = make?.centerY.equalTo()(self.mas_centerY)
        })
        _ = titleLabel.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.imageView.mas_right)?.setOffset(5)
            make?.top.equalTo()(self.mas_top)?.setOffset(0)
            make?.right.equalTo()(self.mas_right)?.setOffset(0)
            make?.bottom.equalTo()(self.mas_bottom)?.setOffset(0)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var securityModel: SecurityModel = SecurityModel.init(dict: ["data": "" as AnyObject]){
        didSet{
            if let icon = securityModel.icon {
                imageView.sd_setImage(with: imgStrConvertToUrl(icon))
                
            }
            if let title = securityModel.title  {
                titleLabel.text = title
            }
            
        }
    }
    
}
