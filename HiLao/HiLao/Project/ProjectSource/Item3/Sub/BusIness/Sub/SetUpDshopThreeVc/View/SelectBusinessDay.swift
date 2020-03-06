//
//  SelectBusinessDay.swift
//  Project
//
//  Created by 张凯强 on 2017/12/23.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class SelectBusinessDay: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet var cancleBtn: UIButton!
    @IBOutlet var trueBtn: UIButton!
    @IBOutlet var sundayBtn: UIButton!
    @IBOutlet var saturdayBtn: UIButton!
    @IBOutlet var fridayBtn: UIButton!
    @IBOutlet var thursdayBtn: UIButton!
    @IBOutlet var wesdnesdayBtn: UIButton!
    @IBOutlet var tuesdayBtn: UIButton!
    @IBOutlet var mondayBtn: UIButton!
    @IBOutlet var btnBackView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var backView: UIView!
    @IBOutlet var superBackView: UIView!
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.layer.masksToBounds = true
        self.backView.layer.cornerRadius = 6
        self.btnBackView.subviews.forEach { (view) in
            if let btn = view as? UIButton {
                btn.isSelected =  false
                btn.backgroundColor = UIColor.colorWithHexStringSwift("f1f0f0")
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func mondayAction(_ sender: UIButton) {
        configBtn(sender: sender)
    }
    func configBtn(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.colorWithHexStringSwift("fe5f5f")
        }else {
            sender.backgroundColor = UIColor.colorWithHexStringSwift("f1f0f0")
        }
    }
    @IBAction func tuesdayAction(_ sender: UIButton) {
        configBtn(sender: sender)
        
    }
    
    @IBAction func wesdnesdayAction(_ sender: UIButton) {
        configBtn(sender: sender)
    }
    @IBAction func thurAction(_ sender: UIButton) {
        configBtn(sender: sender)
    }
    
    @IBAction func friAction(_ sender: UIButton) {
        configBtn(sender: sender)
        
    }
    @IBAction func saturAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func sanAction(_ sender: UIButton) {
        configBtn(sender: sender)
    }
    @IBAction func trueAction(_ sender: UIButton) {
        var resultStr = ""
        if self.mondayBtn.isSelected && self.tuesdayBtn.isSelected, self.wesdnesdayBtn.isSelected && self.thursdayBtn.isSelected && self.fridayBtn.isSelected && self.saturdayBtn.isSelected && self.sundayBtn.isSelected {
            self.result.onNext("周一至周日")
        }else if self.mondayBtn.isSelected {
            resultStr = "周一"
        }else if self.tuesdayBtn.isSelected {
            resultStr += ",周二"
        }else if self.wesdnesdayBtn.isSelected {
            resultStr += ",周三"
        }else if self.thursdayBtn.isSelected {
            resultStr += ",周四"
        }else if self.fridayBtn.isSelected {
            resultStr += ",周五"
        }else if self.saturdayBtn.isSelected {
            resultStr += ",周六"
        }else if self.sundayBtn.isSelected {
            resultStr += ",周日"
        }
        self.result.onNext(resultStr)
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    var result: PublishSubject<String> = PublishSubject<String>.init()
    @IBAction func cancleAction(_ sender: UIButton) {
        self.result.onNext("未营业")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KTCenterAnimationController()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KTCenterAnimationController()
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
