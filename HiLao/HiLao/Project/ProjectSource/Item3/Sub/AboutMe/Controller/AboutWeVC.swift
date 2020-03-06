//
//  AboutWeVC.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/7.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import HandyJSON
class AboutWeVC: GDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "setAboutWe")

        self.setUI()
    
        // Do any additional setup after loading the view.
    }
    func setUI() {
        self.view.addSubview(self.tableView)
        self.tableView.register(AboutOneCell.self, forCellReuseIdentifier: "AboutOneCell")
        self.tableView.register(AboutTwoCell.self, forCellReuseIdentifier: "AboutTwoCell")
        self.tableView.register(AboutThreeCell.self, forCellReuseIdentifier: "AboutThreeCell")
        self.tableView.register(AboutFourCell.self, forCellReuseIdentifier: "AboutFourCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.refresh()
        
    }
    
    override func refresh() {
        
        let param =  ["l": LCode, "c": CountryCode, "token": DDAccount.share().token, "member_id": "95", "page": 0] as [String: Any]
        
        NetWork.manager.requestData(router: Router.post("Index/about", .interactive, param)).subscribe(onNext: { (dict) in
            let model = BaseModelForArr<AboutModel<OtherMember>>.deserialize(from: dict)
            if model?.status == 2000 {
                guard let arr = model?.data else {
                    return
                }
                
                self.dataArr = arr
                self.tableView.reloadData()
            }
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: nil, onDisposed: nil)
        
    }
    var dataArr: [AboutModel<OtherMember>] = []
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArr[indexPath.row]
        let messageType = model.messageType ?? 1
        if messageType == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutOneCell", for: indexPath) as! AboutOneCell
            cell.model = model
            return cell
        }else if messageType == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTwoCell", for: indexPath) as! AboutTwoCell
            cell.model = model
            return cell
        }else if messageType == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutThreeCell", for: indexPath) as! AboutThreeCell
            cell.model = model
            return cell
        }else if messageType == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutFourCell", for: indexPath) as! AboutFourCell
            cell.model = model
            return cell
        }else {
            let cell = UITableViewCell.init()
            return cell
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataArr[indexPath.row]
        if model.messageType == 1 {
            let contentSize = model.replyContent?.sizeWith(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: contentLeftWidth, height: 100)) ?? CGSize.init(width: contentLeftWidth, height: 30)
            let nickNameSize = model.fromMemberNickname?.sizeSingleLine(font: UIFont.systemFont(ofSize: 13)) ?? CGSize.init(width: contentLeftWidth, height: 20)
            let height = (contentSize.height + 14 + 12 + 16 + 36 + nickNameSize.height + 10)
            return height
        }
        if model.messageType == 2 {
            let contentSize = model.replyContent?.sizeWith(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: contentLeftWidth, height: 100)) ?? CGSize.init(width: contentLeftWidth, height: 30)
            let nickNameSize = model.fromMemberNickname?.sizeSingleLine(font: UIFont.systemFont(ofSize: 13)) ?? CGSize.init(width: contentLeftWidth, height: 20)
            
            let height = (contentSize.height + 14 + 12 + 15 + 36 + 20 + nickNameSize.height + 25 + 10)
            return height
            
        }
        if model.messageType == 3 {
            return 95
        }
        if model.messageType == 4 {
            return 75
        }
        return 65
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
