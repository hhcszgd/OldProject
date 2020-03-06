//
//  UContentColCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UContentColCell: UseBaseColCell, UITableViewDelegate, UITableViewDataSource {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        let paramete = ["l": LCode, "c": CountryCode, "member_id": String(95), "page": 0] as [String: Any]
        NetWork.manager.requestData(router: Router.post("Index/memberIndex", .interactive, paramete)).subscribe(onNext: { (dict) in
            let model = BaseModelForArr<UContentModel<ContentModel<ImagesModel>>>.deserialize(from: dict)
            guard let arr = model?.data else {
                return
            }
            self.dataArr = arr
            self.tableView.reloadData()
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
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
            if (model.content?.images.count ?? 0) > 0 {
                let content = model.content?.content ?? ""
                let contentHeight = content.sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 40)).height
                
                let messgeHeight: CGFloat = "111".sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 20)).height
                let height = 26 + messgeHeight + contentHeight + 20 + 14 + 60 + 18 + 40 + 10
                return height
            }else {
                let content = model.content?.content ?? ""
                let contentHeight = content.sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 40)).height
                
                let messgeHeight: CGFloat = "111".sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 20)).height
                let height = 26 + messgeHeight + contentHeight + 20 + 40 + 10
                return height
            }
        }else {
            let content = model.content?.boardDesc ?? ""
            let contentHeight = content.sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 40)).height
            
            let messgeHeight: CGFloat = "111".sizeWith(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize.init(width: SCREENWIDTH - 60, height: 20)).height
            let height = 15 + messgeHeight + 13 + contentHeight + 10 + 17 + 6 + 44 + 30 + 10
            return height
        
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
        let model = self.dataArr[indexPath.row]
        if model.messageType == 1 {
            let count = model.content?.images.count ?? 0
            if count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UContentOneCell", for: indexPath) as! UContentOneCell
                cell.model = model
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UContentTwoCell", for: indexPath) as! UContentTwoCell
                cell.model = model
                return cell
                
            }
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UContentThreeCell", for: indexPath) as! UContentThreeCell
            cell.model = model
            return cell
            
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UContentOneCell.self, forCellReuseIdentifier: "UContentOneCell")
        table.register(UContentTwoCell.self, forCellReuseIdentifier: "UContentTwoCell")
        table.register(UContentThreeCell.self, forCellReuseIdentifier: "UContentThreeCell")
        table.backgroundColor = UIColor.white
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        self.contentView.addSubview(table)
        return table
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
