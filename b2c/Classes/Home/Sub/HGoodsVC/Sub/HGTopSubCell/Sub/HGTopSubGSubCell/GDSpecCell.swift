//
//  GDSpecCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDSpecCell: GDBaseCell {

    var channeLLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.white)
    var numLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 11), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.white)
    var specLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 11), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.white)
    let lineView: UIView = UIView.init()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        channeLLabel.sizeToFit()
        channeLLabel.text = "请选择"
        numLabel.sizeToFit()
        specLabel.sizeToFit()
        self.contentView.addSubview(channeLLabel)
        self.contentView.addSubview(numLabel)
        self.contentView.addSubview(specLabel)
        self.contentView.addSubview(lineView)
        channeLLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(10)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(10)
            
        }
        
        specLabel.mas_makeConstraints { (make) in
            _ = make?.centerY.equalTo()(self.channeLLabel.mas_centerY)
            make?.left.equalTo()(self.channeLLabel.mas_right)?.setOffset(10)
        }
        
        numLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.specLabel.mas_right)?.setOffset(10)
            _ = make?.centerY.equalTo()(self.channeLLabel.mas_centerY)
        }
        
        lineView.backgroundColor = BackGrayColor
        lineView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
            make?.top.equalTo()(self.channeLLabel.mas_bottom)?.setOffset(10)
            _ = make?.width.equalTo()(screenW)
            _ = make?.height.equalTo()(10)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    
    var specModel: GDSpecModel = GDSpecModel.init(dict: ["data": "" as AnyObject]) {
        didSet{
            self.channeLLabel.text = specModel.info!
            self.specLabel.text = specModel.myspec!
            self.numLabel.text = specModel.num!
        }
    }

}
