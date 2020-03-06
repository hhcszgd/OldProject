//
//  BusinessCell.swift
//  Project
//
//  Created by 张凯强 on 2017/11/22.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet var shopCreatTime: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var btn: UIButton!
    @IBOutlet var shopClass: UILabel!
    @IBOutlet var shopName: UILabel!
    @IBOutlet var shopLogoImageViwe: UIImageView!
    @IBOutlet var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backView.layer.masksToBounds = true
        self.backView.layer.cornerRadius = 12
        self.backView.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.colorWithRGB(red: 242, green: 242, blue: 242)
        self.btn.layer.cornerRadius = 25
        self.btn.layer.masksToBounds = true
        self.btn.layer.borderWidth = 3
        self.btn.layer.borderColor = UIColor.white.cgColor
        self.btn.adjustsImageWhenHighlighted = false
        // Initialization code
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        
    }
    let noSubmitColor = UIColor.colorWithHexStringSwift("4d4d4d")
    let statusTextColor = UIColor.colorWithHexStringSwift("99ffff")
    let auditColor = UIColor.colorWithHexStringSwift("ff9c00")
    let nopassColor = UIColor.colorWithHexStringSwift("ee4f4f")
    let entrybutton = UIImage.init(named: "entrybutton_i")
    let entrybutton_ii = UIImage.init(named: "entrybutton_ii")
    let entrybutton_iii = UIImage.init(named: "entrybutton_iii")
    let entrybutton_iv = UIImage.init(named: "entrybutton_iv")
    
    var model: BusModel? {
        didSet {
            if let imageStr = model?.image {
                self.shopLogoImageViwe.sd_setImage(with: imgStrConvertToUrl(imageStr), placeholderImage: placeImageUse, options: .cacheMemoryOnly)
            }
            self.shopName.text = model?.shopName
            self.shopCreatTime.text = model?.createAt
            self.shopClass.text = model?.shopClassName
            self.statusLabel.textColor = self.statusTextColor
            if model?.status == 1 {
                self.statusLabel.isHidden = true
                self.btn.setBackgroundImage(entrybutton, for: .normal)
                
            }else {
                self.statusLabel.isHidden = false
                if model?.status == -1 {
                    self.statusLabel.backgroundColor = noSubmitColor
                    self.statusLabel.text = DDLanguageManager.text("nosubmit")
                    self.btn.setBackgroundImage(entrybutton_ii, for: .normal)
                }
                if model?.status == 0 {
                    self.statusLabel.backgroundColor = auditColor
                    self.statusLabel.text = DDLanguageManager.text("aduit")
                    self.btn.setBackgroundImage(entrybutton_iii, for: .normal)
                }
                if model?.status == 2 {
                    self.statusLabel.backgroundColor = nopassColor
                    self.statusLabel.text = DDLanguageManager.text("noPass")
                    self.btn.setBackgroundImage(entrybutton_iv, for: .normal)
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
