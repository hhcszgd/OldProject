//
//  SettingVC.swift
//  zjlao
//
//  Created by WY on 16/10/16.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

import SDWebImage


class SettingVC: VCWithNaviBar {

//    let tableView = BaseTableView.init(frame: <#T##CGRect#>, style: <#T##UITableViewStyle#>)

    let topComtaier = UIView()
    let switchButton = UISwitch()
    let loginOutButton = UIButton()
    let setaddress : RowView = RowView.init(frame: CGRect(x: 0, y: 66, width: screenW, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.backGray()
        self.attritNavTitle = NSAttributedString.init(string: "设置")
        setaddress.titleLabel.text = "设置发货地址"
        setaddress.imageView.image = UIImage(named: "icon_The receipt")
        setaddress.addTarget(self, action: #selector(setaddressBtnClick), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(setaddress)
        self.view.addSubview(self.topComtaier)
        self.view.addSubview(self.loginOutButton)
//        self.topComtaier.backgroundColor = UIColor.randomColor()
        
        self.setupSubView()
        self.setupOtherSubView()
        // Do any additional setup after loading the view.
    }
    func setaddressBtnClick()  {
        let model : ProfileChannelModel = ProfileChannelModel(dict: ["actionkey" : "addressmanage" as AnyObject , "keyparamete" : "https://m.zjlao.\(domainSuffix)/SellerOrder/dizhi.html?aaa=nottaken" as AnyObject])
        SkipManager.skip(viewController: self, model: model)
    }
    func setupSubView() {
        for subView in self.topComtaier.subviews {
            subView.removeFromSuperview()
        }
        let lines : NSInteger = 1
        let lineH : CGFloat  = 44.0
        let margin : CGFloat = 5.0
        self.topComtaier.frame = CGRect(x: 0, y: 64 + setaddress.bounds.size.height + margin, width: screenW, height: (lineH+margin) * CGFloat(lines) )
        
        for index in 0 ..< lines {
            let rowView = RowView.init(frame: CGRect(x: 0, y: (lineH+margin)*CGFloat(index), width: screenW, height: lineH))
            rowView.titleLabel.font = UIFont.systemFont(ofSize: 12*SCALE)
            self.topComtaier.addSubview(rowView)
            switch index {
            case 0://消息通知
//                self.switchButton.center = CGPoint(x: screenW - 10 - self.switchButton.bounds.width, y: (rowView.bounds.size.height - self.switchButton.bounds.size.height ) * 0.5)//自定义控件缺陷,center 无效 , 只能用frame
                self.switchButton.frame = CGRect(x: screenW - 10 - self.switchButton.bounds.size.width, y: (rowView.bounds.size.height - self.switchButton.bounds.size.height)*0.5, width: self.switchButton.bounds.size.width, height: self.switchButton.bounds.size.height)
                rowView.diyView = self.switchButton
                self.switchButton.addTarget(self, action: #selector(changeNoticeCustomSound(sender:)), for: UIControlEvents.valueChanged)
                self.switchButton.isOn = UserDefaults.standard.bool(forKey: "SoundEnable")
                rowView.titleLabel.text = "消息通知提示"
                rowView.additionalImageView.isHidden = true
                break
            case 1://图片质量选择 
                
                rowView.addTarget(self, action: #selector(changeImageQuality(sender : )), for: UIControlEvents.touchUpInside)
                rowView.titleLabel.text = "图片质量"
                rowView.subTitleLabel.text = "智能模式"
                
                break
            case 2://清除缓存
                
                 rowView.addTarget(self, action: #selector(clearCache(sender : )), for: UIControlEvents.touchUpInside)
                 rowView.titleLabel.text = "清除缓存"
                 rowView.additionalImageView.isHidden = true
                 
                 DispatchQueue.global(qos: .userInitiated).async {
                    //your code here
                    DispatchQueue.main.async { [weak self] in
                        rowView.subTitleLabel.text = "\(SDImageCache.shared().getSize()/1024/1024) MB"
                        
                    }
                 }
                break
            case 3://评分
                 rowView.addTarget(self, action: #selector(valuation(sender : )), for: UIControlEvents.touchUpInside)
                rowView.titleLabel.text = "给我们评分"
                
                break
            case 4://评分
                rowView.addTarget(self, action: #selector(performChangeLanguage(sender : )), for: UIControlEvents.touchUpInside)
                rowView.titleLabel.text = "更改语言"
                
                break
            default:
                
                break
            }
        }
    }
    func setupOtherSubView()  {
        let versionCodeLabel = UILabel()
        versionCodeLabel.font = UIFont.systemFont(ofSize: 12*SCALE)
        versionCodeLabel.textColor = SubTitleColor
        self.view.addSubview(versionCodeLabel)
        mylog(Bundle.main.localizedInfoDictionary)
        mylog(Bundle.main.infoDictionary)
        if let versionCodeStr = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        
            versionCodeLabel.text = "当前版本号为 : \(versionCodeStr)"
        }
        versionCodeLabel.sizeToFit()
        versionCodeLabel.center = CGPoint(x: screenW/2, y: self.topComtaier.frame.maxY+14)
        
        self.loginOutButton.backgroundColor = UIColor.red
        let w : CGFloat = screenW - 40
        let h : CGFloat = 48.0
        let x : CGFloat = (screenW - w) / 2
        let y : CGFloat = screenH - 22.0 - h
        self.loginOutButton.frame = CGRect(x: x, y: y, width: w, height: h)
        self.loginOutButton.setTitle("退出登录", for: UIControlState.normal)
        self.loginOutButton.embellishView(redius: 5)
        self.loginOutButton.addTarget(self , action: #selector(performLoginOut), for: UIControlEvents.touchUpInside)
        
    }
    func performLoginOut() {
        mylog("退出登录")
        if Account.shareAccount.isLogin {
            NetworkManager.shareManager.loginOut({ (result) in
                mylog(result.description)

                GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
//                     _ = self.navigationController?.popViewController(animated: true)
                    let loginVC = LoginVC(vcType: VCType.withoutBackButton)
                    //                    loginVC.loginDelegate = self
                    let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
                    loginNaviVC.navigationBar.isHidden = true
                    self.present(loginNaviVC, animated: true, completion: nil)
                })

            }) { (error) in
                
                GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
//                    _ = self.navigationController?.popViewController(animated: true)
                    let loginVC = LoginVC(vcType: VCType.withBackButton)
//                    loginVC.loginDelegate = self
                    let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
                    loginNaviVC.navigationBar.isHidden = true
                    self.present(loginNaviVC, animated: true, completion: nil)

                })

                mylog(error)
            }
        }else{
            GDAlertView.alert("未 登 录", image: nil, time: 2, complateBlock: nil)
        }
        
    }

    
    func valuation(sender : RowView){
        mylog("评分")
        let urlStr = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1133780608"
        let url = URL(string: urlStr)
        guard let  realUrl = url  else {
            return
        }
        if UIApplication.shared.canOpenURL(realUrl) {
            UIApplication.shared.openURL(realUrl)
        }
        
    }
    func clearCache(sender : RowView){
        mylog("清除缓存")
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().cleanDisk()
        GDAlertView.alert("清除成功", image: nil, time: 2, complateBlock: nil)
        sender.subTitleLabel.text = "0 MB"
    }
    func changeImageQuality(sender : RowView){
        mylog("改变图片质量")
    }
    func changeNoticeCustomSound(sender : UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: "SoundEnable")
        mylog("改变声音")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func performChangeLanguage(sender : RowView){
        mylog("更改语言")
        let chooseLanguageVCModel = BaseModel(dict: nil)
        chooseLanguageVCModel.actionkey = "ChooseLuanguageVC"
        SkipManager.skip(viewController: self, model: chooseLanguageVCModel)
        
        
    }

//    let languagesArr = ["english","chinese","japanese"]
//    lazy var languagePicker = UIPickerView()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
