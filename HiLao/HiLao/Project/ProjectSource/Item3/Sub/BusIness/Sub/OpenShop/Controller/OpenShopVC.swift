//
//  OpenShopVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class OpenShopVC: GDNormalVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "openShop")
        self.naviBar.isHidden = false
        self.setUI()
        
        let model = OpenShopModel.init()
        self.dataArr = model.getModel()
        self.tableView.reloadData()
        model.requestModel().subscribe(onNext: { [weak self](dict) in
            guard let data = dict["data"] as? [String: String] else {
                return
            }
            let model1 = self?.dataArr[0][0]
            let model2 = self?.dataArr[0][1]
            let model3 = self?.dataArr[0][2]
            let model4 = self?.dataArr[1][0]
            let model5 = self?.dataArr[1][1]
            let model6 = self?.dataArr[1][2]
            model1?.image = data["example_business_licence_image"]
            model2?.image = data["example_front_image"]
            model3?.image = data["example_id_image"]
            model4?.image = data["example_qualification_image"]
            model5?.image = data["example_shop_image"]
            model6?.image = data["example_shop_logo_image"]
            self?.tableView.reloadData()
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
        
        // Do any additional setup after loading the view.
    }
    var dataArr: [[OpenShopModel]] = [[OpenShopModel]]()
    func setUI() {
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight + 38, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar - 38 - 50)
        self.tableView.register(OpenShopCell.self, forCellReuseIdentifier: "OpenShopCell")
        self.tableView.register(UINib.init(nibName: "OpenShopCell", bundle: Bundle.main), forCellReuseIdentifier: "OpenShopCell")
        self.tableView.register(OpenShopHeaderView.self, forHeaderFooterViewReuseIdentifier: "OpenShopHeaderView")
        self.view.addSubview(self.tableView)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let bottomView = UIView.init()
        self.view.addSubview(bottomView)
        
        bottomView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - TabBarHeight - 50, width: SCREENWIDTH, height: 50)
        bottomView.backgroundColor = UIColor.white
        bottomView.addSubview(self.addShopBtn)
        self.addShopBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
    }
    
    @objc func addShop(btn: UIButton) {
        let vc = SetUpShopOne()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = self.dataArr[section]
        return arr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = self.dataArr[indexPath.section]
        let model = arr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenShopCell", for: indexPath)
            as! OpenShopCell
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let arr = self.dataArr[indexPath.section]
        let model = arr[indexPath.row]
        let leftWidth: CGFloat = SCREENWIDTH - (15 + 15 + 8 + 130 + 10)
        let detailHeight: CGFloat = (model.detail ?? "").sizeWith(font: UIFont.systemFont(ofSize: 15), maxWidth: leftWidth).height
        let height: CGFloat = 10 + 15 + 10 + detailHeight + 10
        let subheight: CGFloat = 100
        
        
        
        return height > subheight ? height : subheight
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: OpenShopHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OpenShopHeaderView") as! OpenShopHeaderView
        if section == 0 {
            header.title = "必备证件"
        }
        if section == 1 {
            header.title = "准备资料"
        }
        return header
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    lazy var propmtLabel: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("4d4d4d")
        label.backgroundColor = UIColor.colorWithHexStringSwift("dadada")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.center
        label.text = DDLanguageManager.text("openShopPropmt")
        return label
    }()
    
    lazy var addShopBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("know"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(addShop(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    deinit {
        mylog("销毁")
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
