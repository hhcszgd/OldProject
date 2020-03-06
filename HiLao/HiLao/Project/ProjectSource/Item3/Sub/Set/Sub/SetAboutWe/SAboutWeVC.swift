//
//  SAboutWeVC.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/3.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit

class SAboutWeVC: GDNormalVC {
    let viewModel = SetViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: setAboutWe)
        let image = UIImage.init(named: "logo")
        let width = image?.size.width ?? 100
        let height = image?.size.height ?? 100
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DDNavigationBarHeight + 65)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        self.logoImageView.image = image
        self.interduce.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.version.snp.makeConstraints { (make) in
            make.top.equalTo(self.interduce.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        
        self.companyProtol.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10 - TabBarHeight)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        self.company.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.companyProtol.snp.top).offset(-10)
        }
        
        
        
        
        
        self.version.text = "嗨捞V" + viewModel.getVersion()
        
        self.interduce.text = "啊放假发发发就；；安居客路附近啊"
        
        self.company.text = "北京一路捞互联网有限公司"
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func jump() {
        
    }
    
    

    lazy var logoImageView: UIImageView = {
        let image = UIImageView.init()
        self.view.addSubview(image)
        return image
    }()
    lazy var version: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("8c8c8c")
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    lazy var interduce: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("8c8c8c")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        return label
    }()
    
    lazy var company: UILabel = {
        let label = UILabel.init()
        self.view.addSubview(label)
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    lazy var companyProtol: UIButton = {
        let btn = UIButton.init()
        self.view.addSubview(btn)
        btn.setTitle("嗨捞相关协议", for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("fe5f4f"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(jump), for: .touchUpInside)
        return btn
    }()
    
    
    
    
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
