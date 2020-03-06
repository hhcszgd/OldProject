//
//  AboutOneCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/17.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class AboutOneCell: AboutMeBaseCell {

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
        self.mySubView.addSubview(self.otherMemberActionLabel)
        self.otherMemberActionLabel.snp.makeConstraints { (make) in
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
        self.mySubView.addSubview(self.iteYouBtn)
        self.mySubView.addSubview(self.contentLabel)
        
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(64)
            make.top.equalTo(self.nickNamelabel.snp.bottom).offset(14)
            make.right.equalToSuperview().offset(-30)
        }
        self.mySubView.addSubview(self.replyLaberl)
        
        
        self.mySubView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
        }
        self.mySubView.addSubview(self.replyTime)
        self.replyTime.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.lineView)
            make.height.equalTo(36)
            
        }
        
        self.mySubView.addSubview(self.replyBtn)
        self.replyBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(self.lineView.snp.bottom)
            make.width.equalTo(60)
            make.height.equalTo(36)
        }
        
        
    }
    override var model: AboutModel<OtherMember>? {
        didSet {
            self.headerImage.imgStr = model?.fromHeadImage
            self.nickNamelabel.text = model?.fromMemberNickname
            self.otherMemberActionLabel.text = "评论中提到了你"
            self.replyLaberl.text = model?.replyContent
            self.replyTime.text = model?.createAt
            self.contentLabel.text = model?.replyContent
//            let contentSize = model?.replyContent?.sizeWith(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: contentLeftWidth, height: 100)) ?? CGSize.init(width: contentLeftWidth, height: 30)
//            let nickNameSize = model?.fromMemberNickname?.sizeSingleLine(font: UIFont.systemFont(ofSize: 13)) ?? CGSize.init(width: contentLeftWidth, height: 20)
//            let height = Int(contentSize.height + 14 + 12 + 16 + 36 + nickNameSize.height)
//            
//            
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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
