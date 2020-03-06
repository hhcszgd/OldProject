//
//  UserHeaderImage.swift
//  Project
//
//  Created by 张凯强 on 2017/12/13.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UserHeaderImage: GDControl {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    init(frame: CGRect, viewModel: UserInfoVModel) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        self.titleLabel.textColor = publicleftTitleColor
        self.titleLabel.font  = UIFont.systemFont(ofSize: 17)
        self.titleLabel.sizeToFit()
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            
        }
        
        
        self.addSubview(self.subTitlelabel)
        self.subTitlelabel.font  = UIFont.systemFont(ofSize: 13)
        self.subTitlelabel.backgroundColor = UIColor.colorWithHexStringSwift("acacac")
        self.subTitlelabel.textColor = UIColor.white
        self.subTitlelabel.textAlignment = .center
        self.subTitlelabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-17)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.subTitlelabel.layer.cornerRadius = 30
        self.subTitlelabel.layer.masksToBounds = true
        self.subTitlelabel.text = DDLanguageManager.text("upload")
        self.titleLabel.text = DDLanguageManager.text("headeriamge")
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-17)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 30
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = lineColor.cgColor
        
        self.imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(upload))
        self.imageView.addGestureRecognizer(tap)
        self.viewModel = viewModel
        
    }
    var viewModel: UserInfoVModel!
    @objc func upload() {
        self.viewModel.uploadImage.onNext("upload")
    }
    

}
