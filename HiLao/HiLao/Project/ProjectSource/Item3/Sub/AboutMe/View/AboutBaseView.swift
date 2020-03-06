//
//  AboutBaseView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/16.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import SDWebImage
class AboutBaseView: UIView {
    init(frame: CGRect, viewModel: AboutMeViiewModel) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithHexStringSwift("eeeeee")
        //子subview
        self.mySubView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.headerImage = AboutHeadImage.init(frame: CGRect.init(x: -10, y: 0, width: 45, height: 45))
        self.mySubView.addSubview(self.headerImage)
        
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
        self.iteYouBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.nickNamelabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(64)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(64)
            make.top.equalTo(self.nickNamelabel.snp.bottom).offset(14)
            make.right.equalToSuperview().offset(-30)
        }
        self.mySubView.addSubview(self.replyLaberl)
        self.replyLaberl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(64)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        
        self.mySubView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.top.equalTo(self.replyLaberl.snp.bottom).offset(10)
        }
        self.mySubView.addSubview(self.replyTime)
        self.replyTime.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.lineView)
            make.bottom.equalToSuperview()
            
        }

        self.mySubView.addSubview(self.replyBtn)
        self.replyBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(self.lineView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        
    }
    var model: AboutModel<OtherMember>? {
        didSet {
            self.headerImage.imgStr = model?.fromHeadImage
            self.nickNamelabel.text = model?.fromMemberNickname
            if let messageType = model?.messageType {
                switch messageType {
                case 1:
                    self.otherMemberActionLabel.text = "评论中提到了你"
                case 2:
                    self.otherMemberActionLabel.text = "回复了你"
                case 3:
                    self.otherMemberActionLabel.text = "关注了你"
                case 4:
                    self.otherMemberActionLabel.text = "给你发了私信"
                default :
                    break
                }
            }
        }
    }
    
    
    
    @objc func detailAction(btn: UIButton) {
        
    }
    
    @objc func itYouAction(btn: UIButton) {
        
    }
    
    ///留言
    @objc func replyAction(btn: UIButton) {
        
    }
    
    
    
    lazy var contentLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.numberOfLines = 0
        return label
    }()
    
    lazy var replyLaberl: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.numberOfLines = 0
        label.backgroundColor = UIColor.colorWithHexStringSwift("f9f9f9")
        return label
    }()
    
    lazy var lineView: UIView = {
        let line = UIView.init()
        line.backgroundColor = lineColor
        return line
    }()
    
    lazy var replyTime: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.colorWithHexStringSwift("898989")
        label.font = UIFont.systemFont(ofSize: 10)
        label.sizeToFit()
        
        return label
    }()
    
    lazy var replyBtn: ReplyBtn = {
        let size = DDLanguageManager.text("leveingMessage").sizeSingleLine(font: UIFont.systemFont(ofSize: 12))
        let width = size.width + 20 + 5
        let btn = ReplyBtn.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 36), image: UIImage.init(named: "reply"), title: DDLanguageManager.text("leveingMessage"))
        btn.addTarget(self, action: #selector(replyAction(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var iteYouBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("@"), for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("6a79ea"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(itYouAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    
    ///头像
    var headerImage: AboutHeadImage!
    lazy var nickNamelabel: UILabel = {
        let label = UILabel.init()
        label.textColor = mainColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        
        return label
    }()
    lazy var detailBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("detail"), for: .normal)
        btn.setTitleColor(mainColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(detailAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var otherMemberActionLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("494747")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var mySubView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        self.addSubview(view)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class AboutHeadImage: GDControl {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.size.width / 2.0
        self.backgroundColor = UIColor.white
        self.addSubview(self.imageView)
        self.imageView.bounds = CGRect.init(x: 0, y: 0, width: frame.size.width - 10, height: frame.size.width - 10)
        self.imageView.layer.cornerRadius = (self.imageView.bounds.size.width - 10) / 2.0
        self.imageView.layer.masksToBounds = true
        self.imageView.center = self.center
    }
    var imgStr: String? {
        didSet{
            guard let headerImage = imgStr else {
                return
            }
            guard let url = imgStrConvertToUrl(headerImage) else {
                return
            }
            self.imageView.sd_setImage(with: url, placeholderImage: placeImageUse!, options: SDWebImageOptions.cacheMemoryOnly)
        }
    }
    
    
    
}

class ReplyBtn: GDControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    init(frame: CGRect, image: UIImage?, title: String) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        let imgWidth = image?.size.width ?? 20
        let imgHeight = image?.size.height ?? 20
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(imgWidth)
            make.height.equalTo(imgHeight)
        }
        self.titleLabel.sizeToFit()
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel.textColor = UIColor.colorWithHexStringSwift("494747")
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(3)
            make.top.right.bottom.equalToSuperview()
        }
        self.imageView.image = image
        self.titleLabel.text = title
    }
    var titleColor: UIColor = UIColor.colorWithHexStringSwift("494949") {
        didSet{
            self.titleLabel.textColor = titleColor
        }
    }
    var title: String = "" {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


