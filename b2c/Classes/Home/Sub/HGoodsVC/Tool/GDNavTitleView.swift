//
//  GDNavTitleView.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/6.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
@objc protocol ZkqNavTitleViewDelegate: class {
    @objc optional func titleViewScrollToTarget(index: Int)
}
class GDNavTitleView: NavTitleView {
    
    //代理
    weak var delegate: ZkqNavTitleViewDelegate?
    var scroll: UIScrollView?
    var titleView: UIView?
    var titleLabel: UILabel?
    var btnArr: [UIButton] = [UIButton]()
    /**滚动线的高度*/
    var lineHeight: CGFloat = 2.0
    var lineView: UIView = UIView.init()
    var selectedBtn: UIButton?
    var totalW: CGFloat = 0.0
    var titleSize: [CGSize] = [CGSize]()
    init(frame: CGRect, titleArr: [String], font: UIFont) {
        super.init(frame: frame)
        //
        scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        scroll?.isScrollEnabled = false
        scroll?.contentSize = CGSize.init(width: frame.size.width, height: frame.size.height * CGFloat(2.0))
        scroll?.showsVerticalScrollIndicator = false
        self.addSubview(scroll!)
        //
        titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.scroll?.addSubview(titleView!)
        let maxWidth: CGFloat = frame.size.width / CGFloat(titleArr.count)
        
        for title in titleArr {
            let size: CGSize = title.sizeWith(font: font, maxWidth: maxWidth)
            totalW += (size.width + CGFloat(5.0))
            titleSize.append(CGSize.init(width: size.width + CGFloat(5.0), height: size.height))
            
        }
        let margin: CGFloat = (frame.size.width - totalW) / CGFloat(titleArr.count - 1)
        for index in 0...(titleArr.count - 1) {
            let titleStr: String = titleArr[index]
            let btn: UIButton = UIButton.init()
            btn.setTitle(titleStr, for: UIControlState.normal)
            btn.setTitleColor(UIColor.colorWithHexStringSwift("333333"), for: UIControlState.normal)
            btn.setTitleColor(THEMECOLOR, for: UIControlState.selected)
            btn.titleLabel?.font = font
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: UIControlEvents.touchUpInside)
            btn.tag = index
            btn.frame = CGRect.init(x: CGFloat(index) * (margin + titleSize[index].width), y: 0, width: titleSize[index].width, height: frame.size.height - lineHeight)
            if index == 0 {
                btn.isSelected = true
                selectedBtn = btn
            }
            btnArr.append(btn)
            self.titleView?.addSubview(btn)
        }
        self.titleView?.addSubview(lineView)
        lineView.backgroundColor = THEMECOLOR
        lineView.bounds = CGRect.init(x: 0, y: 0, width: titleSize[0].width - CGFloat(5.0), height: lineHeight)
        lineView.center = CGPoint.init(x: (selectedBtn?.center.x)!, y: (selectedBtn?.bounds.size.height)! + lineHeight / CGFloat(2.0))
        
        //
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height, width: frame.size.width, height: frame.size.height))
        self.scroll?.addSubview(titleLabel!)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.textColor = UIColor.colorWithHexStringSwift("333333")
        
        
    }
    

    
    
    
    func btnClick(btn: UIButton) {
        if btn == selectedBtn! {
            return
        }
        selectedBtn?.isSelected = false
        selectedBtn = btn
        selectedBtn?.isSelected = true
        UIView.animate(withDuration: 0.2) {
            self.lineView.center = CGPoint.init(x: btn.center.x, y: btn.frame.size.height + (self.lineHeight/2.0))
            self.lineView.bounds = CGRect.init(x: 0, y: 0, width: btn.bounds.size.width - 5.0, height: self.lineHeight)
        }
        
        if delegate != nil {
            delegate?.titleViewScrollToTarget!(index: btn.tag)
        }
        
        
    }
    
    
    func configmentBtn(tag: Int) {
        let btn = btnArr[tag]
        selectedBtn?.isSelected = false
        selectedBtn = btn
        selectedBtn?.isSelected = true
        UIView.animate(withDuration: 0.2) {
            self.lineView.center = CGPoint.init(x: btn.center.x, y: btn.frame.size.height + (self.lineHeight/2.0))
            self.lineView.bounds = CGRect.init(x: 0, y: 0, width: btn.bounds.size.width - 5.0, height: self.lineHeight)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
