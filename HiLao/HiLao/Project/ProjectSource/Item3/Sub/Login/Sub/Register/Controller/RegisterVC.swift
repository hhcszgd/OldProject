//
//  RegisterVC.swift
//  wenyouhui
//
//  Created by 张凯强 on 2017/6/2.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RegisterVC: GDNormalVC {
    let loginViewModel = LoginViewModel.init()
    override var keyModel: GDModel?{
        didSet {
            guard let model = keyModel else {
                return
            }
            if model.type == "forget" {
                self.viewModel.vcType.value = RegisterVCType.forget
                self.viewModel.codeType.value = .forgetpass
            }else {
                self.viewModel.codeType.value = .register
                self.viewModel.vcType.value = RegisterVCType.register
            }
            self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(font: UIFont.systemFont(ofSize: 17), textColor: UIColor.white, text: model.actionKey)
            
        }
    }
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.getCodeKey()
        
        self.configMentNav()
        self.setUI()
        self.interactive()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func configMentNav() {
        
        self.naviBar.backgroundColor = mainColor
        self.naviBar.showLineview = false
    }
    
    

    let viewModel: RegisterViewModel = RegisterViewModel()
    
    func setUI() {
        self.view.backgroundColor = UIColor.colorWithHexStringSwift("f2f2f2")
        
        self.backControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.topView.addSubview(self.phoneType)
        self.topView.addSubview(self.emailType)
        self.topView.addSubview(self.leftLine)
        self.topView.addSubview(self.rightLine)
        self.rightLine.isHidden = true
        let left: CGFloat = CGFloat(34) * SCALE
        let subWidth: CGFloat = 115 * SCALE
        let subHeight: CGFloat = 2.5
        
        self.phoneType.isSelected = true
        
        self.phoneType.frame = CGRect.init(x: left , y: 0, width: subWidth, height: self.topView.bounds.size.height)
        self.leftLine.frame = CGRect.init(x: left, y: self.topView.bounds.size.height - subHeight, width: 115 * SCALE, height: subHeight)
        
        self.emailType.frame = CGRect.init(x: self.topView.bounds.size.width - CGFloat(34) * SCALE - 115 * SCALE, y: 0, width: 115 * SCALE, height: self.topView.bounds.size.height)
        self.rightLine.frame = CGRect.init(x: self.emailType.frame.origin.x, y: self.topView.bounds.size.height - subHeight, width: 115 * SCALE, height: subHeight)
        
        
        
        let X: CGFloat = 20
        let Y: CGFloat = self.topView.max_Y + 40 * SCALE
        let width: CGFloat = SCREENWIDTH - 40
        let propert: CGFloat = CGFloat(420) / CGFloat(670)
        let height: CGFloat = width * propert
        let mainView = RegistermainView.init(frame: CGRect.init(x: X, y: Y, width: width, height: height), viewModel: viewModel)
        self.view.addSubview(mainView)
        
        
        
        let registerPropert: CGFloat = CGFloat(85) / CGFloat(675)
        let registerHeight: CGFloat = width * registerPropert
        self.registerBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainView.snp.bottom).offset(40 * SCALE)
            make.height.equalTo(registerHeight)
            
        }
        
        self.agreeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.registerBtn.snp.bottom).offset(25 * SCALE)
        }
        
        self.selelctBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.agreeLabel.snp.left)
            make.centerY.equalTo(self.agreeLabel.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        var keyBoardHeight: CGFloat = 0
        switch DDDevice.type {
        case .iPhone4, .iPhone5:
            keyBoardHeight = 253
        case .iPhone6:
            keyBoardHeight = 258
        case .iPhone6p:
            keyBoardHeight = 271
        default:
            keyBoardHeight = 271
        }
        //topview移动的距离
        let move = keyBoardHeight - SCREENHEIGHT + self.registerBtn.max_Y
        
        self.viewModel.textFieldStatus.subscribe(onNext: { (action) in
            UIView.animate(withDuration: 0.3, animations: {
                if action == "begin" {
                    mainView.transform = CGAffineTransform.init(translationX: 0, y: -40 * SCALE)
                }
                if action == "end" {
                    mainView.transform = CGAffineTransform.identity
                }
            })
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        
    }
    func interactive() {
        self.viewModel.jumpToSelectCode.subscribe { [weak self](event) in
//            guard let action = event.element else {
//                return
//            }
            
            let selectAreaCode = SelectAreaCodeVC()
            selectAreaCode.modelSelect.subscribe({ [weak self](model) in
                guard let mo = model.element else {
                    return
                }
                guard let areaCode = mo.area else {
                    return
                }
                self?.viewModel.returnAreaCode.value = areaCode
            
            })
            self?.navigationController?.pushViewController(selectAreaCode, animated: true)
            
            
        }
        
        
        self.viewModel.perfectUserInfo.subscribe(onNext: { [weak self](model) in
            mylog(model)
            
            mylog("完善个人信息")
            DDShowManager.skip(current: self, model: model)
            
            
        }, onError: { (error) in
            mylog(error)
        }, onCompleted: {
            mylog("结束")
        }) {
            mylog("回收")
        }
       
        
        self.viewModel.bindPhone.subscribe { [unowned self](event) in
            guard let model = event.element else {
                return
            }
            mylog("绑定手机号码")
            DDShowManager.skip(current: self, model: model)
            
        }
        self.viewModel.vcType.asObservable().subscribe { [weak self](event) in
            guard let action = event.element else {
                return
            }
            if action == RegisterVCType.forget {
                self?.registerBtn.setTitle(DDLanguageManager.text("resetPassword"), for: .normal)
                self?.agreeLabel.isHidden = true
                self?.selelctBtn.isHidden = true
                self?.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "resetPassword")
                
            }else {
                self?.registerBtn.setTitle(DDLanguageManager.text("register"), for: .normal)
                self?.agreeLabel.isHidden = false
                self?.selelctBtn.isHidden = false
                self?.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "register")
            }
        }
        
        
        
        
    }
    
    
    
    
    @objc func agreeAction(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        self.agreement = btn.isSelected
        
        
        
    }
    ///协议是默认同意的
    var agreement: Bool = true
    @objc func checkXieYi() {
        let vc = PhonebindVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func phoneAction(btn: UIButton) {
        self.rightLine.isHidden = true
        self.emailType.isSelected = false
        if btn.isSelected {
            return
        }
        btn.isSelected = !btn.isSelected
        self.leftLine.isHidden = !btn.isSelected
        self.viewModel.type.value = RegisterType.phone
    }
    
    @objc func emailAction(btn: UIButton) {
        self.leftLine.isHidden = true
        self.phoneType.isSelected = false
        if btn.isSelected {
            return
        }
        
        btn.isSelected = !btn.isSelected
        self.rightLine.isHidden = !btn.isSelected
        self.viewModel.type.value = RegisterType.email
    }
    
    @objc func registerAction(btn: UIButton) {
        if !agreement {
            GDAlertView.alert("请先同意注册协议", image: nil, time: 1, complateBlock: nil)
            return
        }
        self.viewModel.register()
        mylog("注册")
    }
    
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    @objc func keyboardWillShow(notification: Notification) {
        if let userinfo = notification.userInfo {
            if let rectAny = userinfo[UIKeyboardFrameEndUserInfoKey] as AnyObject?, let duration = userinfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject?{
                if let rect = rectAny.cgRectValue, let durationNum = duration.floatValue {
                    print(rect)
                    UIView.animate(withDuration: TimeInterval(durationNum), animations: {
                        

                    })
                }
            }
            
        }
    }
    var keyboardSize: CGSize?
    
    @objc func keyboardDidHidden(notification: Notification) {
        if let userinfo = notification.userInfo {
            if  let duration = userinfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject?{
                if let durationNum = duration.floatValue {
                    UIView.animate(withDuration: TimeInterval(durationNum), animations: {
                        
                        self.topView.transform =  CGAffineTransform.identity
                    })
                }
            }
            
        }
    }
    
    
    
    @objc func resignFirstResponderAction(){
        self.viewModel.resigetionAction.onNext("resigetion")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        mylog("注册页面销毁")
        NotificationCenter.default.removeObserver(self)
    }
    
    lazy var backControl: UIControl = {
        let control = UIControl.init()
        self.view.addSubview(control)
        control.addTarget(self, action: #selector(resignFirstResponderAction), for: .touchUpInside)
        return control
    }()
    
    
    
    lazy var registerBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("register"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = CGFloat(6)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(registerAction(btn:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var leftLine: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.colorWithHexStringSwift("fe5f5f")
        return view
    }()
    
    lazy var rightLine: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.colorWithHexStringSwift("fe5f5f")
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: 50 * SCALE))
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        return view
    }()
    
    lazy var phoneType: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("phoneType"), for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("fe5f5f"), for: .selected)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("5e5e5e"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(phoneAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var emailType: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("emailType"), for: .normal)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("fe5f5f"), for: .selected)
        btn.setTitleColor(UIColor.colorWithHexStringSwift("5e5e5e"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(emailAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var selelctBtn: UIButton = {
        let btn = UIButton.init()
        self.view.addSubview(btn)
        btn.setImage(UIImage.init(named: "btn_icon"), for: .normal)
        btn.setImage(UIImage.init(named: "selected_btn_icon"), for: .selected)
        btn.adjustsImageWhenHighlighted = false
        btn.isSelected = true
        btn.addTarget(self, action: #selector(agreeAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var agreeLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        let attributeString = NSMutableAttributedString.init(string: "已阅读并同意《最低捞用户协议》")
        label.font = UIFont.systemFont(ofSize: 11)
        let range = NSMakeRange(6, 9)
    attributeString.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.colorWithHexStringSwift("05a9ff")], range: range)
        
        label.textColor = UIColor.colorWithHexStringSwift("1a1a1a")
        self.view.addSubview(label)
        let control = UIControl.init()
        label.attributedText = attributeString
        label.addSubview(control)
        control.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview()
        })
        label.isUserInteractionEnabled = true
        control.addTarget(self, action: #selector(checkXieYi), for: .touchUpInside)
        self.view.addSubview(label)
        return label
    }()
    
    

}
