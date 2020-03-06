//
//  BusinessVC.swift
//  Project
//
//  Created by 张凯强 on 2017/11/22.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class BusinessVC: GDNormalVC {

    let viewModel = BusinessViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "businsess")
        self.naviBar.isHidden = false
        self.setUI()
        viewModel.getShopList()
        
        self.viewModel.shopListItems.asObservable().subscribe(onNext: { [weak self](dataArr) in
            self?.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        // Do any additional setup after loading the view.
    }
    func setUI() {
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar - 49)
        self.tableView.register(BusinessCell.self, forCellReuseIdentifier: "BusinessCell")
        self.tableView.register(UINib.init(nibName: "BusinessCell", bundle: Bundle.main), forCellReuseIdentifier: "BusinessCell")
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
        let vc = OpenShopVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.shopListItems.value.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.shopListItems.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath)
         as! BusinessCell
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
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
        return 0.001
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    lazy var addShopBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("addBusiness"), for: UIControlState.normal)
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
