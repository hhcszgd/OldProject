//
//  UFollowShopCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/19.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UFollowShopCell: AboutMeBaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mySubView.backgroundColor = UIColor.white
        self.mySubView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-7)
            
        }
        
        self.mySubView.addSubview(self.headerImage)
        self.headerImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        self.mySubView.addSubview(self.nickNamelabel)
        self.nickNamelabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerImage.snp.right).offset(9 * SCALE)
            make.centerY.equalTo(self.headerImage.snp.centerY)
            
        }
        self.mySubView.addSubview(self.levelImage)
        self.levelImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.nickNamelabel.snp.right).offset(11)
            make.centerY.equalTo(self.nickNamelabel.snp.centerY)
            
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var model: AboutModel<OtherMember>? {
        didSet {
            self.headerImage.imgStr = model?.fromHeadImage
            self.nickNamelabel.text = model?.fromMemberNickname
            self.otherMemberActionLabel.text = "关注了你"
            self.otherMemberActionLabel.textColor = UIColor.colorWithHexStringSwift("494747")
            
   
            
            
        }
    }
    

}
