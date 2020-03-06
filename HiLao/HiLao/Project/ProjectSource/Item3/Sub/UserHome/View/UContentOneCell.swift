//
//  UContentOneCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UContentOneCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        // 10 + 26 + 20 + 14 + 32 + 14 + 18 +  60
        self.messageTypelabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(26)
        }
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.messageTypelabel.snp.right).offset(5)
            make.centerY.equalTo(self.messageTypelabel.snp.centerY)
        }
        self.activeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myTitleLabel.snp.right).offset(5)
            make.centerY.equalTo(self.messageTypelabel)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(self.messageTypelabel.snp.bottom).offset(20)
        }
        self.contentView.addSubview(self.oneImageView)
        self.contentView.addSubview(self.twoImageView)
        self.contentView.addSubview(self.threeImageView)
        self.oneImageView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(14)
            make.height.equalTo(60)
            make.width.equalTo(self.twoImageView.snp.width)
        }
        self.twoImageView.snp.updateConstraints { (make) in
            make.left.equalTo(self.oneImageView.snp.right).offset(22)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(14)
            make.height.equalTo(60)
            make.width.equalTo(self.threeImageView.snp.width)
        }
        self.threeImageView.snp.updateConstraints { (make) in
            make.left.equalTo(self.twoImageView.snp.right).offset(22)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(14)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        
        self.subLineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.bottom.equalTo(self.lineView.snp.top).offset(-40)
        }
        
        self.timeLael.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.subLineView.snp.bottom)
            make.bottom.equalTo(self.lineView.snp.top)
        }
        self.zanBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLael.snp.right).offset(5)
            make.top.equalTo(self.subLineView.snp.bottom)
            make.bottom.equalTo(self.lineView.snp.top)
            make.width.equalTo(80)
        }
        
        self.lefeMessage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(self.subLineView.snp.bottom)
            make.bottom.equalTo(self.lineView.snp.top)
            make.width.equalTo(80)
        }
        
        
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    
    @objc func zanAction(btn: ReplyBtn) {
        
    }
    @objc func leftMessageAction(btn: ReplyBtn) {
        
    }
    
    var model: UContentModel<ContentModel<ImagesModel>>? {
        didSet {
            let content = model?.content?.content ?? ""
        
            self.contentLabel.text = content
            if model?.messageType == 1 {
                self.messageTypelabel.text = "他评论了"
            }else if model?.messageType == 2 {
                self.messageTypelabel.text = "他发起了"
            }
         
            if let imageArr = model?.content?.images {
                if let imgStr = imageArr.first?.image {
                    self.oneImageView.sd_setImage(with: imgStrConvertToUrl(imgStr), placeholderImage: placeImageUse!, options: .cacheMemoryOnly)
                    self.oneImageView.isHidden = false
                }else {
                    self.oneImageView.isHidden = true
                }
                if imageArr.count >= 2, let imgStr = imageArr[1].image {
                     self.twoImageView.sd_setImage(with: imgStrConvertToUrl(imgStr), placeholderImage: placeImageUse!, options: .cacheMemoryOnly)
                    self.twoImageView.isHidden = false
                }else {
                    self.twoImageView.isHidden = true
                }
                if imageArr.count >= 3, let imgStr = imageArr[2].image {
                    self.threeImageView.sd_setImage(with: imgStrConvertToUrl(imgStr), placeholderImage: placeImageUse!, options: .cacheMemoryOnly)
                    self.threeImageView.isHidden = false
                }else {
                    self.threeImageView.isHidden = true
                }
                
            }
            self.myTitleLabel.text = model?.title
            self.timeLael.text = model?.createAt
            self.zanBtn.title = "9999"
            
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.contentView.addSubview(view)
        return view
    }()
    lazy var messageTypelabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        
        return label
    }()
    lazy var myTitleLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        
        return label
    }()
    lazy var activeLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(label)
        label.numberOfLines = 2
        return label
    }()
    
    let oneImageView = UIImageView.init()
    let twoImageView = UIImageView.init()
    let threeImageView = UIImageView.init()
    lazy var subLineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.contentView.addSubview(view)
        return view
    }()
    lazy var timeLael: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.colorWithHexStringSwift("898989")
        self.contentView.addSubview(label)
        return label
    }()
    lazy var zanBtn: ReplyBtn = {
        let btn = ReplyBtn.init(frame: CGRect.zero, image: UIImage.init(named: "fabulous"), title: "0")
        
        self.contentView.addSubview(btn)
        btn.titleColor = UIColor.colorWithHexStringSwift("c1c1c1")
        btn.titleLabel.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(zanAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var lefeMessage: ReplyBtn = {
        let btn = ReplyBtn.init(frame: CGRect.zero, image: UIImage.init(named: "reply"), title: "0")
        btn.title =  "给他留言"
        self.contentView.addSubview(btn)
        btn.titleColor = UIColor.colorWithHexStringSwift("494747")
        btn.titleLabel.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(leftMessageAction(btn:)), for: .touchUpInside)
        return btn
    }()
}
