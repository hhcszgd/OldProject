//
//  OrderListVC.swift
//  zjlao
//
//  Created by WY on 16/11/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit
import WebKit
import MJRefresh


class OrderListVC: BaseWebVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.backgroundColor  = UIColor.white
        self.naviBar.backBtn.isHidden = true
        self.webView.frame = CGRect(x: 0, y: 64, width: screenW, height: screenH - 64 - (self.tabBarController?.tabBar.bounds.size.height ?? 44.0))
        //        NSLocalizedString(<#T##key: String##String#>, comment: <#T##String#>)//默认加载Localizable
        //        NSLocalizedString(<#T##key: String##String#>, tableName: <#T##String?#>, bundle: <#T##Bundle#>, value: <#T##String#>, comment: <#T##String#>)
        
        //        self.title = NSLocalizedString("tabBar_home", tableName: nil, bundle: Bundle.main, value:"", comment: "")

        let rightBtn1 = UIButton(type: UIButtonType.custom)
//        rightBtn1.backgroundColor = UIColor.backGray()
        rightBtn1.setImage(UIImage(named:"icon_set up"), for: UIControlState.normal)
//        rightBtn1.setTitle("title", for: UIControlState.normal)
        rightBtn1.addTarget(self, action: #selector(settingBtnClick), for: UIControlEvents.touchUpInside)
        naviBar.rightBarButtons = [rightBtn1]
//        let navTitleView = NavTitleView()
//        navTitleView.backgroundColor = UIColor.randomColor()
//        navTitleView.insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10);
//        naviBar.navTitleView = navTitleView
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessCallBack), name: NSNotification.Name("LoginSuccess"), object: nil)
        // Do any additional setup after loading the view.
        self.webView.scrollView.mj_header = GDRefreshHeader(refreshingTarget: self, refreshingAction: #selector(setrefresh))
        NotificationCenter.default.addObserver(self , selector: #selector(tabbarItemReclick), name: GDHomeTabBarReclick, object: nil)
    }
    func tabbarItemReclick()  {
        self.webView.scrollView.mj_header.state = MJRefreshState.refreshing
    }
    func setrefresh () {
//         var url = self.webView.url
//        url?.appendPathComponent(<#T##pathComponent: String##String#>)
//        url?.appendingPathComponent(<#T##pathComponent: String##String#>)
        self.webView.reload()
        //@property (assign, nonatomic) MJRefreshState state;

        self.webView.scrollView.mj_header.state = MJRefreshState.idle ;
    }
    func settingBtnClick()  {
        let model : ProfileChannelModel = ProfileChannelModel(dict: ["actionkey" : "set" as AnyObject])
        SkipManager.skip(viewController: self, model: model)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        KeyVC.share.mainTabbarVC?.tabBar.items?.first?.badgeValue = nil
//        self.webView.reload()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let token = NetworkManager.shareManager.token {
//            
//            let urlStr = "https://m.zjlao.com/SellerOrder/orderlist.html"
//            let urlStrAppendToken  = urlStr.appending("?token=\(token)")
//            mylog(urlStrAppendToken)
//            if  urlStrAppendToken.hasPrefix("https://") {
//                guard let url  = URL.init(string: urlStrAppendToken ) else {
//                    mylog("webViewController的urlStr字符串转换成URL失败")
//                    return
//                }
//                let urlRequest = URLRequest.init(url: url)
//                self.webView.load(urlRequest)
//            }
//        }else{//拼接http://
//            self.webView.reload()
//        }
//实现错误方法
    }
    func loginSuccessCallBack() {
        self.layoutsubviews()
        self.webView.scrollView.mj_header = GDRefreshHeader(refreshingTarget: self, refreshingAction: #selector(setrefresh))
        NotificationCenter.default.addObserver(self , selector: #selector(tabbarItemReclick), name: GDHomeTabBarReclick, object: nil)
        /*
        if let token = NetworkManager.shareManager.token {
            if token == "nil" {
                mylog("token为空")
                return;
            }
            let   count :  Int = self.webView.backForwardList.backList.count
            if count > 0  {
                let   item :  WKBackForwardListItem = self.webView.backForwardList.backList[count - 1 ]
                self.webView.go(to: item)
            }
//            else{
//                self.webView.reload()
                //"https://m.zjlao.\(domainSuffix)/SellerOrder/orderlist.html"
                let urlStr = "https://m.zjlao.\(domainSuffix)/SellerOrder/orderlist.html"
                    var  urlStrAppendToken  =  ""
                    if urlStr.contains("?") {
                        urlStrAppendToken =  urlStr.appending("&token=\(token)")
                    }else{
                        
                        urlStrAppendToken =  urlStr.appending("?token=\(token)")
                        
                    }
                    
                    
                    mylog(urlStrAppendToken)
                    if  urlStrAppendToken.hasPrefix("http") {
                        guard let url  = URL.init(string: urlStrAppendToken ) else {
                            mylog("webViewController的urlStr字符串转换成URL失败")
                            return
                        }
                        
                        let urlRequest = URLRequest.init(url: url)
                        self.webView.load(urlRequest)
                        
                    }else{//拼接http://
                        
                    }
//            }
            
            /*
            let urlStr = "https://m.zjlao.com/SellerOrder/orderlist.html"
            let urlStrAppendToken  = urlStr.appending("?token=\(token)")
            mylog(urlStrAppendToken)
            if  urlStrAppendToken.hasPrefix("https://") || urlStrAppendToken.hasPrefix("http://") {
                guard let url  = URL.init(string: urlStrAppendToken ) else {
                    mylog("webViewController的urlStr字符串转换成URL失败")
                    return
                }
                let urlRequest = URLRequest.init(url: url)
                self.webView.load(urlRequest)
            }else{//拼接http://
                self.webView.reload()
            }*/
        }else{//token为空
            mylog("token为空")
        }
        */
    }
//    override func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
//        mylog("前进后退列表对象\(self.webView.backForwardList)")
//        mylog("当前item\(self.webView.backForwardList.currentItem)")
//        mylog("返回列表\(self.webView.backForwardList.backList)")
//        mylog("上一个item\(self.webView.backForwardList.backItem)")
//        mylog("前进列表\(self.webView.backForwardList.forwardList)")
//        mylog("下一个item\(self.webView.backForwardList.forwardItem)")
//        if self.webView.backForwardList.backList.count > 0 {
//            if self.webView.backForwardList.currentItem == self.webView.backForwardList.backList[0] {
//                self.naviBar.isHidden = true
//            }else{
//                self.naviBar.isHidden = false
//            }
//            
//        }else{
////            self.naviBar.isHidden = true
//        }
//    }
    
    
   override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
    super.webView(webView, didFinish: navigation)
    KeyVC.share.mainTabbarVC?.tabBar.items?.first?.badgeValue = nil
    mylog("\n\n\n\n\(self.webView.backForwardList.currentItem?.url.absoluteString)\n\n\n\n")
    mylog("前进后退列表对象\(self.webView.backForwardList)")
    mylog("当前item\(self.webView.backForwardList.currentItem)")
    mylog("返回列表\(self.webView.backForwardList.backList)")
    mylog("上一个item\(self.webView.backForwardList.backItem)")
    mylog("前进列表\(self.webView.backForwardList.forwardList)")
    mylog("下一个item\(self.webView.backForwardList.forwardItem)")
    if self.webView.backForwardList.backList.count == 0 {//只有一个网页
        self.naviBar.backBtn.isHidden = true
    }else if (self.webView.backForwardList.backList.count > 0   ){
        self.naviBar.backBtn.isHidden = false
    }
//
//    self.naviBar.backBtn.isHidden = webView.backForwardList.currentItem?.url.absoluteString.contains("orderlist.html") ?? false
    }
    
    
    /*! @abstract Invoked when an error occurs during a committed main frame
     navigation.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     @param error The error that occurred.
     @available(iOS 8.0, *)
     */
   override func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
    super.webView(webView, didFail: navigation, withError: error)
    KeyVC.share.mainTabbarVC?.tabBar.items?.first?.badgeValue = nil
    if self.webView.backForwardList.backList.count == 0 {//只有一个网页
        self.naviBar.backBtn.isHidden = true
    }else if (self.webView.backForwardList.backList.count > 0   ){
        self.naviBar.backBtn.isHidden = false
    }
//    self.naviBar.backBtn.isHidden = webView.backForwardList.currentItem?.url.absoluteString.contains("orderlist.html") ?? false
//    webView.reload()

    
    mylog("前进后退列表对象\(self.webView.backForwardList)")
    mylog("当前item\(self.webView.backForwardList.currentItem)")
    mylog("返回列表\(self.webView.backForwardList.backList)")
    mylog("上一个item\(self.webView.backForwardList.backItem)")
    mylog("前进列表\(self.webView.backForwardList.forwardList)")
    mylog("下一个item\(self.webView.backForwardList.forwardItem)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:返回上一页
    override func popToPreviousVC (){
        mylog("\n\n\n\n当前url\(self.webView.url?.absoluteString)\n\n")
        self.webView.stopLoading()
        if (self.webView.canGoBack) {
            self.naviBar.backBtn.isHidden = false
            let count : Int = self.webView.backForwardList.backList.count
            for i in 0  ..< count {
                let   item :  WKBackForwardListItem = self.webView.backForwardList.backList[count - 1 - i]
                
                if (item.url.absoluteString.contains("nottaken")) {
                    mylog("\n遍历到当前url\(item.url.absoluteString)\n跳过\n\n\n")
                    if (i==count-1) {//如果栈底的还不需要在返回的时候显示,就直接pop到上一个控制器
                        self.webView.configuration.userContentController.removeScriptMessageHandler(forName: "zjlao")
                        _ =  self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.webView.go(to: item)
                     mylog("\n遍历到当前url\(item.url.absoluteString)\n展示\n\n\n")
//                    self.webView.goBack()
                    if (item.url.absoluteString.contains("orderlist")) {//待评价页面返回时需要重新加载
//                        self.webView.reload()//在卖家版中先不在这里刷新(刷新没法回退了)
                        let deadline  =  DispatchTime.now() + 0.5  ;
                        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                            self.webView.reload()//在卖家版中先不在这里刷新(刷新没法回退了)
                        });
                    }
                    break
                }
            }
            
//            self.webView.reload()
        }else{
//            self.webView.reload()
//            if self.webView.backForwardList.forwardList.count > 0 {
//                
//                let   item :  WKBackForwardListItem = self.webView.backForwardList.backList[0]
//                self.webView.go(to: item)
//            }
            
            self.naviBar.backBtn.isHidden = true
//            self.webView.configuration.userContentController.removeScriptMessageHandler(forName: "zjlao")
//            _ =  self.navigationController?.popViewController(animated: true)
            
        }
    }


}

/*
 NSURLComponents * components = [NSURLComponents componentsWithString:webpageURL.absoluteString];
 NSArray * queryItems =  components.queryItems;
 NSString * actionkey =  nil ;
 NSString * ID = nil ;
 for (NSURLQueryItem * item  in queryItems) {
 if ([item.name isEqualToString:@"actionkey"]) {
 if ([item.value isEqualToString:@"shop"]) {
 actionkey = @"HShopVC";
 
 */
