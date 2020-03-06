//
//  SubOrderListVC.swift
//  zjlao
//
//  Created by WY on 16/12/23.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit
import MJRefresh
class SubOrderListVC: BaseWebVC {
    var  originUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstLoadWeb(urlStr: originUrl)
        // Do any additional setup after loading the view.
        self.webView.scrollView.mj_header = GDRefreshHeader(refreshingTarget: self, refreshingAction: #selector(setrefresh))
    }
    func setrefresh () {
        self.webView.reload()
        //@property (assign, nonatomic) MJRefreshState state;
        
        self.webView.scrollView.mj_header.state = MJRefreshState.idle ;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func firstLoadWeb(urlStr : String) {
        if let token = NetworkManager.shareManager.token {
            
           // let urlStr = "https://m.zjlao.com/SellerOrder/orderlist.html"
            let urlStrAppendToken  = urlStr.appending("?token=\(token)")
            mylog(urlStrAppendToken)
            if  urlStrAppendToken.hasPrefix("https://") ||  urlStrAppendToken.hasPrefix("http://") ||  urlStrAppendToken.hasPrefix("www.") {
                guard let url  = URL.init(string: urlStrAppendToken ) else {
                    mylog("webViewController的urlStr字符串转换成URL失败")
                    return
                }
                let urlRequest = URLRequest.init(url: url)
                self.webView.load(urlRequest)
            }
        }else{//拼接http://
            self.webView.reload()
        }
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
