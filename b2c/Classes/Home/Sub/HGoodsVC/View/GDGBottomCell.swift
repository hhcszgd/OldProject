//
//  GDGBottomCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//
let MAINDOMAIN = "https://www.zjlao.com"
let WAPDOMAIN = "https://m.zjlao.com"
let APIDOMAIN = "https://api.zjlao.com"
let IMGDOMAIN = "https://i0.zjlao.com"
import UIKit
import WebKit
class GDGBottomCell: GDGoodsBaseCell, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {
    let webView: WKWebView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration.init())

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isFirst = true
        self.configmentUI()
    }
    
    var isFirst: Bool = false
    
    func configmentUI() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(self.webView)
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.scrollView.delegate = self
        self.webView.configuration.preferences.javaScriptEnabled = true
        self.webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
//        传值的关键 , 释放的时候记得移除
        self.webView.configuration.userContentController.add(self, name: "zjlao")
        self.webView.frame = CGRect.init(x: 0, y: 0, width: screenW, height: self.bounds.size.height)
        
        
    }
    
    override var goods_id: String? {
        didSet{
            if self.isFirst {
                self.isFirst = false
                
                let urlStr: String = String.init(format: "%@/AppOrder/goodsdetails.html?token=%@&id=%@&phone=ios", WAPDOMAIN,UserInfo.share().token, goods_id!)
                let url = URL.init(string: urlStr)
                let request: URLRequest = URLRequest.init(url: url!)
                self.webView.load(request)
            }
        }
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        print(message.name)
        self.analysisTheDateFromJS(message: message)
    }
    func analysisTheDateFromJS(message: WKScriptMessage) {
        if message.name == "zjlao" {
            if let bodyDic = message.body as? [String: AnyObject] {
                if let action = bodyDic["action"] as? String  {
                    switch action {
                    case "alert":
                        self.performAlertWith(body: message.body)
                        break
                    case "confirm":
                        self.performConfirmWith(body: message.body)
                        break
                    case "jump":
                        self.performJumpWith(body: message.body)
                        break
                    case "pay":
                        self.performPayWith(body: message.body)
                        break
                    case "share":
                        self.performShareWith(body: message.body)
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    func performAlertWith(body: Any) {
        
    }
    func performConfirmWith(body: Any) {
        
    }
    func performJumpWith(body: Any) {
        if let dict = body as? [String: AnyObject] {
            if let type = dict["type"] as? String {
                switch type {
                case "goods":
                    let model = GDBaseModel.init(dict: nil)
                    model.actionkey = "HGoodVC"
                    
                    if let g_id = dict["id"] as? NSInteger {
                        model.keyparamete = ["paramete": String.init(format: "%d", g_id)] as AnyObject
                        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "goodsJump" as Any]
                        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
                        return
                    }
                    
                    if let g_id = dict["id"] as? String {
                        model.keyparamete = ["paramete": String.init(format: "%@", g_id)] as AnyObject
                        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "goodsJump" as Any]
                        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
                    }
                    
                    break
                default:
                    break
                }
            }
        }
    }
    func performPayWith(body: Any) {
        
    }
    func performShareWith(body: Any) {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.webView.scrollView.contentOffset.y < -50 * scale {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SCROLLUPORDOWN"), object: nil, userInfo: [AnyHashable("upordown"): "toup" as Any])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
