//
//  InputViewThree.swift
//  Project
//
//  Created by 张凯强 on 2017/12/6.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class InputViewThree: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    
    func setUI() {
        self.leftImageView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        self.leftLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(50)
            
        }

        self.textField.snp.updateConstraints { (make) in
            
            make.left.equalTo(self.leftLabel.snp.right).offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        
        self.textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (text) in
            self.text = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftLabel.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    var text: String = ""
    
    
    var title: String? {
        didSet{
            let size = title?.sizeSingleLine(font: UIFont.systemFont(ofSize: 14))
            let width = size?.width ?? 100
            self.leftLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.leftImageView.snp.right).offset(15)
                make.centerY.equalToSuperview()
                make.width.lessThanOrEqualTo(width)
            }
            self.leftLabel.text = title
        }
    }
    
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
    var placeholder: String? {
        didSet{
            self.textField.placeholder = placeholder
        }
    }
    
    var model: InputViewModel? {
        didSet {
            guard let inputModel = model else {
                return
            }
            if let leftImage = inputModel.leftImage {
                let width = leftImage.size.width
                let height = leftImage.size.height
                self.leftImageView.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(5)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(width)
                    make.height.equalTo(height)
                })
                self.leftImageView.image = leftImage
            }
            if let placeholder = inputModel.placeholder {
                self.textField.placeholder = placeholder
            }
            
            
        }
    }
    
    lazy var verification: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("获取验证码", for: UIControlState.normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("1a1a1a"), for: UIControlState.normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(getVerification(btn:)), for: UIControlEvents.touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    
    lazy var verticalLine: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        self.addSubview(view)
        return view
    }()
    
    lazy var selectCodeBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("+86", for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("1a1a1a"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(getCode(btn:)), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    @objc func getCode(btn: UIButton) {
        
    }
    
    
    @objc func getVerification(btn: UIButton) {
        
    }
    
    
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        return view
    }()
    
    
    
    lazy var leftImageView: UIImageView = {
        let image = UIImageView.init()
        self.addSubview(image)
        return image
    }()
    
    lazy var textField: UITextField = {
        let field = UITextField.init(frame: CGRect.zero)
        field.textAlignment = NSTextAlignment.left
        field.font =  font13
        field.textColor = UIColor.colorWithRGB(red: 153, green: 153, blue: 153)
        self.addSubview(field)
        return field
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        mylog("销毁")
    }
    

}
