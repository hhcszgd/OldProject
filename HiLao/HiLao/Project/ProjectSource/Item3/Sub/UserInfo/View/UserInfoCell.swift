//
//  UserInfoCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/13.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UserInfoCell: CustomDetailCell {

    override init(frame: CGRect, viewModel: UserInfoVModel) {
        super.init(frame: frame, viewModel: viewModel)
        self.addTarget(self, action: #selector(clickAction(cell:)), for: .touchUpInside)
        self.viewModel = viewModel
    }
    var viewModel: UserInfoVModel!
    @objc func clickAction(cell: UserInfoCell) {
        guard let model = cell.model else { return
            
        }
        self.viewModel.click.onNext(model)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
