//
//  InputSex.swift
//  Project
//
//  Created by 张凯强 on 2017/12/6.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
enum SexType: String {
    case women = "women"
    case men = "men"
    case secrecy = "secrecy"
}
class InputSex: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setUI() {
        self.leftImageView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(0)
            make.height.equalTo(0)
        }
        
        self.leftLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(0)
            
        }
        self.title = DDLanguageManager.text("sex")
        
        self.women.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftLabel.snp.right).offset(10)
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
    
    var title: String? {
        didSet {
            let size = title?.sizeSingleLine(font: UIFont.systemFont(ofSize: 14))
            let width = size?.width ?? 50
            self.leftLabel.snp.updateConstraints { (make) in
                make.width.equalTo(width)
            }
            self.leftLabel.text = title
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
    
    
    
    lazy var leftImageView: UIImageView = {
        let image = UIImageView.init()
        self.addSubview(image)
        return image
    }()
    
    
    lazy var leftLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        label.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(label)
        return label
    }()
    
    var leftImage: UIImage? {
        didSet{
            if let leftImage = leftImage {
                let width = leftImage.size.width
                let height = leftImage.size.height
                self.leftImageView.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(20)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(width)
                    make.height.equalTo(height)
                })
                self.leftImageView.image = leftImage
            }
        }
    }

}
class SexBtn: GDControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.subImageView)
        self.addSubview(self.titleLabel)
        self.subImageView.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        let leftWidth = self.selectImage?.size.width ?? 20
        let leftHeigh = self.selectImage?.size.height ?? 20
        self.imageView.snp.updateConstraints { (make) in
            make.right.equalTo(self.subImageView.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.height.equalTo(leftWidth)
            make.width.equalTo(leftHeigh)
        }
        self.titleLabel.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.subImageView.snp.right).offset(5)
           
        }
        self.titleLabel.sizeToFit()
        
    
        self.titleLabel.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var sex: String? {
        didSet {
            self.titleLabel.text = sex
        }
    }
    var sexImage: UIImage? {
        didSet {
            guard let image = sexImage else {
                return
            }
            let widht: CGFloat = image.size.width
            let height: CGFloat = image.size.height
            self.subImageView.snp.updateConstraints { (make) in
                make.width.equalTo(widht)
                make.height.equalTo(height)
            }
            self.subImageView.image = image
        }
    }
    var selectImage = UIImage.init(named: "selected_btn_icon")
    var image = UIImage.init(named: "btn_icon")
    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.imageView.image = selectImage
            }else {
                self.imageView.image = image
            }
        }
    }
}


