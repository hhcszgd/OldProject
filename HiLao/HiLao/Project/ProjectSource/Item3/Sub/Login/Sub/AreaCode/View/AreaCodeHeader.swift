//
//  AreaCodeHeader.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/28.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit

class AreaCodeHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.sizeToFit()
        self.titleLabel.textColor = UIColor.colorWithHexStringSwift("333333")
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    let titleLabel: UILabel = UILabel.init()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
