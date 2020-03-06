//
//  LoginVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit
import XMPPFramework
@objc protocol LoginDelegate : NSObjectProtocol {
   @objc optional  func loginResult(result : Bool)
    
}

class LoginVC: VCWithNaviBar {

    weak var loginDelegate : LoginDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attritNavTitle = NSAttributedString(string: "登录")
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let LogoImgView  = UIImageView()
    let bottomContainer = UIView()
    let userInput = UITextField()
    let passwordInput = UITextField()
    let loginBtn = UIButton()
    let remember = UIButton()
    let forget = UIButton()
    func setupSubviews()  {
        self.view.addSubview(LogoImgView)
        self.view.addSubview(bottomContainer)
        bottomContainer.addSubview(userInput)
        bottomContainer.addSubview(passwordInput)
        bottomContainer.addSubview(loginBtn)
        bottomContainer.addSubview(remember)
        bottomContainer.addSubview(forget)
        
        /**设置frame*/
        //先设置containerView , logo再根据containerView动态改变
        let logoW = GDCalculator.GDAdaptation(100.0)
        let logoH = logoW
        
        let  usernameW : CGFloat = screenW - 60.0
        let  usernameH : CGFloat = GDCalculator.GDAdaptation(44.0)
        let passwordW = usernameW
        let passwordH = usernameH
        let loginW = usernameW
        let loginH = GDCalculator.GDAdaptation(40.0)
        let rememberW = usernameW/2
        let rememberH = GDCalculator.GDAdaptation(usernameH/4)
        let forgetW = rememberW
        let forgetH = rememberH
        let margin :CGFloat = 10.0
        let containerW = usernameW
        let containerH = usernameH + margin + passwordH + margin + loginH + margin + rememberH
        
        bottomContainer.bounds = CGRect(x: 0, y: 0, width: containerW, height: containerH)
        bottomContainer.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 22)
        self.LogoImgView.bounds = CGRect(x: 0, y: 0, width: logoW, height: logoH)
        self.LogoImgView.center = CGPoint(x: bottomContainer.center.x, y: bottomContainer.center.y - bottomContainer.bounds.height/2 - LogoImgView.bounds.size.height/2 - /*间距*/48)
        
        self.LogoImgView.image = UIImage(named: "logiLogo")
        LogoImgView.contentMode = UIViewContentMode.scaleAspectFit
//        self.bottomContainer.backgroundColor = UIColor.randomColor()
        self.userInput.frame = CGRect(x: 0, y: 0, width: usernameW, height: usernameH)
        self.passwordInput.frame = CGRect(x: 0, y: usernameH+margin, width: passwordW, height: passwordH)
        self.loginBtn.frame = CGRect(x: 0, y: usernameH + margin + passwordH + margin, width: loginW, height: loginH)
        self.remember.frame = CGRect(x: 0, y: loginBtn.frame.maxY + margin, width: rememberW, height: rememberH)
        self.forget.frame = CGRect(x: rememberW, y: loginBtn.frame.maxY + margin, width: forgetW, height: forgetH)
        /**设置属性*/
        self.userInput.placeholder = "手机号/用户名/邮箱"
        self.userInput.borderStyle = UITextBorderStyle.line
        self.userInput.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 10, height: 40))
        self.userInput.leftViewMode = UITextFieldViewMode.always
        self.passwordInput.placeholder = "密码为6~16个字符"
        self.passwordInput.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 10, height: 40))
        self.passwordInput.leftViewMode = UITextFieldViewMode.always
        self.passwordInput.borderStyle = self.userInput.borderStyle
        self.passwordInput.isSecureTextEntry = true
        self.loginBtn.setAttributedTitle(NSAttributedString(string: "登录", attributes: [NSFontAttributeName : GDFont.boldSystemFont(ofSize: 18) , NSForegroundColorAttributeName : UIColor.white]), for: UIControlState.normal)
        self.loginBtn.setAttributedTitle(NSAttributedString(string: "登录", attributes: [NSFontAttributeName : GDFont.boldSystemFont(ofSize: 18) , NSForegroundColorAttributeName : UIColor.darkGray]), for: UIControlState.disabled)
        self.loginBtn.backgroundColor = UIColor.orange
        
        self.loginBtn.embellishView(redius: 5)
        
        self.remember.setImage(UIImage(named: "btn_round_nor"), for: UIControlState.normal)
        self.remember.setImage(UIImage(named: "btn_round_sel"), for: UIControlState.selected)
        self.remember.setTitle("记住密码", for: UIControlState.normal)
        self.remember.setTitle("记住密码", for: UIControlState.selected)
        self.remember.titleLabel?.font = GDFont.systemFont(ofSize: 12)
        self.remember.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        self.remember.setTitleColor(UIColor.lightGray, for: UIControlState.selected)
        self.remember.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.remember.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.forget.setTitle("忘记密码", for: UIControlState.normal)
        self.forget.titleLabel?.font = GDFont.systemFont(ofSize: 12)
        self.forget.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        self.forget.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        
        
        self.loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.remember.addTarget(self, action: #selector(rememberClick(sender:)), for: UIControlEvents.touchUpInside)
        self.remember.isSelected = UserDefaults.standard.bool(forKey: "IsRememberPassword")
        self.forget.addTarget(self, action: #selector(forgetClick), for: UIControlEvents.touchUpInside)
        
        
        
        if remember.isSelected {
            if let username = UserDefaults.standard.value(forKey: "Username") {
                if let usernameStr  = username as? String {
                    self.userInput.text = usernameStr
                }
            }
            
            if let password = UserDefaults.standard.value(forKey: "Password") {
                if let passwordStr  = password as? String {
                    self.passwordInput.text = passwordStr
                }
            }

        }
        
        
    }
    func loginBtnClick(sender:UIButton) {
        if self.userInput.text == nil || self.userInput.text?.characters.count == 0 {
            GDAlertView.alert("用户名为空", image: nil, time: 3, complateBlock: nil)
            return
        }
        if !(self.usernameLawful(username: self.userInput.text!)/* || self.emailLawful(email: self.userInput.text! ) || self.mobileLawful(mobileStr: self.userInput.text!) */){
//            GDAlertView.alert("请输入正确的手机,邮箱或者用户名", image: nil, time: 3 , complateBlock: nil)
            GDAlertView.alert("请输入正确的用户名", image: nil, time: 3 , complateBlock: nil)

            return
        }
        if self.passwordInput.text == nil || self.passwordInput.text?.characters.count == 0 {
            GDAlertView.alert("密码为空", image: nil , time: 3, complateBlock: nil)
            return
        }
        if !self.passwordLawful(password: self.passwordInput.text!) {
            GDAlertView.alert("请输入6~16位的登录密码", image: nil , time: 3, complateBlock: nil )
            return
        }
        
        sender.isEnabled = false
        sender.backgroundColor = sender.isEnabled ? UIColor.orange : UIColor.lightGray
        
        NetworkManager.shareManager.loginSeller(self.userInput.text ?? "", password: self.passwordInput.text ?? "", success: { (result) in
            if ((result.status?.intValue)! > 0  ){
//                mylog(GDXmppStreamManager.shareXMPP().xmppStream.isConnected())
//                mylog(GDXmppStreamManager.shareXMPP().xmppStream.isConnecting())
//                mylog(Account.shareAccount.isLogin)
//                GDXmppStreamManager.shareXMPP().login(with:XMPPJID.init(string:  Account.shareAccount.name), passWord: NetworkManager.shareManager.token);
                mylog("登录成功")
                self.loginDelegate?.loginResult!(result: true)
                self.dismiss(animated: true, completion: {
                    
                })
            }else{
                GDAlertView.alert(result.msg, image: nil , time: 3, complateBlock: nil)
                sender.isEnabled = true
                 self.loginBtn.backgroundColor = UIColor.orange
                
            }
        }) { (error) in
            //            self.loginDelegate?.loginResult!(result: true)
            sender.isEnabled = true
             self.loginBtn.backgroundColor = UIColor.orange
            GDAlertView.alert("请求失败,请稍后重试", image: nil, time: 3, complateBlock: nil)
             sender.isEnabled = true
            mylog(error)
        }

        
        if self.remember.isSelected {
            UserDefaults.standard.set(self.userInput.text, forKey: "Username")
            UserDefaults.standard.set(self.passwordInput.text, forKey: "Password")
        }else{
            UserDefaults.standard.set(nil, forKey: "Password")
            UserDefaults.standard.set(nil, forKey: "Username")
        }
        
        
        mylog("点击登录")
    }
    func rememberClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: "IsRememberPassword")
        mylog("点击记住密码")
    }
    func forgetClick() {
        mylog("点击忘记密码")
        GDAlertView.alert("请前往直接捞网站找回密码", image: nil, time: 3, complateBlock: nil)
    }
    
    
    
    
    
    
    /**  则匹配用户密码6-16位数字和字母组合*/
    
    func passwordLawful(password:String) -> Bool {
        let passwordRegex = "^\\S{6,16}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    
    
    
    /**邮箱的有效性*/
    func emailLawful(email:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /** 判断用户名的合法性 */
    
    func usernameLawful(username:String) -> Bool  {
        let usernameRegex = "^[a-zA-Z][a-zA-Z0-9-_:~]{5,31}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)

    }
    /** 判断手机号的合法性 */
    func mobileLawful(mobileStr:String) -> Bool {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let cm = "^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$"
        let cu = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let ct = "^1((33|53|8[019])[0-9]|349)\\d{7}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        let regexCM = NSPredicate(format: "SELF MATCHES %@", cm)
        let regexCU = NSPredicate(format: "SELF MATCHES %@", cu)
        let regexCT = NSPredicate(format: "SELF MATCHES %@", ct)
        
        if regexMobile.evaluate(with: mobileStr) || regexCM.evaluate(with: mobileStr) || regexCU.evaluate(with: mobileStr) || regexCT.evaluate(with: mobileStr) {
            return true
        }else{return false}
        
    }
    
    
    override func popToPreviousVC() {
        self.dismiss(animated: true, completion: {
            self.loginDelegate?.loginResult!(result: false)//登录成功(true)或失败(false)的回调 ,
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
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
