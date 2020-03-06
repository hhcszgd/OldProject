//
//  SetUpShopOne.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class SetUpShopOne: GDNormalVC {
    let uploadImage = UploadPicturesTool()
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.viewController = self
        self.tableView.backgroundColor = UIColor.white
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "addShopOneStep")
        self.naviBar.isHidden = false
        self.setUI()
        
        
        let model = OpenShopModel.init()
        self.dataArr = model.getOneModel()
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    var dataArr: [OpenShopModel] = [OpenShopModel]()
    func setUI() {
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight + 38, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar - 38 - 50)
       
        self.tableView.register(UINib.init(nibName: "OpenShopOneStepCell", bundle: Bundle.main), forCellReuseIdentifier: "OpenShopOneStepCell")

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
        let paramete = ["token": account.token, "member_id": memberid, "id_image": idImage, "business_licence_image": businessImage, "qualification_image": model3.image ?? ""] as [String: Any]
        NetWork.manager.requestData(router: Router.post("addshopexamineone", .shopShopExamine, paramete)).subscribe(onNext: { [weak self](dict) in
            let model = BaseModel<GDModel>.deserialize(from: dict)
            if model?.status == 1201{
                mylog("提交成功")
                guard let data = dict["data"] as? [String: String], let shopID = data["shopexamine_id"] else {
                    return
                }
                let model = GDModel.init()
                model.keyParameter = shopID
                let vc = SetUpShopTwoVC()
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
        
        return self.dataArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenShopOneStepCell", for: indexPath) as! OpenShopOneStepCell
        cell.model = model
        cell.addImage = {[unowned self] (model) in
            self.uploadImage.model = model
            self.uploadImage.changeHeadPortrait()
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataArr[indexPath.row]
        let leftWidth: CGFloat = SCREENWIDTH - (15 + 15 + 8 + 130 + 10)
        let detailHeight: CGFloat = (model.detail ?? "").sizeWith(font: UIFont.systemFont(ofSize: 15), maxWidth: leftWidth).height
        let height: CGFloat = 10 + 15 + 10 + detailHeight + 10 + 27 + 5
        let subheight: CGFloat = 100
        return height > subheight ? height : subheight
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
