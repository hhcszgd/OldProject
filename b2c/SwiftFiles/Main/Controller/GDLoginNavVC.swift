//
//  GDLoginNavVC.swift
//  zjlao
//
//  Created by WY on 17/1/15.
//  Copyright © 2017年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDLoginNavVC: UINavigationController {

    
    /// 自定义便利构造方法
    ///
    /// - Parameter rootVC: 跟控制器 , 可为空
    convenience init(rootVC: UIViewController?) {
        if rootVC == nil   {
            
            let loginvc = GDLoginVC.init()
            self.init(rootViewController: loginvc)
        }else {
            self.init(rootViewController: rootVC!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        mylog("登录页面销毁")
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
