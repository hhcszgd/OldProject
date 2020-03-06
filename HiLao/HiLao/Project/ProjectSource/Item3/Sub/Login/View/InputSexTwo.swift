//
//  InputSexTwo.swift
//  Project
//
//  Created by 张凯强 on 2017/12/14.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class InputSexTwo: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI() {
        
        self.women.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.men.snp.width)
        }
        self.men.snp.makeConstraints { (make) in
            make.left.equalTo(self.women.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.secrecy.snp.width)
        }
        self.secrecy.snp.makeConstraints { (make) in
            make.left.equalTo(self.men.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        
    }
    var sexSelect: Variable<SexType> = Variable<SexType>.init(.women)
    
    @objc func selectSex(control: SexBtn) {
        control.isSelected = true
        if control == self.women {
            self.men.isSelected = false
            self.secrecy.isSelected = false
            sexSelect.value = .women
        }
        
        if control == self.men {
            self.women.isSelected = false
            self.secrecy.isSelected = false
            sexSelect.value = .men
        }
        
        if control == self.secrecy {
            self.men.isSelected = false
            self.women.isSelected = false
            sexSelect.value = .secrecy
        }
        
    }
    
   
    
    lazy var women: SexBtn = {
        let btn = SexBtn.init(frame: CGRect.zero)
        btn.sex = DDLanguageManager.text("women")
        btn.sexImage = UIImage.init(named: "women_icon")
        btn.isSelected = true
        btn.addTarget(self, action: #selector(selectSex(control:)), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    lazy var men: SexBtn = {
        let btn = SexBtn.init(frame: CGRect.zero)
        btn.sex = DDLanguageManager.text("men")
        btn.sexImage = UIImage.init(named: "men_icon")
        btn.isSelected = false
        btn.addTarget(self, action: #selector(selectSex(control:)), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    lazy var secrecy: SexBtn = {
        let btn = SexBtn.init(frame: CGRect.zero)
        btn.sex = DDLanguageManager.text("secrecy")
        btn.sexImage = UIImage.init(named: "secrecy")
        btn.isSelected = false
        btn.addTarget(self, action: #selector(selectSex(control:)), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    
    
    
  
    
    

}
