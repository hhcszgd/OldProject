//
//  GDBottomView.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
@objc protocol GDBottomViewDelegate:class {
    
    /**加入购物车*/
    func addShopCar(btn: UIButton)
    /**立即购买*/
    func buy(btn: UIButton)
    //客服
    func service(btn: UIButton)
    //店铺
    func enterStore(btn: UIButton)
    //收藏
    func collection(btn: UIButton)
    
}
class GDBottomView: UIView {

    ///代理
    weak var delegate: GDBottomViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width: CGFloat = (UIScreen.main.bounds.size.width - 220 * scale)/3.0
        let height: CGFloat =  frame.size.height
        //客服
        let serviceBtn: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        self.addSubview(serviceBtn)
        serviceBtn.addTarget(self, action: #selector(customerService(btn:)), for: UIControlEvents.touchUpInside)
        self.configmentbtn(btn: serviceBtn, title: "客服", backImage: UIImage.creatImageWithColor(color: UIColor.blue), image: nil, font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(13)), titleColor: UIColor.black)
        //店铺
        let store: UIButton = UIButton.init(frame: CGRect.init(x: width, y: 0, width: width, height: height))
        self.addSubview(store)
        store.addTarget(self, action: #selector(enterShop(btn:)), for: UIControlEvents.touchUpInside)
        self.configmentbtn(btn: store, title: "店铺", backImage: UIImage.creatImageWithColor(color: UIColor.green), image: nil, font: nil, titleColor: UIColor.black)
        //收藏
        let collection: UIButton = UIButton.init(frame: CGRect.init(x: 2 * width, y: 0, width: width, height: height))
        self.addSubview(collection)
        collection.addTarget(self, action: #selector(collectionGoods(btn:)), for: UIControlEvents.touchUpInside)
        self.configmentbtn(btn: collection, title: "收藏", backImage: UIImage.creatImageWithColor(color: UIColor.yellow), image: nil, font: nil, titleColor: UIColor.red)
        
        //加入购物车按钮
        let addCar: UIButton = UIButton.init(frame: CGRect.init(x: 3 * width, y: 0, width: 110 * scale, height: frame.size.height))
        addCar.addTarget(self, action: #selector(addGoodsToCar(btn:)), for: UIControlEvents.touchUpInside)
        self.addSubview(addCar)
        let backImge = UIImage.creatImageWithColor(color: THEMECOLOR)
        self.configmentbtn(btn: addCar, title: "加入购物车", backImage: backImge, image: nil, font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(13)), titleColor: UIColor.init(white: 1, alpha: 0.8))
        //立即购买按钮
        let buy: UIButton = UIButton.init(frame: CGRect.init(x: addCar.frame.size.width + addCar.frame.origin.x, y: 0, width: 110 * scale, height: frame.size.height))
        self.addSubview(buy)
        buy.addTarget(self, action: #selector(buyGoods(btn:)), for: UIControlEvents.touchUpInside)
        self.configmentbtn(btn: buy, title: "立即购买", backImage: UIImage.creatImageWithColor(color: UIColor.red), image: nil, font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(13)), titleColor: UIColor.white)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configmentbtn(btn: UIButton, title: String?, backImage: UIImage?, image: UIImage?, font: UIFont?, titleColor: UIColor?) {
        btn.adjustsImageWhenHighlighted = false
        if titleColor != nil {
            btn.setTitleColor(titleColor, for: UIControlState.normal)
        }
        if image != nil {
            btn.setImage(image, for: UIControlState.normal)
        }
        if title != nil {
            btn.setTitle(title, for: UIControlState.normal)
        }
        if backImage != nil{
            btn.setBackgroundImage(backImage, for: UIControlState.normal)
        }
        if font != nil {
            btn.titleLabel?.font = font
        }
        
        
        
    }
    func addGoodsToCar(btn: UIButton) {
        if delegate != nil {
            delegate?.addShopCar(btn: btn)
        }
    }
    //立即购买
    func buyGoods(btn: UIButton) {
        if delegate != nil {
            delegate?.buy(btn: btn)
        }
    }
    //客服
    func customerService(btn: UIButton) {
        if delegate != nil {
            delegate?.service(btn: btn)
        }
    }
    //店铺
    func enterShop(btn: UIButton) {
        if delegate != nil {
            delegate?.enterStore(btn: btn)
        }
    }
    //收藏商品
    func collectionGoods(btn: UIButton) {
        if delegate != nil {
            delegate?.collection(btn: btn)
        }
    }


}
