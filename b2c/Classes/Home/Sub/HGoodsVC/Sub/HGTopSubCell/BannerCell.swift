//
//  BannerCell.swift
//  OneSwiftProduct
//
//  Created by 张凯强 on 2016/10/8.
//  Copyright © 2016年 zhangkaiqiang. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCell: BaseColCell {
    
    var bannderModel:BannerModel = BannerModel(dict: ["image":"imageStr" as AnyObject]){
        didSet{
            
            let imgStr: String = bannderModel.img!
            let url: URL = imgStrConvertToUrl(imgStr)!
            imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: SDWebImageOptions.retryFailed)
            
        }
        
        
    }
    
    

//    var composeModel: HComposeModel = HComposeModel.init(dict: ["data": "data" as AnyObject]){
//        didSet{
//            let imgStr: String = composeModel.img!
//            let url: URL = imgStrConvertToUrl(imgStr)!
//            imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: SDWebImageOptions.retryFailed)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
