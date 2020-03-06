//
//  GDMainTabbarVC.swift
//  zjlao
//
//  Created by WY on 17/1/15.
//  Copyright © 2017年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDMainTabbarVC: UITabBarController {

    let mainTabbar  =  GDTabBar.share
    override func viewDidLoad() {
        super.viewDidLoad()
        //mainTabbar.delegate = self
        self.setValue(mainTabbar, forKey: "tabBar")
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
//    override func setNilValueForKey(_ key: String) {
//        
//    }
    func addchileVC() -> () {
        
        for subVC in self.childViewControllers {
            subVC.removeFromParentViewController()
        }
        self.addChildViewController(HomeNavigationVC(rootViewController: HomeVC()))
        self.addChildViewController(ClassifyNavigationVC(rootViewController: ClassifyVC()))
        self.addChildViewController(LaoNavigationVC(rootViewController: TabBarLaoVC()))
        self.addChildViewController(ShopCarNavigationVC(rootViewController: ShopCarVC()))
        self.addChildViewController(ProfileNavigationVC(rootViewController: ProfileVC()))
        
        
        mylog(self.childViewControllers)
        
    }
    
    func resetUI ()  {
        self.setViewControllers([HomeNavigationVC(rootViewController: HomeVC()) ,
                                ClassifyNavigationVC(rootViewController: ClassifyVC()),
                                LaoNavigationVC(rootViewController: TabBarLaoVC()),
                                ShopCarNavigationVC(rootViewController: ShopCarVC()),
                                ProfileNavigationVC(rootViewController: ProfileVC())
            ], animated: false);
        //self.selectedIndex = 0//有没有必要跳到首页?

    }
    
    func restartAfterChangeLanguage() {
        self.setViewControllers([HomeNavigationVC(rootViewController: HomeVC()),ClassifyNavigationVC(rootViewController: ClassifyVC()),LaoNavigationVC(rootViewController: TabBarLaoVC()),ShopCarNavigationVC(rootViewController: ShopCarVC()),ProfileNavigationVC(rootViewController: ProfileVC())], animated: true)
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
        //mylog(self.tabBar)
        //let bar = self.tabBar
        //mylog(self.tabBar)
        
    }
    
}
