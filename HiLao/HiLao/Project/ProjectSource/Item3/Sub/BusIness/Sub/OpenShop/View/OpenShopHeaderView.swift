//
//  OpenShopHeaderView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class OpenShopHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
        }
    }
    var title: String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        label.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label)
        label.sizeToFit()
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

