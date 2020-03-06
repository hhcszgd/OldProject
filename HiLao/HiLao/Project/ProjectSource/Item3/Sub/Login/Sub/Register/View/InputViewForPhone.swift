//
//  InputViewForPhone.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/8.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class InputViewForPhone: InputViewTwo {
  
    
    override init(frame: CGRect, model: RegisterViewModel) {
        super.init(frame: frame)
        
        self.verticalLine.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-100)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(1)
        }
        self.selectCodeBtn.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.left.equalTo(self.verticalLine.snp.right)
        }
        model.returnAreaCode.asObservable().subscribe(onNext: { [weak self](areaCode) in
            self?.selectCodeBtn.setTitle( "+" + areaCode, for: .normal)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        self.textField.snp.updateConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-110)
        }
        let observale = self.textField.rx.text.orEmpty.asObservable()
        observale.subscribe(onNext: { (text) in
            model.phoneText.value = text
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        self.viewModel = model
    }
    
    var viewModel: RegisterViewModel!
    override func getCode(btn: UIButton) {
        self.viewModel.jumpToSelectCode.onNext("selectAreaCode")
    }
    
    
    override var leftImage: UIImage? {
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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

