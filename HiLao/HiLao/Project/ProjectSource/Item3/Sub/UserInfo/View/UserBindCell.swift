//
//  UserBindCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/13.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UserBindCell: GDControl {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(frame: CGRect, viewModel: UserInfoVModel) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 20
        
        self.bindBtn.backgroundColor = UIColor.white
        bindBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-17)
            make.width.equalTo(100)
            make.height.equalTo(34)
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(-17)
            make.height.equalTo(1)
        }

    }
    
    var model: CustomDetailModel? {
        didSet {
            self.imageView.image = model?.leftImage
            
        }
    }
    @objc func bindAction(btn: UIButton) {
        
    }
    
    
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.addSubview(view)
        return view
    }()
    
    lazy var bindBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("bind"), for: .normal)
        btn.setTitle(DDLanguageManager.text("noBind"), for: .selected)
        btn.setTitleColor(publicrightTitleColor, for: .normal)
        btn.setTitleColor(publicrightTitleColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 6
        btn.layer.borderColor = ashColor.cgColor
        btn.layer.borderWidth = 1
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(bindAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    

}
