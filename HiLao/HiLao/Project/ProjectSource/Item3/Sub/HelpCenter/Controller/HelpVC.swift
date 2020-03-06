//
//  HelpVC.swift
//  Project
//
//  Created by 张凯强 on 2017/11/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift

class HelpVC: DDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "帮助中心"
        self.setUI()
        // Do any additional setup after loading the view.
    }

    func setUI() {
        self.view.addSubview(questionFeedback)
        self.view.addSubview(onlineTranslation)
        
        self.questionFeedback.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH / 2.0, height: 44)
        self.onlineTranslation.frame = CGRect.init(x: SCREENWIDTH / 2.0, y: DDNavigationBarHeight, width: SCREENWIDTH / 2.0, height: 44)
        
        self.questionFeedback.setTitle("问题反馈", for: .normal)
        self.onlineTranslation.setTitle("在线反馈", for: .normal)
        
        self.questionFeedback.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.onlineTranslation.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        self.questionFeedback.setTitleColor(UIColor.red, for: .normal)
        self.onlineTranslation.setTitleColor(UIColor.red, for: .normal)
        
        
        
        self.questionFeedback.rx.tap.subscribe { (_) in
            mylog("jump question feedback vc")
            let vc = QuestionFacebackVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }.disposed(by: bag)
        
    }
    
    
    
    
    let bag = DisposeBag()
    
    
    let questionFeedback = UIButton.init()
    let onlineTranslation = UIButton.init()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
