//
//  AreaCodeCell.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/26.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit

class AreaCodeCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.myTitleLabel)
        self.myTitleLabel.sizeToFit()
        self.contentView.addSubview(self.rightLabel)
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        self.myTitleLabel.textColor = UIColor.colorWithHexStringSwift("4d4d4d")
        self.myTitleLabel.font = font13
        
            
            
            
            
            
            
        self.rightLabel.sizeToFit()
        self.rightLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
        self.rightLabel.textColor = UIColor.colorWithHexStringSwift("4d4d4d")
        self.rightLabel.font = font13
        
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        self.selectionStyle = .none
        
    }
    lazy var myTitleLabel = UILabel.init()
    lazy var rightLabel = UILabel.init()
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.addSubview(view)
        return view
    }()
    var model: AreaCodeModel? {
        didSet{
            let area = model?.area ?? "86"
            self.myTitleLabel.text = model?.name
            self.rightLabel.text = "+" + area
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
