//
//  ClassifyNaviVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ClassifyNaviVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = UIImage(named: "messageNormal")
        self.tabBarItem.selectedImage = UIImage(named: "messageSelect")

//        self.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
//        self.tabBarItem.title = "classify"
//        self.tabBarItem.title = NSLocalizedString("tabBar_classify", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "")
        self.tabBarItem.title =  GDLanguageManager.titleByKey(key: "tabBar_message") // gotTitleStr(key: "tabBar_classify")
//        self.tabBarItem.badgeValue = ""
        self.navigationBar.isHidden = true;
//        NotificationCenter.default.addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
        NotificationCenter.default.addObserver(self , selector: #selector(messageIsComming), name: NSNotification.Name(rawValue: "MESSAGECOUNTCHANGED"), object: nil)
        // Do any additional setup after loading the view.
    }
    func messageIsComming() {
        //回到主线程
        DispatchQueue.main.async {
            self.tabBarItem.badgeValue = ""
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarItem.badgeValue = nil 

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
