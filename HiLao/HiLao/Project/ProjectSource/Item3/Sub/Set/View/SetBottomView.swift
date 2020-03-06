//
//  SetBottomView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/7.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class SetBottomView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(frame: CGRect, viewModel: SetViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
        self.layer.borderColor = UIColor.colorWithHexStringSwift("f4f4f4").cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.white
        let height: CGFloat = frame.size.height / CGFloat(viewModel.bottomItems.count)
        let width: CGFloat = frame.size.width
        for (index, model) in viewModel.bottomItems.enumerated() {
            let view = CustomDetailCell.init(frame: CGRect.init(x: 0, y: CGFloat(index) * height, width: width, height: height), viewModel: viewModel)
            model.left = 15
            model.leftTitleColor = UIColor.colorWithRGB(red: 74, green: 74, blue: 74)
            model.rightDetailTitleColor = UIColor.colorWithRGB(red: 166, green: 166, blue: 166)
            view.model = model
            view.addTarget(self, action: #selector(cellClick(control:)), for: .touchUpInside)
            self.addSubview(view)
        }
    }
    
    @objc func cellClick(control: CustomDetailCell) {
        self.viewModel.cellClick.onNext(control.model ?? CustomDetailModel())
    }
    var viewModel: SetViewModel!

}
