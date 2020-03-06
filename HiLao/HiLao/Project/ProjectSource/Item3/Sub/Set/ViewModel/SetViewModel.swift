//
//  SetViewModel.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/1.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import SDWebImage
let cleanCache = "cleanCache"
let noWIFIPicture = "noWIFIPicture"
let pushNotification = "pushNotification"
let checkVersion = "checkVersion"
let setAboutWe = "setAboutWe"
let setChangeLanguage = "setChangeLanguage"
let automaticTranslation = "automaticTranslation"
class SetViewModel: NSObject {
   
    
    
    
    func getData() {
        
        
        let clean = CustomDetailModel.configModel(action: "clean", leftImage: nil, leftTitle: DDLanguageManager.text(cleanCache), rightDetailTitle: gotCacheSize(), rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        let picture = CustomDetailModel.configModel(action: "picture", leftImage: nil, leftTitle: DDLanguageManager.text(noWIFIPicture) , rightDetailTitle: "智能", rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        let push = CustomDetailModel.configModel(action: "push", leftImage: nil, leftTitle: DDLanguageManager.text(pushNotification), rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: false)
        let version = CustomDetailModel.configModel(action: "version", leftImage: nil, leftTitle: DDLanguageManager.text(checkVersion), rightDetailTitle: getVersion(), rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        
        /////
        
        let aboutWe = CustomDetailModel.configModel(action: "aboutWe", leftImage: nil, leftTitle: DDLanguageManager.text(setAboutWe), rightDetailTitle: nil, rightImage: nil, arrowHidden: false, lineHidden: false, switchHidden: true)
        
        let changeLanguage = CustomDetailModel.configModel(action: "changeLanguage", leftImage: nil, leftTitle: DDLanguageManager.text(setChangeLanguage), rightDetailTitle: "简体中文", rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: true)
        
        let transloation = CustomDetailModel.configModel(action: "translate", leftImage: nil, leftTitle: "自动翻译", rightDetailTitle: nil, rightImage: nil, arrowHidden: true, lineHidden: false, switchHidden: false)
        
        topItems = [clean, picture, push, version]
        bottomItems = [aboutWe, changeLanguage, transloation]
        
        
    }
    
    ///获取磁盘缓存
    func gotCacheSize() -> String {
        let cache = SDImageCache.shared().getSize()
        let urlcache = URLCache.shared.currentDiskUsage
        let bytes = CGFloat(cache) + CGFloat(urlcache)
        let cachesize = CGFloat(bytes / 1024 / 1024)
        return String.init(format: "%0.2fM", cachesize)
        
    }
    ///清空磁盘缓存
    func cleanCacheAction() {
        SDImageCache.shared().clearDisk()
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().cleanDisk()
        URLCache.shared.removeAllCachedResponses()
    }
    ///获取版本信息
    func getVersion() -> String {
        if let infoDict = Bundle.main.infoDictionary {
            if let app_version = infoDict["CFBundleShortVersionString"] as? String {
                return app_version
            }
        }
        return "1.0"
    }
    
    ///获取用户有没有开启通知，开启继续操作。没有开启的话弹出提示框
    func isPush(action: () -> ()) {
        let isPush = UIApplication.shared.currentUserNotificationSettings?.types == UIUserNotificationType.init(rawValue: 0)
        if isPush {
            
        }
        
    }
    
    func dealSwitchClick(model: CustomDetailModel?, switchBtn: UISwitch, viewController: UIViewController) {
        
        let isPush = UIApplication.shared.currentUserNotificationSettings?.types == UIUserNotificationType.init(rawValue: 0)
        if isPush {
            switchBtn.isOn = false
            self.actionToPushSet(viewController: viewController)
        }else {
            //网络请求处理
            self.actionToPushSet(viewController: viewController)
        }
    }

    func actionToPushSet(viewController: UIViewController) {
        
        
        let alertVC = UIAlertController.init(title: "未开启系统推送设置", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        
        
        let action = UIAlertAction.init(title: "去设置", style: UIAlertActionStyle.default) { (action) in
            //            let main = DispatchQueue.main
            //            main.async {
            //
            //            }
            //            if let identifier = Bundle.main.bundleIdentifier {
            //                let str = "prefs:root=NOTIFICATIONS_ID&path=\(identifier)"
            if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
                _ = UIApplication.shared.openURL(url)
            }
            //            }
            
        }
        alertVC.addAction(cancle)
        alertVC.addAction(action)
        viewController.present(alertVC, animated: true, completion: nil)
    }
    var topItems: [CustomDetailModel] = []
    var bottomItems: [CustomDetailModel] = []
    
    var cellClick: PublishSubject<CustomDetailModel> = PublishSubject<CustomDetailModel>.init()
    var configView: PublishSubject<CustomDetailModel> = PublishSubject<CustomDetailModel>.init()
    
    
    
    
}
