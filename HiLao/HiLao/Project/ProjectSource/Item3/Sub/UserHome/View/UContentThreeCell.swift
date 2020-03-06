//
//  UContentThreeCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UContentThreeCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        // 10 + 26 + 20 + 14 + 32 + 14 + 18 +  60
        self.messageTypelabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(15)
        }
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.messageTypelabel.snp.right).offset(5)
            make.centerY.equalTo(self.messageTypelabel.snp.centerY)
        }
        self.activeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myTitleLabel.snp.right).offset(5)
            make.centerY.equalTo(self.messageTypelabel)
        }
        
        
        self.runing.snp.updateConstraints { (make) in
            make.centerY.equalTo(self.messageTypelabel)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(self.messageTypelabel.snp.bottom).offset(13)
        }
        
        self.followPeople.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        self.contentView.addSubview(self.twoImageView)
        
        self.twoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(self.followPeople.snp.bottom).offset(6)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        self.timeLael.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.bottom.equalTo(self.lineView.snp.top)
            make.height.equalTo(30)
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
            let content = model?.content?.boardDesc ?? ""
            
            self.contentLabel.text = content
            self.messageTypelabel.text = "他发起了"
            
            
            
            self.myTitleLabel.text = model?.title
            self.timeLael.text = model?.createAt
            self.activeLabel.text = "活动"
            self.twoImageView.image = placeImageUse
            self.runing.text = DDLanguageManager.text("runing")
            let runsize = self.runing.text?.sizeSingleLine(font: UIFont.systemFont(ofSize: 13)) ?? CGSize.init(width: 100, height: 30)
            self.runing.layer.cornerRadius = (runsize.height + 15) / 2.0
            self.runing.layer.masksToBounds = true
            self.runing.snp.updateConstraints { (make) in
                make.centerY.equalTo(self.messageTypelabel)
                make.right.equalToSuperview().offset(-10)
                make.width.equalTo(runsize.width + 30)
                make.height.equalTo(runsize.height + 15)
            }
            
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
        label.textColor = UIColor.colorWithHexStringSwift("ff7b7b")
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
    lazy var runing: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.colorWithHexStringSwift("fe5f5f")
        self.contentView.addSubview(label)
        return label
    }()
    lazy var zanBtn: ReplyBtn = {
        
        let btn = ReplyBtn.init(frame: CGRect.zero, image: UIImage.init(named: "fabulous"), title: "0")
        btn.titleColor = UIColor.colorWithHexStringSwift("c1c1c1")
        btn.titleLabel.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(zanAction(btn:)), for: .touchUpInside)
        self.contentView.addSubview(btn)
        return btn
    }()
    lazy var lefeMessage: ReplyBtn = {
        let btn = ReplyBtn.init(frame: CGRect.zero, image: UIImage.init(named: "reply"), title: "0")
        self.contentView.addSubview(btn)
        btn.titleColor = UIColor.colorWithHexStringSwift("494747")
        btn.titleLabel.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(leftMessageAction(btn:)), for: .touchUpInside)
        return btn
    }()

    lazy var followPeople: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(label)
        label.numberOfLines = 1
        label.text = "参与者"
        return label
    }()
    
    
    
}
