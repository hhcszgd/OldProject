//
//  InputViewModel.swift
//  Project
//
//  Created by 张凯强 on 2017/11/26.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class InputViewModel: NSObject {
    var rightTitle: String?
    var rightImage: UIImage?
    var isShowLine: Bool = true
    var leftImage: UIImage?
    var leftTitle: String?
    var rightBtnHidden: Bool = true
    var rightBtnTitle: String?
    var rightBtnActionKey: String?
    var rightTitleFont: UIFont = UIFont.systemFont(ofSize: 13)
    var rightTitleColor: UIColor = UIColor.black
    var rightBtnTitleColor: UIColor = UIColor.black
    var placeholder: String?
    var textFieldFont: UIFont = UIFont.systemFont(ofSize: 13)
    
    
}
