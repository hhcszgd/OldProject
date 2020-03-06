//
//  GDShopCar.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/7.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDShopCar: GDBaseControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = UIColor.colorWithHexStringSwift("ffffff")
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.sizeToFit()
        imageView.mas_makeConstraints { (make) in
            _ = make?.centerX.equalTo()(self.mas_centerX)
            _ = make?.centerY.equalTo()(self.mas_centerY)
            _ = make?.width.equalTo()(20)
            _ = make?.height.equalTo()(17)
        }
        imageView.image = UIImage.init(named: "icon_shoppingcart_small")
        
    }
    var num: String = "0" {
        didSet{
            
            if let number = Int(num) {
                if number == 0 {
                    titleLabel.backgroundColor = UIColor.clear
                    titleLabel.textColor = UIColor.clear
                    titleLabel.text = ""
                } else if ((number > 0 && number <= 9)) {
                    titleLabel.backgroundColor = THEMECOLOR
                    titleLabel.textColor = UIColor.white
                    titleLabel.text = String(number)
                } else {
                    titleLabel.backgroundColor = THEMECOLOR
                    titleLabel.textColor = UIColor.white
                    titleLabel.text = "+9"
                }
                
            }
            let size = titleLabel.text!.sizeWith(font: UIFont.systemFont(ofSize: 12), maxSize: CGSize.init(width: 44, height: 24))
            
            titleLabel.mas_updateConstraints { (make) in
                make?.centerX.equalTo()(self.imageView.mas_right)?.setOffset(0)
                make?.centerY.equalTo()(self.imageView.mas_top)?.setOffset(0)
                
                if size.width > size.height {
                    _ = make?.width.equalTo()(size.width)
                    _ = make?.height.equalTo()(size.width)
                    self.titleLabel.layer.cornerRadius = size.width/2.0
                }else {
                    _ = make?.width.equalTo()(size.height)
                    _ = make?.height.equalTo()(size.height)
                    self.titleLabel.layer.cornerRadius = size.height/2.0
                }
                
            }
            
            titleLabel.layer.masksToBounds = true
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
