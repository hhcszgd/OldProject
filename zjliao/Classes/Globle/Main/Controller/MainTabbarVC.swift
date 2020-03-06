//
//  MainTabbarVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit
import XMPPFramework
class MainTabbarVC: UITabBarController {
    let mainTabbar  =  MainTabbar.share
    override func viewDidLoad() {
        super.viewDidLoad()
       // mainTabbar.delegate = self
        setValue(mainTabbar, forKey: "tabBar")
        self.addchileVC()
    }
    
    override  var selectedIndex: Int  {
        set {
            super.selectedIndex = newValue
        }
        get{
            return super.selectedIndex
        }
        
    }
    func addchileVC() -> () {
        for subVC in self.childViewControllers {
            subVC.removeFromParentViewController()
        }
        let orderVC = OrderListVC(vcType: VCType.withBackButton)
        orderVC.keyModel = BaseModel(dict: ["actionkey" : "addressmanage" as AnyObject , "keyparamete" : "https://m.zjlao.\(domainSuffix)/SellerOrder/orderlist.html" as AnyObject])
        self.addChildViewController(HomeVaviVC(rootViewController: orderVC))
        self.addChildViewController(ClassifyNaviVC(rootViewController: FriendListVC()))
//        self.addChildViewController(HomeVaviVC(rootViewController: HomeVC()))
//        self.addChildViewController(ClassifyNaviVC(rootViewController: ClassifyVC()))
//        self.addChildViewController(LaoNaviVC(rootViewController: LaoVC()))
//        self.addChildViewController(ShopCarNaviVC(rootViewController: ShopCarVC()))
//        self.addChildViewController(ProfileNaviVC(rootViewController: ProfileVC()))
        mylog(self.childViewControllers)
    }
    
    func restartAfterChangeLanguage() {
        self.setViewControllers([OrderListVC(vcType: VCType.withBackButton),ClassifyNaviVC(rootViewController: FriendListVC())], animated: true)
    }
    
    //     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
    //        return true
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  !(GDXmppStreamManager.shareXMPP().xmppStream.isConnected() || GDXmppStreamManager.shareXMPP().xmppStream.isConnecting()) && Account.shareAccount.isLogin  {
            GDXmppStreamManager.shareXMPP().login(with:XMPPJID.init(string:  Account.shareAccount.name), passWord: NetworkManager.shareManager.token);
        }
//        if !Account.shareAccount.isLogin {
//            let loginVC = LoginVC(vcType: VCType.withBackButton)
//            let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
//            loginNaviVC.navigationBar.isHidden = true
//            self.present(loginNaviVC, animated: true, completion: nil)
//        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !Account.shareAccount.isLogin {
            let loginVC = LoginVC(vcType: VCType.withoutBackButton)
            let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
            loginNaviVC.navigationBar.isHidden = true
            self.present(loginNaviVC, animated: false, completion: nil)
        }
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







////
////  MainTabbarVC.swift
////  mh824appWithSwift
////
////  Created by wangyuanfei on 16/8/24.
////  Copyright © 2016年 www.16lao.com. All rights reserved.
////
//
//import UIKit
//import XMPPFramework
//class MainTabbarVC: UITabBarController {
//    let mainTabbar  =  MainTabbar()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mainTabbar.delegate = self
//        setValue(mainTabbar, forKey: "tabBar")
//        self.addchileVC()
//    }
//    
//    override  var selectedIndex: Int  {
//        set {
//            super.selectedIndex = newValue
//        }
//        get{
//            return super.selectedIndex
//        }
//    
//    }
//    func addchileVC() -> () {
//
//        self.addChildViewController(HomeVaviVC(rootViewController: HomeVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(ClassifyNaviVC(rootViewController: ClassifyVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(LaoNaviVC(rootViewController: LaoVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(ShopCarNaviVC(rootViewController: ShopCarVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(ProfileNaviVC(rootViewController: ProfileVC()))
//        
//        let orderVC = OrderListVC(vcType: VCType.withBackButton)
//        orderVC.keyModel = BaseModel(dict: ["actionkey" : "addressmanage" as AnyObject , "keyparamete" : "https://m.zjlao.com/SellerOrder/orderlist.html" as AnyObject])
//        
//        self.addChildViewController(HomeVaviVC(rootViewController: orderVC))
//        self.addChildViewController(ClassifyNaviVC(rootViewController: FriendListVC()))
//        self.addChildViewController(LaoNaviVC(rootViewController: LaoVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(ShopCarNaviVC(rootViewController: ShopCarVC(vcType: VCType.withoutBackButton)))
//        self.addChildViewController(ProfileNaviVC(rootViewController: ProfileVC()))
//        
//    }
//
//    
//    
////     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
////        return true
////    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if  !(GDXmppStreamManager.shareXMPP().xmppStream.isConnected() || GDXmppStreamManager.shareXMPP().xmppStream.isConnecting()) && Account.shareAccount.isLogin  {
//            GDXmppStreamManager.shareXMPP().login(with:XMPPJID.init(string:  Account.shareAccount.name), passWord: NetworkManager.shareManager.token);
//        }
////        if !Account.shareAccount.isLogin {
////            let loginVC = LoginVC(vcType: VCType.withBackButton)
////            let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
////            loginNaviVC.navigationBar.isHidden = true
////            self.present(loginNaviVC, animated: true, completion: nil)
////        }
//        
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if !Account.shareAccount.isLogin {
//            let loginVC = LoginVC(vcType: VCType.withoutBackButton)
//            let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
//            loginNaviVC.navigationBar.isHidden = true
//            self.present(loginNaviVC, animated: false, completion: nil)
//        }
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
