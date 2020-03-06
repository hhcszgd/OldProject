//
//  SetUpShopThreeVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/23.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class SetUpShopThreeVC: GDNormalVC {

 
    
    @IBOutlet var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upConstraint()
        
   
        // Do any additional setup after loading the view.
    }
    ///更新约束
    @IBOutlet var scrollTop: NSLayoutConstraint!
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    func upConstraint() {
        self.scrollTop.constant = DDNavigationBarHeight + 38
        self.scrollBottom.constant = TabBarHeight + 10
        let bottomView = UIView.init()
        self.view.addSubview(bottomView)
        self.propmtLabel.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 38)
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "addShopThree")
        
        
        bottomView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - TabBarHeight - 50, width: SCREENWIDTH, height: 50)
        bottomView.backgroundColor = UIColor.white
        bottomView.addSubview(self.submitBtn)
        self.submitBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        self.view.layoutIfNeeded()
        
        
        
    }
    
    
    override func gdAddSubViews() {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    
        let vc = SelectBusinessDay.init(nibName: "SelectBusinessDay", bundle: Bundle.main)
        self.present(vc, animated: true, completion: nil)
        
    }
    @objc func submitAction(btn: UIButton) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var submitBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("submit"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(submitAction(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
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
