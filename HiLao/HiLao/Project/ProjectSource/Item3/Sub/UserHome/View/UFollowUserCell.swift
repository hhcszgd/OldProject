//
//  UFollowUserCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/19.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UFollowUserCell: UITableViewCell {

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
        self.contentView.addSubview(self.oneImageView)
        self.oneImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.height.width.equalTo(75)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.oneImageView.snp.right).offset(10)
            make.top.equalTo(self.oneImageView).offset(-2)
        }
        self.addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myTitleLabel.snp.right).offset(10)
            make.centerY.equalTo(self.myTitleLabel)
        }
        self.scoreLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.myTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(self.oneImageView.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.levelLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.myTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(self.scoreLabel.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.peopleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.myTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(self.levelLabel.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.distanceLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.scoreLabel.snp.bottom).offset(10)
            make.left.equalTo(self.oneImageView.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.oneLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.distanceLabel.snp.bottom).offset(10)
            make.left.equalTo(self.oneImageView.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.twoLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.distanceLabel.snp.bottom).offset(10)
            make.left.equalTo(self.oneLabel.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.threeLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.distanceLabel.snp.bottom).offset(10)
            make.left.equalTo(self.threeLabel.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.fourLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.distanceLabel.snp.bottom).offset(10)
            make.left.equalTo(self.threeLabel.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var myTitleLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        
        return label
    }()
    lazy var distanceLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.colorWithHexStringSwift("d8d8d8")
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(label)
        return label
    }()
    
    let oneImageView = UIImageView.init()


    lazy var scoreLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = UIColor.colorWithRGB(red: 255, green: 168, blue: 169)
        label.textColor = UIColor.white
        self.contentView.addSubview(label)
        return label
    }()
    lazy var levelLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.colorWithRGB(red: 250, green: 198, blue: 162)
        self.contentView.addSubview(label)
        return label
    }()
    lazy var oneLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = lineColor.cgColor
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = lineColor
        label.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var twoLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = lineColor.cgColor
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = lineColor
        label.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(label)
        return label
    }()
    lazy var threeLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = lineColor.cgColor
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = lineColor
        label.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(label)
        return label
    }()
    lazy var fourLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = lineColor.cgColor
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = lineColor
        label.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var peopleLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.white
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.colorWithRGB(red: 252, green: 166, blue: 252)
        label.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(label)
        label.numberOfLines = 1
        label.text = "参与者"
        return label
    }()
    
    

}
