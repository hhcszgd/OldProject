//
//  ClassifyVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ClassifyVC: VCWithNaviBar {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBtn1 = UIButton(type: UIButtonType.custom)
        rightBtn1.backgroundColor = UIColor.backGray()
        rightBtn1.setImage(UIImage(named:"icon_set up"), for: UIControlState.normal)
        //        rightBtn1.setTitle("title", for: UIControlState.normal)
        rightBtn1.addTarget(self, action: #selector(settingBtnClick), for: UIControlEvents.touchUpInside)

//        self.view.backgroundColor = UIColor.yellow
//        self.title = NSLocalizedString("tabBar_classify", tableName: nil, bundle: Bundle.main, value:"", comment: "")
//        UIColor(hexString: "#ffe700ff")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func settingBtnClick()  {
        let model : ProfileChannelModel = ProfileChannelModel(dict: ["actionkey" : "set" as AnyObject])
        SkipManager.skip(viewController: self, model: model)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showErrorView()
        /**    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:"]];*/
//        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString) ?? URL(string: "http://www.baidu.com")! )
//        UIApplication.shared.openURL(URL(string: "appsetting") ?? URL(string: "http://www.baidu.com")! )
//        (UIApplication.shared.delegate as? AppDelegate)?.performChangeLanguage(targetLanguage: "LocalizableCH")//更改语言
//        URL(UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    override func errorViewClick() {
        self.hiddenErrorView()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.pushViewController(VCWithNaviBar.init(vcType: VCType.withBackButton), animated: true)
//    }

}
