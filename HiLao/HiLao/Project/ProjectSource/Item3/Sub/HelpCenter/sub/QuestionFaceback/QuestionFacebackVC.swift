//
//  QuestionFacebackVC.swift
//  Project
//
//  Created by 张凯强 on 2017/11/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class QuestionFacebackVC: DDNormalVC,UITextViewDelegate {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "问题反馈"
        self.view.backgroundColor = color4
        self.setUI()
        self.interactive()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setUI() {
        
        self.textView.backgroundColor = UIColor.white
        self.view.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.textView.snp.bottom).offset(-12)
            make.right.equalTo(self.textView.snp.right).offset(-12)
        }
        self.propmTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.textView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
        }
        self.propmDetaillabel1.numberOfLines = 0
        self.propmDetailLabel2.numberOfLines = 0
        self.propmDetaillabel1.snp.makeConstraints { (make) in
            make.top.equalTo(self.propmTitleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        self.propmDetailLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(self.propmDetaillabel1.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        self.submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.propmDetailLabel2.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(55)
        }
        
        
        
        
    }
    ///交互
    func interactive() {
        let textobserval = self.textView.rx.text
        textobserval.orEmpty.subscribe(onNext: { (text) in
            let count = text.characters.count
            self.countLabel.text = "\(count)/500"
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        self.textView.rx.didBeginEditing.subscribe { (_) in
            if self.textView.text == self.placeStr {
                self.textView.text = ""
            }
            
            }.disposed(by: bag)
        self.textView.rx.didChange.subscribe { (_) in
            if self.textView.text.characters.count >= 200 {
                self.textView.resignFirstResponder()
            }
            let count = self.textView.text.characters.count
            self.countLabel.text = "\(count)/500"
            }.disposed(by: bag)
        
        self.textView.rx.didEndEditing.subscribe { (_) in
            if self.textView.text.characters.count < 1 {
                self.textView.text = self.placeStr
            }
            }.disposed(by: bag)
        
        
        //submit
        let tapObsever = self.submitBtn.rx.tap
        tapObsever.subscribe { (_) in
            if (self.textView.text == self.placeStr) || (self.textView.text.characters.count < 10) {
                GDAlertView.alert("反馈内容骄傲了福利卡李达康法兰克福来看的", image: nil, time: 1, complateBlock: nil)
                return
            }
            
            
            
        }
        
        
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    lazy var propmTitleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = color1
        label.text = "温馨提示:"
        label.sizeToFit()
        self.view.addSubview(label)
        return label
    }()
    lazy var propmDetaillabel1: UILabel = {
        let label = UILabel.configlabel(font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.red, text: "")
       
        self.view.addSubview(label)
        return label
    }()
    lazy var propmDetailLabel2: UILabel = {
        let label = UILabel.configlabel(font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, text: "")
        self.view.addSubview(label)
        return label
    }()
  
    
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton.init()
        self.view.addSubview(btn)
        btn.setTitle("submit", for: .normal)
        btn.setTitleColor(color1, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.backgroundColor = UIColor.yellow
        return btn
    }()
    
    let placeStr = "请输入您所遇到的问题，我们将在1~3个工作日内反馈"
    lazy var textView: UITextView = {
        let view = UITextView.init()
        let propert: CGFloat = 210.0 / (375 - 24)
        let height = (SCREENWIDTH - 24) * propert
        view.frame = CGRect.init(x: 12, y: 64 + 8, width: SCREENWIDTH - 24, height: height)
        view.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 30, right: 0)
        view.text = placeStr
        view.textColor = color7
        view.delegate = self
        view.font = font13
        view.backgroundColor = UIColor.white
        view.textAlignment = NSTextAlignment.left
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(12)
        view.layer.borderColor = color3.cgColor
        view.layer.borderWidth = 1
        self.view.addSubview(view)
        return view
    }()
    lazy var countLabel: UILabel = {
        let view = UILabel.init()
        view.textColor = color7
        view.font = font13
        view.sizeToFit()
        view.text = "0/500"
        return view
    }()
    
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
