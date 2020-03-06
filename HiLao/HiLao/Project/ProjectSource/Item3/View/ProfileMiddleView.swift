//
//  ProfileMiddleView.swift
//  Project
//
//  Created by 张凯强 on 2017/11/28.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class ProfileMiddleView: UIView {

    init(frame: CGRect, viewModel: ProfileViewModel) {
        super.init(frame: frame)
        //阴影透明度
        self.layer.borderColor = UIColor.colorWithHexStringSwift("f4f4f4").cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.white
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        let dataArr = viewModel.middleItems.value
        let propert = CGFloat(45) / CGFloat(345)
        let width = SCREENWIDTH * (CGFloat(345) / CGFloat(375))
        let height = propert * width
        for (index, model) in dataArr.enumerated() {
            let subView = CustomDetailCell.init(frame: CGRect.init(x: 0, y: CGFloat(index) * height, width: width, height: height), viewModel: viewModel)
            
            subView.model = model
            subView.addTarget(self, action: #selector(cellClick(control:)), for: .touchUpInside)
            self.addSubview(subView)
        }
        
        self.viewModel = viewModel
        
    }
    var viewModel: ProfileViewModel!
    @objc func cellClick(control: CustomDetailCell) {
        guard let model = control.model else {
            return
        }
        self.viewModel.tap.onNext(model)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
