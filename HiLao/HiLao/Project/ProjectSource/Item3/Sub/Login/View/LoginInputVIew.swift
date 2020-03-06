//
//  LoginInputVIew.swift
//  wenyouhui
//
//  Created by 张凯强 on 2017/6/1.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
@objc protocol LoginInputDelegate: NSObjectProtocol {
    @objc optional func endEdit()//结束电话号码输入栏的编辑状态
}
class InputVIew: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftTitleLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0)
        }
        
        self.textField.snp.updateConstraints { (make) in
        
        make.left.equalTo(self.leftImageView.snp.right).offset(5)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        self.textField.rx.text.orEmpty.asObservable().subscribe(onNext: { (text) in
            self.text = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
    }
    var text: String = ""
    var leftTitle: String? {
        didSet {
            self.leftTitleLabel.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(10)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(80)
            }
            self.leftTitleLabel.text = leftTitle
        }
    }
    lazy var leftTitleLabel: UILabel = {
        let label = UILabel.init()
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
                    make.left.equalToSuperview().offset(5)
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
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = lineColor
        return view
    }()
    
   

    var phone: String?
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
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
