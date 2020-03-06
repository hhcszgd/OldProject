//
//  SetCell.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/31.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        
        self.subView.rightSwitch.addTarget(self, action: #selector(switchClicK(click:)), for: .touchUpInside)
    }
    var switchClcikBlock: ((CustomDetailModel?, UISwitch) -> ())!
    @objc func switchClicK(click: UISwitch) {
        self.switchClcikBlock(model, click)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    lazy var subView: CustomDetailCell = {
        let view = CustomDetailCell.init(frame: CGRect.zero)
        
        self.contentView.addSubview(view)
        return view
    }()

    var model: CustomDetailModel? {
        didSet{
            self.subView.model = model
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subView.frame = self.bounds
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
