//
//  OpenShopOneStepCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/21.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class OpenShopOneStepCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.rightImage.layer.borderColor = lineColor.cgColor
        self.rightImage.layer.borderWidth = 5
        self.addImageBtn.adjustsImageWhenHighlighted = false
        self.rightImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(seeImage(tap:)))
        self.rightImage.addGestureRecognizer(tap)
        self.selectionStyle = .none
        // Initialization code
    }
    
    
    var model: OpenShopModel? {
        didSet {
            if let imageStr = model?.image, imageStr.count > 0 {
                self.rightImage.sd_setImage(with: imgStrConvertToUrl(imageStr), completed: nil)
                self.addImageBtn.isHidden = true
            }else {
                self.addImageBtn.isHidden = false
            }
            self.indexImage.image = model?.indexImage
            self.title.text = model?.title
            self.detail.text = model?.detail
        }
    }
    
    @IBOutlet var addImageBtn: UIButton!
    
    @objc func seeImage(tap: UITapGestureRecognizer) {
        
    }
    
    @IBAction func addShopAction(_ sender: Any) {
        self.addImage(self.model ?? OpenShopModel())
    }
    var addImage: ((OpenShopModel) -> ())!
    @IBOutlet var btn: UIButton!
    @IBOutlet var rightImage: UIImageView!
    @IBOutlet var detail: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var indexImage: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
