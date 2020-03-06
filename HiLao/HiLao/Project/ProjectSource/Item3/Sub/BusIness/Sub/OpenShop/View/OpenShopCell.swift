//
//  OpenShopCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class OpenShopCell: UITableViewCell {
    @IBOutlet var indexImage: UIImageView!
    
    @IBOutlet var rightImage: UIImageView!
    @IBOutlet var detail: UILabel!
    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rightImage.layer.borderColor = UIColor.colorWithHexStringSwift("d9d9d9").cgColor
        self.rightImage.layer.borderWidth = 5
        self.rightImage.backgroundColor = UIColor.colorWithHexStringSwift("e6e6e6")
        
        self.selectionStyle = .none
        // Initialization code
    }

    
    var model: OpenShopModel? {
        didSet {
            if let imageStr = model?.image, imageStr.count > 0 {
               
                self.rightImage.sd_setImage(with: imgStrConvertToUrl(imageStr), completed: nil)
            }
            self.indexImage.image = model?.indexImage
            self.title.text = model?.title
            self.detail.text = model?.detail 
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
