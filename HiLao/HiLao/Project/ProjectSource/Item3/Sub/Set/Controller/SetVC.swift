//
//  SetVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/7.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
class SetVC: GDNormalVC {

    let viewModel = SetViewModel.init()
    let bag = DisposeBag.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "set")
        self.setUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true , animated: true )
    }
    func setUI() {
        self.viewModel.getData()
        let topX: CGFloat = 15
        let topY: CGFloat = DDNavigationBarHeight + 20
        let width: CGFloat = SCREENWIDTH - 40
        let height: CGFloat = 52
        let topView = SetTopView.init(frame: CGRect.init(x: topX, y: topY, width: width, height: CGFloat(self.viewModel.topItems.count) * height), viewModel: self.viewModel)
        self.view.addSubview(topView)
        
        let bottomView = SetBottomView.init(frame: CGRect.init(x: topX, y: topView.max_Y + 20, width: width, height: CGFloat(self.viewModel.bottomItems.count) * height), viewModel: self.viewModel)
        self.view.addSubview(bottomView)
        self.interactive()
        
        
    }
    
    func interactive() {
        self.viewModel.cellClick.subscribe { [weak self](event) in
            guard let model = event.element else {
                return
            }
            self?.dealClickItem(model: model)
            
        }
    }
    
    func dealClickItem(model: CustomDetailModel) {
        switch model.action! {
        case "changeLanguage":
            let choseLanguage = ChooseLanguageVC()
//            choseLanguage.click.subscribe(onNext: { (language) in
//                mylog(language)
//            }, onError: nil, onCompleted: nil, onDisposed: {
//                mylog("传送语言回收")
//            })
            self.navigationController?.pushViewController(choseLanguage, animated: true)
        case "clean":
            //清空磁盘缓存
            self.viewModel.cleanCacheAction()
            model.rightDetailTitle =  String.init(format: "%@M", "0")
            self.viewModel.configView.onNext(model)
        case "aboutWe":
            let aboutVC = SAboutWeVC()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        default:
            break
        }
    }
    
    deinit {
        mylog("设置页面销毁")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
