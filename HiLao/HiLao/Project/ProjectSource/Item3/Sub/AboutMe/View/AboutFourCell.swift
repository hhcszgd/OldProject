//
//  AboutFourCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/17.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class AboutFourCell: AboutMeBaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mySubView.backgroundColor = UIColor.white
        self.mySubView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            
        }
        
        self.mySubView.addSubview(self.headerImage)
        self.headerImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(-10)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        self.mySubView.addSubview(self.nickNamelabel)
        self.nickNamelabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerImage.snp.right).offset(9 * SCALE)
            make.centerY.equalTo(self.headerImage.snp.centerY)
            
        }
        self.mySubView.addSubview(self.levelImage)
        self.levelImage.snp.updateConstraints { (make) in
            make.centerY.equalTo(self.nickNamelabel)
            make.left.equalTo(self.nickNamelabel.snp.right).offset(6)
        }
        self.mySubView.addSubview(self.detailBtn)
        let size = DDLanguageManager.text("detail").sizeSingleLine(font: UIFont.systemFont(ofSize: 13))
        self.detailBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.headerImage.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(size.width + 30)
            make.height.equalTo(44)
            
        }
       
        self.mySubView.addSubview(self.replyTime)
        self.replyTime.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(45)
            make.top.equalTo(self.nickNamelabel.snp.bottom).offset(17)
            
        }
        self.mySubView.addSubview(self.replyLaberl)
        self.replyLaberl.snp.makeConstraints { (make) in
            make.left.equalTo(self.replyTime.snp.right).offset(7)
            make.centerY.equalTo(self.replyTime)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var model: AboutModel<OtherMember>? {
        didSet {
            self.headerImage.imgStr = model?.fromHeadImage
            self.nickNamelabel.text = model?.fromMemberNickname
            self.replyLaberl.text = model?.replyContent
            self.replyTime.text = model?.createAt
           
            
            self.levelImage.image = UIImage.init(named: "grade")
//            let height = 65
//            self.mySubView.snp.updateConstraints { (make) in
//                make.left.equalToSuperview().offset(15)
//                make.right.equalToSuperview().offset(-15)
//                make.top.equalToSuperview().offset(5)
//                make.height.equalTo(height)
//                make.bottom.equalToSuperview().offset(-5)
//                
//            }
            
            
            
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
