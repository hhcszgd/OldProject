//
//  NormalCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/7.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class NormalCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.myTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview()
        }
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    lazy var lineView: UIView = {
        let view = UIView.init()
        self.contentView.addSubview(view)
        view.backgroundColor = lineColor
        
        return view
    }()

    lazy var myTitleLabel: UILabel = {
        let label = UILabel.init()
        self.contentView.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("4d4d4d")
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
