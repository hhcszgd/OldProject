//
//  GDGoodsBaseCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDGoodsBaseCell: BaseColCell {

    /**商品ID*/
    var goods_id: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
