//
//  UseHomeHeaderView.swift
//  Project
//
//  Created by 张凯强 on 2017/12/17.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import RxSwift
class UseHomeHeaderView: UIView {

    init(frame: CGRect, viewModel: UseHomeViewModel) {
        super.init(frame: frame)
        let backImageView = UIImageView.init()
        self.addSubview(backImageView)
        backImageView.image = UIImage.init(named: "usercenterbackground")
        backImageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        
        self.addSubview(self.headerImage)
        self.headerImage.snp.makeConstraints { (make) in
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(81 * SCALE)
            
        }
        self.headerImage.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.headerImage.layer.borderWidth = 5
        self.headerImage.layer.masksToBounds = true
        self.headerImage.layer.cornerRadius = 45
        self.addSubview(self.levelImage)
        self.levelImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.headerImage.snp.centerX)
            make.bottom.equalTo(self.headerImage.snp.bottom)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        self.levelImage.image = UIImage.init(named: "rankicons")
        self.levelImage.layer.cornerRadius = 10
        self.levelImage.layer.masksToBounds = true
        
        self.addSubview(self.contentBtn)
        self.addSubview(self.followBtn)
        self.addSubview(self.achieveBtn)
        self.contentBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(17)
            make.bottom.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(60)
        }
        self.followBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(34)
        }
        self.achieveBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(34)
            make.right.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview()
        }
        self.addSubview(self.lineView)
        self.contentAction(btn: self.contentBtn)
        
        
    }
    
    func scrollIndex(index: Int) {
        switch index {
        case 0:
            self.contentAction(btn: self.contentBtn)
        case 1:
            self.followAction(btn: self.followBtn)
        case 2:
            self.achieveAction(btn: self.achieveBtn)
        default:
            break
        }
    }
    
    let index: PublishSubject<Int> = PublishSubject<Int>.init()
    @objc func contentAction(btn: UIButton) {
        btn.isSelected = true
        self.followBtn.isSelected = false
        self.achieveBtn.isSelected = false
        self.animation(btn: btn)
        index.onNext(0)
    }
    @objc func followAction(btn: UIButton) {
        btn.isSelected = true
        self.contentBtn.isSelected = false
        self.achieveBtn.isSelected = false
        self.animation(btn: btn)
        self.index.onNext(1)
    }
    @objc func achieveAction(btn: UIButton) {
        btn.isSelected = true
        self.followBtn.isSelected = false
        self.contentBtn.isSelected = false
        self.animation(btn: btn)
        self.index.onNext(2)
    }
    func animation(btn: UIButton) {
        var left: CGFloat = 17
        switch btn {
        case self.contentBtn:
            left = 17
        case self.followBtn:
            let leve = (SCREENWIDTH - 60) / 2.0
            left = leve
        case self.achieveBtn:
            left = SCREENWIDTH - 60 - 17
        default:
            break
        }
        UIView.animate(withDuration: 0.3) {
            self.lineView.snp.updateConstraints { (make) in
                make.width.equalTo(60)
                make.height.equalTo(5)
                make.centerY.equalTo(self.snp.bottom)
                make.left.equalTo(left)
            }
            self.layoutIfNeeded()
        }
    }
    
    
    lazy var contentBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("content"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(contentAction(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var achieveBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("achievement"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(achieveAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var followBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("follow"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(followAction(btn:)), for: .touchUpInside)
        return btn
    }()
    let headerImage = UIImageView.init()
    let levelImage = UIImageView.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize.init(width: -1, height: 1)
        return view
    }()
    
    

}
