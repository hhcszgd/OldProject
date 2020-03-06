//
//  BaseColCell.swift
//  OneSwiftProduct
//
//  Created by 张凯强 on 2016/10/8.
//  Copyright © 2016年 zhangkaiqiang. All rights reserved.
//

import UIKit

class BaseColCell: UICollectionViewCell {
    
    /**商品图片*/
    lazy var imageView = UIImageView.init()
    /**商品介绍*/
    lazy var titleLabel = UILabel.init()
    /**商品价格*/
    lazy var priceLabel = UILabel.init()
    /**月销量*/
    lazy var sales_monthLabel = UILabel.init()
    /**邮费*/
    lazy var postageLabel = UILabel.init()
    /**卖家名字*/
    lazy var sellerNameLabel = UILabel.init()
    
}
