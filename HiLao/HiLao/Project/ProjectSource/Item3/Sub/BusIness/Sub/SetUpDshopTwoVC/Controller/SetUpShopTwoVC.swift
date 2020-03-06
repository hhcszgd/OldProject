//
//  SetUpShopTwoVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/22.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class SetUpShopTwoVC: GDNormalVC {

    let uploadImage = UploadPicturesTool()
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.viewController = self
        self.tableView.backgroundColor = UIColor.white
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "addShopTwo")
        self.setUI()
        
        
        let model = OpenShopModel.init()
        self.dataArr = model.getTwoModel()
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    var dataArr: [OpenShopModel] = [OpenShopModel]()
    func setUI() {
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight + 38, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar - 38 - 50)
        
        self.tableView.register(UINib.init(nibName: "OpenShopOneStepCell", bundle: Bundle.main), forCellReuseIdentifier: "OpenShopOneStepCell")
        
        self.tableView.register(UINib.init(nibName: "SetUPTwoCell", bundle: Bundle.main), forCellReuseIdentifier: "SetUPTwoCell")
        self.view.addSubview(self.tableView)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.bounces = false
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
        self.propmtTwoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(33)
            make.width.equalTo(SCREENWIDTH)
        }
        
    }
    
    @objc func addShop(btn: UIButton) {
        let account = DDAccount.share()
        guard let memberid = account.id  else {
            return
        }
        guard let shopID = self.keyModel?.keyParameter as? String else { return }
        let model1 = self.dataArr[0]
        let model2 = self.dataArr[1]
        let model3 = self.dataArr[2]
        guard let idImage = model1.image, idImage.count > 0  else {
            GDAlertView.alert("用户身份证件照不能为空", image: nil, time: 1, complateBlock: nil)
            return
            
        }
        guard let businessImage = model2.image, businessImage.count > 0 else {
            GDAlertView.alert("营业执照不能为空", image: nil, time: 1, complateBlock: nil)
            return
            
        }
        var shopImageStr: [String: String] = [:]
        for (index, str) in model3.imageArr.enumerated() {
            shopImageStr[("shop" + String(index))] = str
        }
        let json = JSONEncoder.init()
        let result = try? json.encode(shopImageStr)
        let resultStr = String.init(data: result!, encoding: .utf8)!
        let paramete = ["token": account.token, "member_id": memberid, "front_img": idImage, "shop_logo_image": businessImage, "shop_image": resultStr, "shop_examine_id": shopID] as [String: Any]
        NetWork.manager.requestData(router: Router.post("addshopexaminetwo", .shopShopExamine, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<GDModel>.deserialize(from: dict)
            if model?.status == 1211{
                guard let data = dict["data"] as? [String: String], let shopID = data["shopexamine_id"] else {
                    return
                }
                let model = GDModel.init()
                model.keyParameter = shopID
                let vc = SetUpShopThreeVC.init(nibName: "SetUpShopThreeVC", bundle: Bundle.main)
                vc.keyModel = model
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model3 = self.dataArr.last, model3.imageArr.count > 0 {
            return self.dataArr.count + 1
        }else {
            return self.dataArr.count
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <= 2 {
            let model = self.dataArr[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "OpenShopOneStepCell", for: indexPath) as! OpenShopOneStepCell
            cell.model = model
            cell.addImage = {[unowned self] (model) in
                self.uploadImage.model = model
                self.uploadImage.changeHeadPortrait()
                
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetUPTwoCell", for: indexPath) as! SetUPTwoCell
            let model = self.dataArr.last
            cell.model = model
            cell.removeImage = { [weak self](index) in
                
                self?.dataArr.last?.imageArr.remove(at: index)
                mylog(self?.dataArr.last?.imageArr)
                if self?.dataArr.last?.imageArr.count == 0 {
                    self?.tableView.reloadData()
                }else {
                    self?.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: UITableViewRowAnimation.none)
                }
                
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row <= 2 {
            let model = self.dataArr[indexPath.row]
            let leftWidth: CGFloat = SCREENWIDTH - (15 + 15 + 8 + 130 + 10)
            let detailHeight: CGFloat = (model.detail ?? "").sizeWith(font: UIFont.systemFont(ofSize: 15), maxWidth: leftWidth).height
            let height: CGFloat = 10 + 15 + 10 + detailHeight + 10 + 27 + 5
            let subheight: CGFloat = 100
            return height > subheight ? height : subheight
        }else {
            let width: CGFloat = (SCREENWIDTH - (5 * 20)) / 4.0
            if let imageArr = self.dataArr.last?.imageArr, imageArr.count > 0 {
                let row = imageArr.count / 4
                if (imageArr.count % 4) == 0 {
                    let height = CGFloat(row) * width + CGFloat(row + 1) * 20
                    return height
                }else {
                    let height = CGFloat(row + 1) * width + CGFloat(row + 2) * 20
                    return height
                }
            }else {
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    lazy var propmtLabel: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("4d4d4d")
        label.backgroundColor = UIColor.colorWithHexStringSwift("dadada")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.center
        label.text = DDLanguageManager.text("addShopOneStepsub")
        return label
    }()
    lazy var propmtTwoLabel: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        
        label.textColor = UIColor.colorWithHexStringSwift("fe5f5f")
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.text = "上传图片，支持png、JPG、最大每张10M"
        return label
    }()
    
    
    
    lazy var addShopBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("next"), for: UIControlState.normal)
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
    

}
