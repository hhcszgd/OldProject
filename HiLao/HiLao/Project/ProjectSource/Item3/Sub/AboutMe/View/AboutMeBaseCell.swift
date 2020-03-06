//
//  AboutMeBaseCell.swift
//  Project
//
//  Created by 张凯强 on 2017/11/21.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
let contentLeftWidth: CGFloat = SCREENWIDTH - 30 - 64 - 30
class AboutMeBaseCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.colorWithHexStringSwift("eeeeee")
        //子subview
        self.selectionStyle = .none
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    
    @objc func detailAction(btn: UIButton) {
        
    }
    
    @objc func itYouAction(btn: UIButton) {
        
    }
    
    ///留言
    @objc func replyAction(btn: UIButton) {
        
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
            self.replyLaberl.text = model?.replyContent
            self.replyTime.text = model?.createAt
            
        }
    }
    
    
    lazy var levelImage = UIImageView.init()
    
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
        label.font = UIFont.systemFont(ofSize: 13)
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
    var headerImage: AboutHeadImage = AboutHeadImage.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
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
        self.contentView.addSubview(view)
        return view
    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
