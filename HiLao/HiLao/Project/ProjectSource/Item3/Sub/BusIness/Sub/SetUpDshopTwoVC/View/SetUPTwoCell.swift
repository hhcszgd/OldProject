//
//  SetUPTwoCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/22.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class SetUPTwoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.white
        // Initialization code
    }
    var model: OpenShopModel? {
        didSet {
            self.contentView.subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            guard let dataArr = model?.imageArr else {
                return
            }
            mylog(dataArr)
            let width: CGFloat = (SCREENWIDTH - 5 * 20) / 4.0
            let height = width
            let margin: CGFloat = 20
            for (index, imgStr) in dataArr.enumerated() {
                
                let row = index / 4//行
                let line = index % 4//列
                let subImage = SetUpTwoSubimage.init(frame: CGRect.init(x: CGFloat(line + 1) * margin + CGFloat(line) * width, y: CGFloat(row) * width + CGFloat((row + 1)) * margin, width: width, height: width))
                self.contentView.addSubview(subImage)
                subImage.index = index
                subImage.button.addTarget(self, action: #selector(configmentData(btn:)), for: .touchUpInside)
                subImage.backgroundColor = UIColor.randomColor()
                subImage.imageView.sd_setImage(with: imgStrConvertToUrl(imgStr), completed: nil)
            }
        }
    }
    
    @objc func configmentData(btn: UIButton) {
        mylog(model?.imageArr)
        guard let dataArr = model?.imageArr, dataArr.count > 0 else {
            return
        }
        self.removeImage(btn.tag)
    }
    var removeImage: ((Int) -> ())!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
class SetUpTwoSubimage: GDControl {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.button)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.button.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        self.button.backgroundColor = UIColor.red
        
    }
    var index: Int = 0 {
        didSet {
            self.button.tag = index
        }
    }
    
    
}


