//
//  UFollowColCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UFollowColCell: UseBaseColCell, UITableViewDelegate, UITableViewDataSource {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: 75))
        topView.backgroundColor = UIColor.white
        self.contentView.addSubview(topView)
        
        let channelView = UIView.init()
        topView.addSubview(channelView)
        let x = (SCREENWIDTH - 240) / 2.0
        channelView.frame = CGRect.init(x: x, y: 25, width: 240, height: 30)
        channelView.backgroundColor = UIColor.colorWithRGB(red: 230, green: 230, blue: 230)
        channelView.layer.masksToBounds = true
        channelView.layer.cornerRadius = 15
        channelView.addSubview(self.btnBackView)
        self.btnBackView.frame = CGRect.init(x: 0, y: 0, width: 130, height: 30)
        channelView.addSubview(self.shopBtn)
        self.shopBtn.frame = CGRect.init(x: 0, y: 0, width: 120, height: 30)
        channelView.addSubview(self.useBtn)
        self.useBtn.frame = CGRect.init(x: 120, y: 0, width: 120, height: 30)
        self.contentView.addSubview(self.tableView)
        self.tableView.frame = CGRect.init(x: 0, y: topView.max_Y, width: frame.size.width, height: frame.size.height - topView.max_Y)
        self.shopAction(btn: self.shopBtn)
        
    }
    @objc func shopAction(btn: UIButton) {
        btn.isSelected = true
        self.useBtn.isSelected = false
        UIView.animate(withDuration: 0.2) {
            self.btnBackView.frame = CGRect.init(x: 0, y: 0, width: 130, height: 30)
        }
        //切换数据
    }
    @objc func userAction(btn: UIButton) {
        btn.isSelected = true
        self.shopBtn.isSelected = false
        UIView.animate(withDuration: 0.2) {
            self.btnBackView.frame = CGRect.init(x: 110, y: 0, width: 130, height: 30)
        }
    }
    
    
    var dataArr: [UContentModel<ContentModel<ImagesModel>>] = []
    var viewModel: UseHomeViewModel!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataArr[indexPath.row]
        if model.messageType == 1 {
            return 95
            
        }else {
            return 65
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.shopBtn.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFollowShopCell", for: indexPath) as! UFollowShopCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFollowUserCell", for: indexPath) as! UFollowUserCell
            return cell
        }
        
    }
    
    
    
    lazy var btnBackView: UIView = {
        let view = UIView.init()
        view.backgroundColor = mainColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    lazy var shopBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("店铺", for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("333333"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(shopAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var useBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("用户", for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("333333"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(userAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UFollowShopCell.self, forCellReuseIdentifier: "UFollowShopCell")
        table.register(UFollowUserCell.self, forCellReuseIdentifier: "UFollowUserCell")
        table.backgroundColor = UIColor.white
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        self.contentView.addSubview(table)
        return table
    }()
}
