//
//  GDMenuView.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/7.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
//菜单view的tag
let MenuTag: NSInteger = 201727
//覆盖图view
let coverView: NSInteger = 2017271
//
let menuMargin: CGFloat = 8.0
let triangleHeight: CGFloat = 10.0
let defaultMaxValue: NSInteger = 6
let menuRadius: CGFloat = 5.0
@objc protocol GDMenuViewDelegate: class {
    @objc optional func itemsClick(indexPath: IndexPath)
}
@objc protocol GDMenuBtnDelegate: class {
    @objc optional func itemselectClick(indexPath: IndexPath)
}
class GDMenuBtn: UIButton,  GDMenuViewDelegate{
    weak var delegate: GDMenuBtnDelegate?
    init(frame: CGRect, dataArr:[[String: String]], point: CGPoint) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(menuClick(btn:)), for: UIControlEvents.touchUpInside)
        self.backgroundColor = UIColor.clear
        self.setImage(UIImage.init(named: "icon_more"), for: UIControlState.normal)
        self.point = point
        self.dataArr = dataArr
        
    }
    weak var fatherVC: GDNormalVC?
    weak var secondFatherVC: SecondBaseVC?
    var selectItemsBlock:((_ index: IndexPath) -> ())?
    
    func menuClick(btn: UIButton){
        let menuView = GDMenuView.init(frame: CGRect.init(x: 0, y: 0, width: Int(120 * scale), height: 40 * dataArr.count), fatherVC: fatherVC,secondFather:secondFatherVC)
        menuView.menuDataArr = self.dataArr
        menuView.tag = MenuTag
        menuView.delegate = self
        menuView.showMenuAtPoint(point: self.point)
    }
    //代理方法
    func itemsClick(indexPath: IndexPath) {
        self.delegate?.itemselectClick!(indexPath: indexPath)
        if self.selectItemsBlock != nil {
            self.selectItemsBlock!(indexPath)
        }
    }
    var dataArr:[[String: String]] = [[String: String]]()
    var point: CGPoint = CGPoint.zero
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GDMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: GDMenuViewDelegate?
    
    var contentTableView: UITableView?
    var menuDataArr: [[String: String]] = [[String: String]]()
    var backView: UIView?
    var arrowPointX: CGFloat?
    //最多几个菜单个数
    init(frame: CGRect, fatherVC: GDNormalVC?, secondFather: SecondBaseVC?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: CGFloat(61) / CGFloat(255.0), green: CGFloat(61) / CGFloat(255.0), blue: CGFloat(61) / CGFloat(255.0), alpha: CGFloat(0.8))
        arrowPointX = self.width
        let tableView: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: triangleHeight, width: self.width, height: self.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(GDMenuCell.self, forCellReuseIdentifier: "GDMenuCell")
        
        contentTableView = tableView
        self.height = tableView.height + triangleHeight * 2 - 0.5
        self.alpha = 0
        backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH))
        backView?.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        backView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tap(tap:))))
        backView?.alpha = 0.0
        backView?.tag = coverView
        //        let window = UIApplication.shared.keyWindow
        if fatherVC != nil {
            fatherVC?.view.addSubview(backView!)
        }
        if secondFather != nil {
            secondFather?.view.addSubview(backView!)
        }
        
        
        let lay: CAShapeLayer = self.getBorderLayer()
        self.layer.mask = lay
        self.addSubview(tableView)
        //        UIApplication.shared.keyWindow?.addSubview(self)
        
        if fatherVC != nil {
            fatherVC?.view.addSubview(self)
        }
        if secondFather != nil {
            secondFather?.view.addSubview(self)
        }
        self.fatherVC = fatherVC
        self.secondFather = secondFather
    }
    weak var fatherVC:GDNormalVC?
    weak var secondFather: SecondBaseVC?
    //tableview代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuDataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GDMenuCell", for: indexPath) as! GDMenuCell
        let dict = self.menuDataArr[indexPath.row]
        let imageStr: String = dict["image"]!
        let titleStr: String = dict["title"]!
        cell.imageView?.image = UIImage.init(named: imageStr)
        cell.textLabel?.text = titleStr
        if self.menuDataArr.count == (indexPath.item + 1) {
            cell.lineView?.backgroundColor = UIColor.clear
        }else{
            cell.lineView?.backgroundColor = UIColor.white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.itemsClick!(indexPath: indexPath)
    }
    
    var itemsClickBlock:((_ indexpath: IndexPath) -> ())?
    var menuViewIsShow:(() -> ())?
    
    func tap(tap:UITapGestureRecognizer) {
        self.hiddenMenu()
    }
    func disPlayAtPoint(point: CGPoint) {
        let resetPoint = self.superview?.convert(point, to: self.window)
        self.layer.setAffineTransform(CGAffineTransform.identity)
        self.adjustPosition(point: resetPoint!)
        //调整箭头位置
        if (resetPoint?.x)! <= menuMargin + menuRadius + triangleHeight * 0.7 {
            arrowPointX = menuMargin + menuRadius
        }else if ((resetPoint?.x)! >= screenW - menuMargin - menuRadius - triangleHeight * 0.7){
            arrowPointX = self.width - menuMargin - menuRadius
        }else{
            arrowPointX = (resetPoint?.x)! - self.x
        }
        var aPoint: CGPoint = CGPoint.init(x: 0.5, y: 0.5)
        if self.frame.maxY > screenH {
            aPoint = CGPoint.init(x: arrowPointX! / self.width, y: 1)
            
        }else {
            aPoint = CGPoint.init(x: arrowPointX! / self.width, y: 0)
        }
        //调整图层
        let layer: CAShapeLayer = self.getBorderLayer()
        if self.max_Y > screenH {
            layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
            layer.transform = CATransform3DRotate(layer.transform, CGFloat(M_PI), 0, 0, 1)
            self.y = point.y - self.height
        }
        //调整frame
        let rect = self.frame
        self.layer.mask = layer
        self.layer.anchorPoint = aPoint
        self.frame = rect
        self.layer.setAffineTransform(CGAffineTransform.init(scaleX: 0.01, y: 0.01))
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            self.alpha = 1
            self.backView?.alpha = 0.3
            self.layer.setAffineTransform(CGAffineTransform.init(scaleX: 1.0, y: 1.0))
        }, completion: nil)
        
        
    }
    func hiddenMenu() {
        self.contentTableView?.contentOffset = CGPoint.init(x: 0, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { 
            self.layer.setAffineTransform(CGAffineTransform.init(scaleX: 0.01, y: 0.01))
            self.alpha = 0
            self.backView?.alpha = 0
        }) { (finished) in
            self.backView?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    //自动调整position
    func adjustPosition(point: CGPoint) {
        self.x = point.x - self.width * 0.5
        self.y = point.y + menuMargin
        if self.x < menuMargin {
            self.x = menuMargin
            
        }else if (self.x > screenW - menuMargin - self.width){
            self.x = screenW - menuMargin - self.width
        }
        self.layer.setAffineTransform(CGAffineTransform.init(scaleX: 1.0, y: 1.0))
    }
    //更新frame
    func updateFrameForMenu() {
        var menuView: GDMenuView?
        if self.fatherVC != nil {
            menuView = self.fatherVC?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        if self.secondFather != nil {
            menuView = self.secondFather?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        
        menuView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        menuView?.contentTableView?.height = CGFloat(40) * CGFloat((menuView?.menuDataArr.count)!)
        menuView?.height = CGFloat(40) * CGFloat((menuView?.menuDataArr.count)!) + triangleHeight * 2 - 0.5
        menuView?.layer.mask = menuView?.getBorderLayer()
        menuView?.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        
    }
    
    func getBorderLayer() -> CAShapeLayer {
        let upperLeftCornerCenter = CGPoint.init(x: menuRadius, y: triangleHeight + menuRadius)
        let upperRightCornerCenter = CGPoint.init(x: self.width - menuRadius, y: triangleHeight + menuRadius)
        let bottomLeftCornerCenter = CGPoint.init(x: menuRadius, y: self.height - triangleHeight - menuRadius)
        let bottomRightCornerCenter = CGPoint.init(x: self.width - menuRadius, y: self.height - triangleHeight - menuRadius)
        
        let borderLayer = CAShapeLayer.init()
        borderLayer.strokeColor = UIColor.clear.cgColor
        borderLayer.frame = self.bounds
        
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: CGPoint.init(x: 0, y: triangleHeight + menuRadius))
        bezierPath.addArc(withCenter: upperLeftCornerCenter, radius: menuRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI) * 3 * 0.5, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: arrowPointX! - triangleHeight * 0.7, y: triangleHeight))
        bezierPath.addLine(to: CGPoint.init(x: arrowPointX!, y: 0))
        bezierPath.addLine(to: CGPoint.init(x: arrowPointX! + triangleHeight * 0.7, y: triangleHeight))
        bezierPath.addLine(to: CGPoint.init(x: self.width - menuRadius, y: triangleHeight))
        //
        bezierPath.addArc(withCenter: upperRightCornerCenter, radius: menuRadius, startAngle: CGFloat(M_PI) * 3 * 0.5, endAngle: 0, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: self.width, y: self.height - triangleHeight - menuRadius))
        //
        bezierPath.addArc(withCenter: bottomRightCornerCenter, radius: menuRadius, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: menuRadius, y: self.height - triangleHeight))
        //
        bezierPath.addArc(withCenter: bottomLeftCornerCenter, radius: menuRadius, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: 0, y: triangleHeight + menuRadius))
        bezierPath.lineWidth = 1.0
        //
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        return borderLayer

        
    }
    
    

    
    func showMenuAtPoint(point: CGPoint){
//        let menuView = UIApplication.shared.keyWindow?.viewWithTag(MenuTag) as! GDMenuView
        var menuView: GDMenuView?
        if self.fatherVC != nil {
            menuView = self.fatherVC?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        if self.secondFather != nil {
            menuView = self.secondFather?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        
        
        menuView?.disPlayAtPoint(point: point)
    }
    
    func hidden() {
        var menuView: GDMenuView?
        if self.fatherVC != nil {
            menuView = self.fatherVC?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        if self.secondFather != nil {
            menuView = self.secondFather?.view.viewWithTag(MenuTag) as? GDMenuView
        }
        
        menuView?.hiddenMenu()
    }

    deinit {
        print("GDMenuView销毁")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class GDMenuCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lineView = UIView.init()
        lineView?.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(lineView!)
        self.backgroundColor = UIColor.clear
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        self.textLabel?.textColor = UIColor.white
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.textLabel?.textAlignment = NSTextAlignment.center
    }
    var lineView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView?.frame = CGRect.init(x: 4, y: self.bounds.size.height - 1, width: self.bounds.size.width, height: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


