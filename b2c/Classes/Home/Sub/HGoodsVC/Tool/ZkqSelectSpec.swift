//
//  ZkqSelectSpec.swift
//  OneSwiftProduct
//
//  Created by 张凯强 on 2016/11/4.
//  Copyright © 2016年 zhangkaiqiang. All rights reserved.
//

import UIKit
import SDWebImage
import Masonry
@objc protocol ZkqSelectSpecDelegate:class {
    //选择出的规格模型
    func selectGoodsDetailModel(model: ZkqGoodsDetailModel)
    //将数组传过去
    func sentSelectIndexPathArr(arr: [IndexPath])
    /**页面将要弹出的时候的代理*/
    @objc optional func viewWillDisPlay()
    /**页面出现的时候的代理*/
    @objc optional func viewDidDisPlay()
    /**页面消失的时候的代理*/
    @objc optional func viewDidEndDisPaly()
    /**页面消失然后开始动画*/
    @objc optional func viewHiddenAndBeginAnimation()
    /**加入购物车失败*/
    @objc optional func addShopCarFail()
    
}

enum ZkqSelectSpecType {
    case trueBtn
    case addCarAndBuyBtn
    case addCarBtn
    case buyBtn
}



/**占位图片*/
var placeholderImage: UIImage{
get{
    
    let img = UIImage.init(named: "占位图")
    return img!
}
}

let kSemiModalOverlayTag = 10001
let kSemiModalScreenshotTag = 10002
let kSemiModalModalViewTag = 10003
let kSemiModalDismissButtonTag = 10004
let KSemiModalSecondOverlayTag = 10005
let screenW: CGFloat = UIScreen.main.bounds.size.width
let screenH: CGFloat = UIScreen.main.bounds.size.height
let hiddenBtntag = 100001
/**处理价格*/
func dealPriceInSwift(price: String, firstFont:UIFont, lastFont:UIFont) -> NSMutableAttributedString{

    if (price.characters.count) < 3  {
        return NSMutableAttributedString.init(string: "免费")
    }
    var mutableString: NSMutableAttributedString?
    var finishString: String = String.init(format: "￥%@", price)
    if !price.contains(".") {
        finishString.insert(".", at: price.index(price.endIndex, offsetBy: -1))
    }
    print(finishString)
    if finishString.hasSuffix(".00") {
        let range = finishString.startIndex..<finishString.index(finishString.endIndex, offsetBy: -3)
        finishString = finishString.substring(with: range)
        mutableString = NSMutableAttributedString.init(string: finishString)
        mutableString?.addAttributes([NSFontAttributeName: firstFont], range: NSRange.init(location: 0, length: 1))
    }else{
        if finishString.hasSuffix("0") {
            let range = finishString.startIndex..<finishString.index(finishString.endIndex, offsetBy: -1)
            finishString = finishString.substring(with: range)
            mutableString = NSMutableAttributedString.init(string: finishString)
            mutableString?.addAttributes([NSFontAttributeName: firstFont], range: NSRange.init(location: 0, length: 1))
            mutableString?.addAttributes([NSFontAttributeName: lastFont], range: NSRange.init(location: finishString.characters.count - 1, length: 1))
        }else{
            mutableString = NSMutableAttributedString.init(string: finishString)
            mutableString?.addAttributes([NSFontAttributeName: firstFont], range: NSRange.init(location: 0, length: 1))
            mutableString?.addAttributes([NSFontAttributeName: lastFont], range: NSRange.init(location: finishString.characters.count - 3, length: 2))
        }
    }
    
    return mutableString!
    
}

/**在屏幕上面显示提示语句*/
func alert(message mess:String, timeInterval time: Int) -> (){
    let pro = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    pro.hide(animated: true, afterDelay: TimeInterval(time))
    pro.label.text = mess
    
    pro.mode = MBProgressHUDMode.text
    
}
extension UIImage{
    class func creatImageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndPDFContext()
        return theImage
    }
}

extension UILabel{
    class func creatLabel(_ font: UIFont, textColor: UIColor, backColor: UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = font
        label.textColor = textColor
        label.backgroundColor = backColor
        return label
    }
}

class ZkqSelectSpec: UIView, UICollectionViewDelegate, UICollectionViewDataSource, ZkqSpecStoreFooterDelegate, CAAnimationDelegate {

    init(frame: CGRect, viewType: ZkqSelectSpecType, goods_id: String) {
        super.init(frame: frame)
        self.setContainer()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        switch viewType {
        case .trueBtn:
            let frame = CGRect.init(x: 0, y: screenH - 50, width: screenW, height: 50)
            trueBtn.frame = frame
            self.addSubview(trueBtn)
            break
        case .addCarAndBuyBtn:
            let frame1 = CGRect.init(x: 0, y: screenH - 50, width: screenW/2.0, height: 50)
            let frame2 = CGRect.init(x: screenW/2.0, y: screenH - 50, width: screenW/2.0, height: 50)
            addBtn.frame = frame1
            buyBtn.frame = frame2
            self.addSubview(addBtn)
            self.addSubview(buyBtn)
            break
        case .addCarBtn:
            let frame = CGRect.init(x: 0, y: screenH - 50, width: screenW, height: 50)
            addBtn.frame = frame
            self.addSubview(addBtn)
            break
        case .buyBtn:
            let frame = CGRect.init(x: 0, y: screenH - 50, width: screenW, height: 50)
            buyBtn.frame = frame
            self.addSubview(buyBtn)
            break
        
        }
        
        self.presentSemi(goods_id: goods_id)
    }
    //动画效果
    weak var targetView: GDNormalVC?
    var isScreenShot: Bool?
    func presentSemiView(semiView: UIView, backView: UIView?, target: GDNormalVC?, isScreenShot: Bool) {
        targetView = target
        self.isScreenShot = isScreenShot
        if !((target?.view?.subviews.contains(semiView))!) {
            //设置遮盖模板
            var overlay: UIView? = backView
            if overlay == nil {
                overlay = UIView.init()
            }
            overlay?.frame = CGRect.init(x: 0, y: 0, width: screenW, height: screenH)
            if isScreenShot {
                overlay?.backgroundColor = UIColor.black
            }else{
                overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            }
            
            overlay?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            overlay?.tag = kSemiModalOverlayTag
            overlay?.isUserInteractionEnabled = false
            if isScreenShot {
                let image = addOrUpdateParentScreenshotInView(superView: overlay!, target: (target?.view!)!)
                let msk = CAShapeLayer.init()
                msk.frame = CGRect.init(x: 0, y: 0, width: image.frame.size.width, height: image.frame.size.height)
                msk.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
                image.layer.addSublayer(msk)
                image.layer.add(animationGroupForward(_froward: true), forKey: "push")
                
                
                
                
            }else {
                overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            }
            
            target?.view?.addSubview(overlay!)
            target?.view?.addSubview(semiView)
            semiView.tag = kSemiModalModalViewTag
            semiView.backgroundColor = UIColor.clear
            semiView.frame = CGRect.init(x: 0, y: screenH, width: screenW, height: screenH)
            UIView.animate(withDuration: 0.5, animations: { 
                semiView.frame = CGRect.init(x: 0, y: 0, width: screenW, height: screenH)
                if isScreenShot {
                    
                    
                }else {
                    overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                }
                }, completion: { (finished) in
                    
            })
            
            
            
        }
    }
    
    func addOrUpdateParentScreenshotInView(superView: UIView, target: UIView) -> UIImageView{
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: screenW, height: screenH), true, 0)
        //afterScreenUpdates屏幕不闪烁
        target.drawHierarchy(in: CGRect.init(x: 0, y: 0, width: screenW, height: screenH), afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageview = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH))
        imageview.image = image
        imageview.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        imageview.tag = kSemiModalScreenshotTag
        superView.addSubview(imageview)
        return imageview
        
    }
    
    
    
    func animationGroupForward(_froward: Bool) -> CAAnimationGroup {
        
        let animation = CABasicAnimation.init(keyPath: "transform")
        //tovalue所改变属性结束时的值
        animation.toValue = NSValue.init(caTransform3D: transform1())
        animation.duration = 0.3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        
        
        ////
        let animation2 = CABasicAnimation.init(keyPath: "transform")
        animation2.toValue = NSValue.init(caTransform3D: _froward ? transform2():CATransform3DIdentity)
        animation2.beginTime = animation.duration
        animation2.duration = animation.duration
        animation2.fillMode = kCAFillModeForwards
        animation2.isRemovedOnCompletion = false
        
        
        ///
        let group = CAAnimationGroup.init()
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        group.duration = animation.duration * 2
        group.animations = [animation, animation2]
        
        return group
        
    }
    func transform1() -> CATransform3D {
        
        var transform1 = CATransform3DIdentity
        transform1.m34 = -1.0/900
        //缩小
        transform1 = CATransform3DScale(transform1, 0.9, 0.9, 1)
        //x轴旋转
        let angle = 15.0 * M_PI/180.0
        transform1 = CATransform3DRotate(transform1, CGFloat(angle), 1, 0, 0)
        return transform1
    }
    func transform2() -> CATransform3D {
        var transform2 = CATransform3DIdentity
        transform2.m34 = transform1().m34
        transform2 = CATransform3DTranslate(transform2, 0, screenH * (-0.08), 0)
        transform2 = CATransform3DScale(transform2, 0.8, 0.8, 1)
        return transform2
    }

    func viewRemoveFormSuperView(btn: UIButton) {
        self.searchGoodsDetailModelInGoodsDetailArr { (goodsDetailModel) in
            if delegate != nil {
                delegate?.selectGoodsDetailModel(model: goodsDetailModel)
            }
        }
        
        if delegate != nil {
            delegate?.sentSelectIndexPathArr(arr: selectedIndexPath)
            delegate?.viewDidEndDisPaly!()
        }
        if let isShot = isScreenShot {
            if isShot {
                let screenshotView = targetView?.view?.viewWithTag(kSemiModalScreenshotTag)
                screenshotView?.layer.add(animationGroupForward(_froward: false), forKey: "hidden")
            }
        }
        let overlay = targetView?.view?.viewWithTag(kSemiModalOverlayTag)
        let semiView = targetView?.view?.viewWithTag(kSemiModalModalViewTag)
        if !self.isScreenShot! {
            overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            if self.isScreenShot! {
                
            }else {
                overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            }
            semiView?.frame = CGRect.init(x: 0, y: screenH, width: screenW, height: screenH)
            
        }) { (finished) in
            semiView?.removeFromSuperview()
            overlay?.removeFromSuperview()
            let bo: Bool = (btn == self.trueBtn) || (btn == self.addBtn)
            if bo {
                self.delegate?.viewHiddenAndBeginAnimation!()
            }else {
                self.delegate?.addShopCarFail!()
            }
            if self.isScreenShot! {
                
            }
            
        }
    }
    
    
    

    lazy var addBtn: UIButton = {
        let btn: UIButton = UIButton.init()
        self.configmentBtn(btn: btn, title: "加入购物车", state: UIControlState.normal, font: 15, titleColor: "ffffff", backColor: "f8bb18", action: #selector(addshopCar(btn:)))
        return btn
    }()
    //加入购物车的方法
    func addshopCar(btn: UIButton) {
        self.selectGoodsModel?.reserced = researed
        if UserInfo.share().isLogin {
            if (self.selectSpecModel?.goods_id != nil) && (self.selectGoodsModel?.sub_id != nil) {
                let paramete  = ["memeber_id": UserInfo.share().member_id, "goods_id": self.selectSpecModel?.goods_id, "num": self.selectGoodsModel?.reserced, "spec": self.selectGoodsModel?.sub_id, "now": "0"]
                GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.POST, urlString: "ShopCart", parameters: paramete as [String: AnyObject], success: { (result) in
                    self.viewRemoveFormSuperView(btn: btn)
                }, failure: { (error) in
                    self.delegate?.addShopCarFail!()
                })
            }
            
            
        }else {
            let login = LoginNavVC.init(loginNavVC: ())
            GDKeyVC.share.present(login!, animated: true, completion: nil)
        }
    }
    //立即购买按钮
    lazy var buyBtn: UIButton = {
        let btn: UIButton = UIButton.init()
        self.configmentBtn(btn: btn, title: "立即购买", state: UIControlState.normal, font: 15, titleColor: "ffffff", backColor: "ff621c", action: #selector(buyButtonClick(btn:)))
        return btn
    }()
    //立即购买
    func buyButtonClick(btn: UIButton) {
        self.selectGoodsModel?.reserced = researed
        if UserInfo.share().isLogin {
            if (self.selectSpecModel?.goods_id != nil) && (self.selectGoodsModel?.sub_id != nil) {
                let paramete  = ["memeber_id": UserInfo.share().member_id, "goods_id": self.selectSpecModel?.goods_id, "num": self.selectGoodsModel?.reserced, "spec": self.selectGoodsModel?.sub_id, "now": "1"]
                GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.POST, urlString: "ShopCart", parameters: paramete as [String: AnyObject], success: { (result) in
                    if result.status < 0 {
                        if result.msg != nil {
                            alert(message: result.msg!, timeInterval: 1)
                        }
                        
                    }else {
                        let vcGood: SVCGoods = SVCGoods.init(dict: nil)
                        if let dict = result.data as? [String: AnyObject] {
                            vcGood.id = dict["cart_id"] as! String
                            vcGood.number = NSString.init(format: "%@", (self.selectGoodsModel?.reserced)!).integerValue
                            if self.selectGoodsModel?.price != nil {
                                vcGood.price = NSString.init(format: "%@", (self.selectGoodsModel?.price)!).integerValue
                            }
                            if self.selectSpecModel?.shop_id != nil {
                                vcGood.shop_id = NSString.init(format: "%@", (self.selectSpecModel?.shop_id)!).integerValue
                            }
                            let confirmorder = ConfirmOrderVC.init()
                            confirmorder.goodsIDs = [vcGood]
                            btn.isEnabled = true
                            self.targetView?.navigationController?.pushViewController(confirmorder, animated: true)
                        }
                        
                    }
                }, failure: { (error) in
                    self.delegate?.addShopCarFail!()
                })
            }
            
            
        }else {
            let login = LoginNavVC.init(loginNavVC: ())
            GDKeyVC.share.present(login!, animated: true, completion: nil)
        }
    }
    //确认购买按钮
    lazy var trueBtn: UIButton = {
        let btn: UIButton = UIButton.init()
        self.configmentBtn(btn: btn, title: "确定", state: UIControlState.normal, font: 15, titleColor: "ffffff", backColor: "ff621c", action: #selector(tureBtnClick(btn:)))
        
        return btn
    }()
    //确定按钮的点击方法
    func tureBtnClick(btn: UIButton) {
        let rect = goodsImage.convert(goodsImage.frame, to: self)
        carAnimView.frame = rect
        self.addSubview(carAnimView)
        
        
        //起点
        let carCenter = carAnimView.center
        // 终点
        let endpath = CGPoint.init(x: screenW - 90, y: 45)
        
        let path = UIBezierPath.init()
        
        path.move(to: carCenter)
        
        path.addQuadCurve(to: endpath, controlPoint: CGPoint.init(x: carCenter.x, y: 40))
        path.lineCapStyle = CGLineCap.round
        path.lineJoinStyle = CGLineJoin.round
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber.init(value: M_PI * 11.0)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 0
        carAnimView.layer.add(rotationAnimation, forKey: "rotationAnimation")

        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        animation.path = path.cgPath
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.duration = 1.0
        animation.delegate = self
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        carAnimView.layer.add(animation, forKey: "buy")
        
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        UIView.animate(withDuration: 1.0) { 
            self.carAnimView.bounds = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        }
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        carAnimView.removeFromSuperview()
    }
    
    
    //设置按钮
    func configmentBtn(btn: UIButton, title: String, state: UIControlState, font: CGFloat, titleColor: String, backColor: String, action: Selector) {
        btn.backgroundColor = UIColor.colorWithHexStringSwift(backColor)
        btn.setTitle(title, for: state)
        btn.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(font))
        btn.setTitleColor(UIColor.colorWithHexStringSwift(titleColor), for: state)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //布局子视图
    func setContainer() {
        self.setTopContainer()
    }
    //
    
    private var dataArray: [ZkqSpecModel] = [ZkqSpecModel]()
    private var goodsDetailArr: [ZkqGoodsDetailModel] = [ZkqGoodsDetailModel]()

    var carAnimView: UIImageView = UIImageView.init()
    lazy var selectedIndexPath: [IndexPath] = {
        var arr = [IndexPath]()
        if let spec = self.selectSpecModel?.spec {
            var i: Int = 0
            for specModel in spec {
                var j: Int = 0
                var selectIndex: IndexPath = IndexPath.init()
                if let typeDetailModelArr = specModel.typeDetail {
                    for typeModel in typeDetailModelArr {
                        
                        if typeModel.defaultSelect?.intValue == 1 {
                            typeModel.isSelected = true
                            selectIndex = IndexPath.init(row: j, section: i)
                        }
                        
                        j += 1
                    }
                    
                }
                arr.append(selectIndex)
                i += 1
                
            }
        }
        return arr
        
    }()
    
    var block : (() -> Void)?
    var selectSpecModel: ZkqSelectSpecModel?
    func presentSemi(goods_id: String) {
        self.delegate?.viewWillDisPlay!()
        GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.GET, urlString: "SelectSpec", parameters: ["goods_id":goods_id as AnyObject], success: { (result) in
            if let dict = result.data as? [String: AnyObject] {
                self.selectSpecModel = ZkqSelectSpecModel.init(dict: dict)
                
                //过滤数据源中的空数据
                self.filteringTheNullDataInTheDataSource(selectSpecModel: self.selectSpecModel!)
                //如果选中数组中没有数据
                if self.selectedIndexPath.count < 1{
                    if self.delegate != nil {
                        self.delegate?.viewDidEndDisPaly!()
                    }
//
                    alert(message: "卖家没有设置规格，如购买请联系卖家", timeInterval: 1)
                    return
                }
                for index in self.selectedIndexPath {
                    if index.count == 0 {
                        
                        //处理没有默认选中的情况
                        self.dealDefaultSelectIndexpath(selectSpecModel: self.selectSpecModel!)
                        break
                    }
                }
                
                if let spec = self.selectSpecModel?.spec {
                    self.dataArray = spec
                    self.goodsDetailArr = (self.selectSpecModel?.goodsDeatil!)!
                    self.flowLayout?.dataArray = spec
                    self.goodsTitle.text = self.selectSpecModel?.short_name!
                    
                    self.searchGoodsDetailModelInGoodsDetailArr(complited: { (goodsDetailModel) in
                        self.goodsImage.sd_setImage(with: imgStrConvertToUrl(goodsDetailModel.image!), placeholderImage: placeholderImage)
                        self.carAnimView.sd_setImage(with: imgStrConvertToUrl(goodsDetailModel.image!), placeholderImage: placeholderImage)
                        self.priceLabel.attributedText  = dealPriceInSwift(price: goodsDetailModel.price!, firstFont: UIFont.systemFont(ofSize: 10), lastFont: UIFont.systemFont(ofSize: 10))
                    })
                    self.col?.reloadData()
                }
                
                if self.block != nil {
                    self.block!()
                }
                
                
            }
            
            
        }) { (error) in
            
        }
    }
    //过滤数据源中的空数据
    func filteringTheNullDataInTheDataSource(selectSpecModel: ZkqSelectSpecModel) {
        if let specArr = selectSpecModel.spec {
            var sectionArr:[ZkqSpecModel] = [ZkqSpecModel]()
            for section in 0...(specArr.count - 1) {
                let specModel = specArr[section]
                if let typeDetailArr = specModel.typeDetail {
                    var isAdd = false
                    var rowArr:[ZkqTypeDetailModel] = [ZkqTypeDetailModel]()
                    for row in 0...(typeDetailArr.count - 1) {
                        let subTypeDetailModel = typeDetailArr[row]
                        if !self.judgeNSObjectIsNullOrNil(object: subTypeDetailModel.quality as AnyObject) {
                            rowArr.append(subTypeDetailModel)
                            isAdd = true
                        }
                    }
                    specModel.typeDetail = rowArr
                    if isAdd {
                        sectionArr.append(specModel)
                    }
                }
                
                
            }
            selectSpecModel.spec = sectionArr
        }
    }
    //判断数据是不是nil或者是null
    func judgeNSObjectIsNullOrNil(object: AnyObject) -> Bool {
        var isOrNO = false
        if object is NSNull {
            isOrNO = true
        }
        
        return isOrNO
    }
    //处理没有默认选中的情况
    func dealDefaultSelectIndexpath(selectSpecModel: ZkqSelectSpecModel) {
        //数据源数组
        if let dataArr = selectSpecModel.spec {
            //数据库数组
            if let goodsArr = selectSpecModel.goodsDeatil {
                
                for section in 0...(dataArr.count - 1) {
                    //获取组数据
                    let typeModel = dataArr[section]
                    if let typeDetailArr = typeModel.typeDetail {
                        //获取列数据
                        for row in 0...(typeDetailArr.count - 1) {
                            let typeDetailModel = typeDetailArr[row]
                            var isBreak: Bool = false
                            for goodsModel in goodsArr {
                                switch section {
                                case 0:
                                    if goodsModel.spec1 == typeDetailModel.quality {
                                        if let str = goodsModel.reserced {
                                            if let stock = NSInteger(str) {
                                                if stock > 0 {
                                                    isBreak = true
                                                    self.selectedIndexPath.replaceSubrange(Range(section..<(section + 1)), with: [IndexPath.init(row: row, section: section)])
                                                }
                                            }
                                        }
                                    }
                                    break
                                case 1:
                                    let firstIndex = self.selectedIndexPath[0]
                                    let first = dataArr[firstIndex.section]
                                    let firstModel = first.typeDetail?[firstIndex.row]
                                    
                                    let oneBool = goodsModel.spec1 == firstModel?.quality
                                    let twoBool = goodsModel.spec2 == typeDetailModel.quality
                                    if (oneBool && twoBool) {
                                        if let str = goodsModel.reserced {
                                            if let stock = NSInteger(str) {
                                                if stock > 0 {
                                                    isBreak = true
                                                    self.selectedIndexPath.replaceSubrange(Range(section..<(section + 1)), with: [IndexPath.init(row: row, section: section)])
                                                }
                                            }
                                        }
                                    }
                                    break
                                case 2:
                                    let firstIndex = self.selectedIndexPath[0]
                                    let first = dataArr[firstIndex.section]
                                    let firstModel = first.typeDetail?[firstIndex.row]
                                    
                                    let secondIndex = self.selectedIndexPath[1]
                                    let second = dataArr[secondIndex.section]
                                    let secondModel = second.typeDetail?[firstIndex.row]
                                    
                                    let oneBool = goodsModel.spec1 == firstModel?.quality
                                    let twoBool = goodsModel.spec2 == secondModel?.quality
                                    let threeBool = goodsModel.spec3 == typeDetailModel.quality
                                    if (oneBool && twoBool && threeBool) {
                                        if let str = goodsModel.reserced {
                                            if let stock = NSInteger(str) {
                                                if stock > 0 {
                                                    isBreak = true
                                                    self.selectedIndexPath.replaceSubrange(Range(section..<(section + 1)), with: [IndexPath.init(row: row, section: section)])
                                                }
                                            }
                                        }
                                    }
                                    break
                                case 3:
                                    let firstIndex = self.selectedIndexPath[0]
                                    let first = dataArr[firstIndex.section]
                                    let firstModel = first.typeDetail?[firstIndex.row]
                                    
                                    let secondIndex = self.selectedIndexPath[1]
                                    let second = dataArr[secondIndex.section]
                                    let secondModel = second.typeDetail?[firstIndex.row]
                                    
                                    let threeIndex = self.selectedIndexPath[2]
                                    let three = dataArr[threeIndex.section]
                                    let threeModel = three.typeDetail?[threeIndex.row]
                                    
                                    let oneBool = goodsModel.spec1 == firstModel?.quality
                                    let twoBool = goodsModel.spec2 == secondModel?.quality
                                    let threeBool = goodsModel.spec3 == threeModel?.quality
                                    let fourBool = goodsModel.spec4 == typeDetailModel.quality
                                    if (oneBool && twoBool && threeBool && fourBool) {
                                        if let str = goodsModel.reserced {
                                            if let stock = NSInteger(str) {
                                                if stock > 0 {
                                                    isBreak = true
                                                    self.selectedIndexPath.replaceSubrange(Range(section..<(section + 1)), with: [IndexPath.init(row: row, section: section)])
                                                }
                                            }
                                        }
                                    }
                                    break
                                case 4:
                                    let firstIndex = self.selectedIndexPath[0]
                                    let first = dataArr[firstIndex.section]
                                    let firstModel = first.typeDetail?[firstIndex.row]
                                    
                                    let secondIndex = self.selectedIndexPath[1]
                                    let second = dataArr[secondIndex.section]
                                    let secondModel = second.typeDetail?[firstIndex.row]
                                    
                                    let threeIndex = self.selectedIndexPath[2]
                                    let three = dataArr[threeIndex.section]
                                    let threeModel = three.typeDetail?[threeIndex.row]
                                    
                                    let fourIndex = self.selectedIndexPath[3]
                                    let four = dataArr[fourIndex.section]
                                    let fourModel = four.typeDetail?[fourIndex.row]
                                    
                                    
                                    let oneBool = goodsModel.spec1 == firstModel?.quality
                                    let twoBool = goodsModel.spec2 == secondModel?.quality
                                    let threeBool = goodsModel.spec3 == threeModel?.quality
                                    let fourBool = goodsModel.spec4 == fourModel?.quality
                                    let fiveBool = goodsModel.spec5 == typeDetailModel.quality
                                    
                                    if (oneBool && twoBool && threeBool && fourBool && fiveBool) {
                                        if let str = goodsModel.reserced {
                                            if let stock = NSInteger(str) {
                                                if stock > 0 {
                                                    isBreak = true
                                                    self.selectedIndexPath.replaceSubrange(Range(section..<(section + 1)), with: [IndexPath.init(row: row, section: section)])
                                                }
                                            }
                                        }
                                    }
                                    break
                                default:
                                    break
                                }
                                if isBreak {
                                    break
                                }
                            }
                            if isBreak {
                                break
                            }
                        }
                    }
                    
                }
                
                
                //
            }
        }
    }

    
    
    
    
    var hiddenBtn: UIButton?
    var midelView: UIView?
    var col: UICollectionView?
    var bottomView: UIView?
    var goodsImage: UIImageView = UIImageView.init()
    var cancleBtn: UIButton = UIButton.init()
    
    var goodsTitle: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.clear)
    var priceLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 14), textColor: THEMECOLOR, backColor: UIColor.clear)
    var storeLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 14), textColor: THEMECOLOR, backColor: UIColor.clear)
    
    var flowLayout: ZkqSelectSpecColFlowlayout?
    weak var delegate: ZkqSelectSpecDelegate?
    func setTopContainer() {
        hiddenBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH * 0.35))
        self.addSubview(hiddenBtn!)
        hiddenBtn?.alpha = 1.0
        hiddenBtn?.tag = hiddenBtntag
        hiddenBtn?.addTarget(self, action: #selector(viewRemoveFormSuperView(btn:)), for: UIControlEvents.touchUpInside)
        //布局中间的视图
        midelView = UIView.init(frame: CGRect.init(x: 0, y: (hiddenBtn?.frame.size.height)!, width: screenW, height: 100))
        
        self.addSubview(midelView!)
        midelView?.backgroundColor = UIColor.white
//        midelView?.layer.shadowColor = UIColor.black.cgColor
//        midelView?.layer.shadowOffset = CGSize.init(width: 0, height: 3)
//        midelView?.layer.shadowOpacity = 1
//        midelView?.layer.shadowRadius = 5
        
        
        midelView?.addSubview(goodsImage)
        
        
        goodsImage.layer.shadowColor = UIColor.black.cgColor
        goodsImage.layer.shadowOffset = CGSize.init(width: 0, height: -3)
        goodsImage.layer.shadowOpacity = 1
        goodsImage.layer.shadowRadius = 5
        goodsImage.frame = CGRect.init(x: 10, y: -10, width: GDCalculator.GDAdaptation(80), height: GDCalculator.GDAdaptation(80))
        goodsImage.layer.masksToBounds = true
        goodsImage.layer.cornerRadius = 6
        goodsImage.layer.borderWidth = 1
        goodsImage.layer.borderColor = UIColor.gray.cgColor
        goodsImage.backgroundColor = UIColor.white
        
        midelView?.addSubview(cancleBtn)
        cancleBtn.addTarget(self, action: #selector(cancle(btn:)), for: UIControlEvents.touchUpInside)
        cancleBtn.setImage(UIImage.init(named: "icon_close"), for: UIControlState.normal)
        cancleBtn.adjustsImageWhenHighlighted = false
        cancleBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.midelView?.mas_top)?.setOffset(0)
            make?.right.equalTo()(self.midelView?.mas_right)?.setOffset(0)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
        }
        //布局商品描述
        midelView?.addSubview(goodsTitle)
        goodsTitle.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.midelView?.mas_top)?.setOffset(5)
            make?.left.equalTo()(self.goodsImage.mas_right)?.setOffset(5)
            make?.right.equalTo()(self.cancleBtn.mas_left)?.setOffset(0)
            
        }
        goodsTitle.sizeToFit()
        goodsTitle.numberOfLines = 2
        
        midelView?.addSubview(priceLabel)
        //布局商品价格
        priceLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.goodsTitle.mas_bottom)?.setOffset(5)
            make?.left.equalTo()(self.goodsImage.mas_right)?.setOffset(5)
            make?.right.equalTo()(self.cancleBtn.mas_left)?.setOffset(0)
        }
        priceLabel.sizeToFit()
        priceLabel.numberOfLines = 2
        
        //布局col
        flowLayout = ZkqSelectSpecColFlowlayout.init()
        
        let colY = (midelView?.frame.size.height)! + (hiddenBtn?.frame.size.height)!
        col = UICollectionView.init(frame: CGRect.init(x: 0, y: colY, width: self.frame.size.width, height: screenH - colY - 50 ), collectionViewLayout: flowLayout!)
        self.addSubview(col!)
        col?.delegate = self
        col?.dataSource = self
        col?.bounces = true
        col?.showsVerticalScrollIndicator = false
        col?.showsHorizontalScrollIndicator = false
        col?.register(ZkqSpecItem.self, forCellWithReuseIdentifier: "ZkqSpecItem")
        col?.register(ZkqSpecColHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "ZkqSpecColHeader")
        col?.register(ZkqSpecColNormalFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ZkqSpecColNormalFooter")
        col?.register(ZkqSpecStoreFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ZkqSpecStoreFooter")
        col?.backgroundColor = UIColor.white
        col?.allowsMultipleSelection = true
        
    }
    
    
    //取消按钮
    func cancle(btn: UIButton) {
        self.viewRemoveFormSuperView(btn: btn)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let specModel = (dataArray[section]) as ZkqSpecModel
        if let count = specModel.typeDetail {
            return count.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZkqSpecItem", for: indexPath) as! ZkqSpecItem
        
        var goodsDetailSpec1: ZkqTypeDetailModel?
        var goodsDetailSpec2: ZkqTypeDetailModel?
        var goodsDetailSpec3: ZkqTypeDetailModel?
        var goodsDetailSpec4: ZkqTypeDetailModel?
        var goodsDetailSpec5: ZkqTypeDetailModel?
        for index  in selectedIndexPath {
            if indexPath.section != index.section {
                let specModel = dataArray[index.section] as ZkqSpecModel
                //现在选中的规格
                let typedetailModel = (specModel.typeDetail?[index.item])! as ZkqTypeDetailModel
                switch index.section {
                case 0:
                    goodsDetailSpec1 = typedetailModel
                    break
                case 1:
                    goodsDetailSpec2 = typedetailModel
                    break
                case 2:
                    goodsDetailSpec3 = typedetailModel
                    break
                case 3:
                    goodsDetailSpec4 = typedetailModel
                    break
                case 4:
                    goodsDetailSpec5 = typedetailModel
                default:
                    break
                }
            }else {
                let specModel = (dataArray[indexPath.section]) as ZkqSpecModel
                let typedetailModel = (specModel.typeDetail?[indexPath.item])! as ZkqTypeDetailModel
                switch indexPath.section {
                case 0:
                    goodsDetailSpec1 = typedetailModel
                    break
                case 1:
                    goodsDetailSpec2 = typedetailModel
                    break
                case 2:
                    goodsDetailSpec3 = typedetailModel
                    break
                case 3:
                    goodsDetailSpec4 = typedetailModel
                    break
                case 4:
                    goodsDetailSpec5 = typedetailModel
                default:
                    break
                }
            }
            let specModel = (dataArray[index.section]) as ZkqSpecModel
            let typedetailModel = (specModel.typeDetail?[index.item])! as ZkqTypeDetailModel
            typedetailModel.isSelected = true
        
        }
        
        
        let specModel = (dataArray[indexPath.section]) as ZkqSpecModel
        let typedetailModel = (specModel.typeDetail?[indexPath.item])! as ZkqTypeDetailModel
        for goodsDetailModel in goodsDetailArr {
            if (goodsDetailSpec1?.spec1 == goodsDetailModel.spec1) && (goodsDetailSpec2?.spec2 == goodsDetailModel.spec2) && (goodsDetailSpec3?.spec3 == goodsDetailModel.spec3) && (goodsDetailSpec4?.spec4 == goodsDetailModel.spec4) && (goodsDetailSpec5?.spec4 == goodsDetailModel.spec5)  {
                typedetailModel.reserced = NSNumber.init(value: Int(goodsDetailModel.reserced!)!)
            }
        }
        
        cell.specQualityModel = typedetailModel
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //选出之前被选中的cell的模型
        let beforeIndexPath = selectedIndexPath[indexPath.section]
        let selectSpecModel = dataArray[beforeIndexPath.section] as ZkqSpecModel
        let selectTypeDetailModel = (selectSpecModel.typeDetail?[beforeIndexPath.item])! as ZkqTypeDetailModel
        selectTypeDetailModel.isSelected = false
        
        
        selectedIndexPath.replaceSubrange(Range(indexPath.section..<(indexPath.section + 1)), with: [indexPath])
        
        
        
        let specModel = (dataArray[indexPath.section]) as ZkqSpecModel
        let typedetailModel = (specModel.typeDetail?[indexPath.item])! as ZkqTypeDetailModel
        typedetailModel.isSelected = true
        col?.reloadData()
        
        self.searchGoodsDetailModelInGoodsDetailArr { (goodsDetailModel) in
            let newGoodsDetailModel = ZkqGoodsDetailModel.init(dict: ["data": "" as AnyObject])
            newGoodsDetailModel.spec1 = goodsDetailModel.spec1
            newGoodsDetailModel.spec2 = goodsDetailModel.spec2
            newGoodsDetailModel.spec3 = goodsDetailModel.spec3
            newGoodsDetailModel.spec4 = goodsDetailModel.spec4
            newGoodsDetailModel.spec5 = goodsDetailModel.spec5
            newGoodsDetailModel.reserced = researed
            newGoodsDetailModel.image = goodsDetailModel.image
            newGoodsDetailModel.price = goodsDetailModel.price
            newGoodsDetailModel.sub_id = goodsDetailModel.sub_id
            self.goodsImage.sd_setImage(with: imgStrConvertToUrl(goodsDetailModel.image!)!, placeholderImage: placeholderImage)
            self.carAnimView.sd_setImage(with: imgStrConvertToUrl(goodsDetailModel.image!), placeholderImage: placeholderImage)
            self.priceLabel.attributedText = dealPriceInSwift(price: goodsDetailModel.price!, firstFont: UIFont.systemFont(ofSize: 10), lastFont: UIFont.systemFont(ofSize: 10))
            if delegate != nil {
                delegate?.selectGoodsDetailModel(model: newGoodsDetailModel)
            }
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let specModel = dataArray[indexPath.section] as ZkqSpecModel
            let reusableView: ZkqSpecColHeader = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ZkqSpecColHeader", for: indexPath) as? ZkqSpecColHeader)!
            reusableView.specModel = specModel
            return reusableView
            
        }else{
            if indexPath.section == (dataArray.count - 1) {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ZkqSpecStoreFooter", for: indexPath) as! ZkqSpecStoreFooter
                
                self.searchGoodsDetailModelInGoodsDetailArr(complited: { (goodsDetailModel) in
                    footer.countStr = goodsDetailModel.reserced!
                })
                footer.delegate = self
                //设置数量
                return footer
                
            }else {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ZkqSpecColNormalFooter", for: indexPath)
                return footer
            }
        }
        return UICollectionReusableView.init()
        
    }
    func searchGoodsDetailModelInGoodsDetailArr(complited: (_ goodsModel: ZkqGoodsDetailModel) -> ()) {
        var goodsDetailSpec1: ZkqTypeDetailModel?
        var goodsDetailSpec2: ZkqTypeDetailModel?
        var goodsDetailSpec3: ZkqTypeDetailModel?
        var goodsDetailSpec4: ZkqTypeDetailModel?
        var goodsDetailSpec5: ZkqTypeDetailModel?
        self.selectGoodsModel = ZkqGoodsDetailModel.init(dict: nil)
        for index  in selectedIndexPath {
            let specModel = dataArray[index.section] as ZkqSpecModel
            //现在选中的规格
            let typedetailModel = (specModel.typeDetail?[index.item])! as ZkqTypeDetailModel
            switch index.section {
            case 0:
                goodsDetailSpec1 = typedetailModel
                break
            case 1:
                goodsDetailSpec2 = typedetailModel
                break
            case 2:
                goodsDetailSpec3 = typedetailModel
                break
            case 3:
                goodsDetailSpec4 = typedetailModel
                break
            case 4:
                goodsDetailSpec5 = typedetailModel
            default:
                break
            }
            
        }
        var bo: Bool?
        for goodsDetailModel in goodsDetailArr {
            
            switch self.selectedIndexPath.count {
            case 1:
                let one = goodsDetailModel.spec1 == goodsDetailSpec1?.spec1
                bo = one
                break
            case 2:
                let one = goodsDetailModel.spec1 == goodsDetailSpec1?.spec1
                let two = goodsDetailModel.spec2 == goodsDetailSpec2?.spec2
                bo = one && two
                break

            case 3:
                let one = goodsDetailModel.spec1 == goodsDetailSpec1?.spec1
                let two = goodsDetailModel.spec2 == goodsDetailSpec2?.spec2
                let three = goodsDetailModel.spec3 == goodsDetailSpec3?.spec3
                bo = one && two && three
                break

            case 4:
                let one = goodsDetailModel.spec1 == goodsDetailSpec1?.spec1
                let two = goodsDetailModel.spec2 == goodsDetailSpec2?.spec2
                let three = goodsDetailModel.spec3 == goodsDetailSpec3?.spec3
                let four = goodsDetailModel.spec4 == goodsDetailSpec4?.spec4
                bo = one && two && three && four
                break

            case 5:
                let one = goodsDetailModel.spec1 == goodsDetailSpec1?.spec1
                let two = goodsDetailModel.spec2 == goodsDetailSpec2?.spec2
                let three = goodsDetailModel.spec3 == goodsDetailSpec3?.spec3
                let four = goodsDetailModel.spec4 == goodsDetailSpec4?.spec4
                let five = goodsDetailModel.spec5 == goodsDetailSpec5?.spec5
                bo = one && two && three && four && five
                break

            default:
                break
            }
            if let b = bo {
                if b {
                    self.selectGoodsModel?.spec1 = goodsDetailModel.spec1
                    self.selectGoodsModel?.spec2 = goodsDetailModel.spec2
                    self.selectGoodsModel?.spec3 = goodsDetailModel.spec3
                    self.selectGoodsModel?.spec4 = goodsDetailModel.spec4
                    self.selectGoodsModel?.spec5 = goodsDetailModel.spec5
                    self.selectGoodsModel?.image = goodsDetailModel.image
                    self.selectGoodsModel?.price = goodsDetailModel.price
                    self.selectGoodsModel?.sub_id = goodsDetailModel.sub_id
                    if let url = goodsDetailModel.image {
                        self.goodsImage.sd_setImage(with: imgStrConvertToUrl(url), placeholderImage: placeholderImage, options: SDWebImageOptions.cacheMemoryOnly)
                    }
                    if let price = goodsDetailModel.price {
                        self.priceLabel.attributedText = dealPriceInSwift(price: price, firstFont: UIFont.systemFont(ofSize: 10), lastFont: UIFont.systemFont(ofSize: 10))
                    }
                    
                    complited(goodsDetailModel)
                    return
                }
            }
        }
        
        
        
        
        
        
    }
    var selectGoodsModel: ZkqGoodsDetailModel?
    
   
    var researed: String = "1"
    
    func addNumberOfStorewith(num: String) {
        researed = num
    }
    
    func subtructNumberOfStore(num: String) {
        researed = num
    }
    
    
    
    
    
    deinit {
        mylog("selectSpecView  ---------   销毁")
    }
    
}





//布局类
class ZkqSelectSpecColFlowlayout: UICollectionViewFlowLayout {
    var dataArray: [ZkqSpecModel] = [ZkqSpecModel]() {
        didSet{
            self.LayoutAttributes.removeAll()
        }
    }
    //滑动距离
    var contentsizeHeight: CGFloat = 0.0
    //布局属性数组
    var LayoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    //准备布局
    override func prepare() {
        
        //组头高度
        let headerH: CGFloat = 40.0
        //组尾高度
        let footerH: CGFloat = 1.0
        //距离组头的距离
        let topMargin: CGFloat = 15.0
        //每个item之间的间隔
        let itemMargin: CGFloat = 10.0
        //行间距
        let lineMargin: CGFloat = 15.0
        //距离左边屏幕的距离
        let leftPadding: CGFloat = 10.0
        //布局的总宽度
        var totalW: CGFloat = 0.0
        //布局的总高度
        var totalH: CGFloat = 0.0
        //剩余的宽度
        var leaveW: CGFloat = 0.0
        if dataArray.count == 0 {
            return
        }
        for index in 0...(dataArray.count - 1) {
            let specModel = dataArray[index] as ZkqSpecModel
            if let typedetailArr = specModel.typeDetail {
                //布局组头
                let headerAtt = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath.init(item: 0, section: index))
                headerAtt.frame = CGRect.init(x: 0, y: totalH, width: screenW, height: headerH)
                LayoutAttributes.append(headerAtt)
                //重新给totalH赋值
                totalH += headerH + topMargin
                //
                totalW = leftPadding
                for secondIndex in 0...((typedetailArr.count) - 1) {
                    var x: CGFloat = 0.0
                    var y: CGFloat = 0.0
                    var width: CGFloat = 0.0
                    var height: CGFloat = 0.0
                    leaveW = screenW - leftPadding - totalW
                    let typeDetailModel = (typedetailArr[secondIndex]) as ZkqTypeDetailModel
                    var titleSize: CGSize?
                    if let title = typeDetailModel.quality {
                        titleSize = title.sizeWith(font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(12)), maxSize: CGSize.init(width: 150, height: 40))
                        width = (titleSize?.width)! + 22.0
                        height = (titleSize?.height)! + 16.0
                        if width > leaveW {
                            totalW = leftPadding
                            totalH += height + lineMargin
                        }
                        x = totalW
                        y = totalH
                        let itemAtt = UICollectionViewLayoutAttributes.init(forCellWith: IndexPath.init(item: secondIndex, section: index))
                        itemAtt.frame = CGRect.init(x: x, y: y, width: width, height: height)
                        self.LayoutAttributes.append(itemAtt)
                        totalW += width + itemMargin
                    }

                    
                }
                
                //组尾
                let size = "我".sizeWith(font: UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(12)), maxSize: CGSize.init(width: 200, height: 40))
                totalH += size.height + 14.0
                totalH += lineMargin
                
                //最后一个组尾
                if dataArray.count == (index + 1) {
                    let footerAtt = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath.init(item: 0, section: index))
                    footerAtt.frame = CGRect.init(x: 0, y: totalH, width: screenW, height: 80)
                    self.LayoutAttributes.append(footerAtt)
                    totalH += 80
                }else {
                    let footerAtt = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath.init(item: 0, section: index))
                    footerAtt.frame = CGRect.init(x: 0, y: totalH, width: screenW, height: footerH)
                    self.LayoutAttributes.append(footerAtt)
                    totalH += footerH
                }
            }
            
            
            
        }
        
        contentsizeHeight = totalH
        
    }
    override var collectionViewContentSize: CGSize {
        get{
            return CGSize.init(width: screenW, height: contentsizeHeight)
        }
    
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return LayoutAttributes
    }
    
    
}
@objc protocol ZkqSpecItemDeletate: class {
   @objc optional func clickOneItem(cell: ZkqSpecItem, indexPath: IndexPath, btn: UIButton)
}


class ZkqSpecItem: BaseColCell {
    var btn: UIButton?
    weak var delegate: ZkqSpecItemDeletate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSelected = false
        let image = UIImage.creatImageWithColor(color: UIColor.colorWithHexStringSwift("f4f4f4"))
        self.backgroundView = UIImageView.init(image: image)
        let selectImage = UIImage.creatImageWithColor(color: THEMECOLOR)
        self.selectedBackgroundView = UIImageView.init(image: selectImage)
        self.contentView.addSubview(titleLabel)
        titleLabel.textAlignment = NSTextAlignment.center
        _ = titleLabel.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(0)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
        })
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(12))
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        self.configTitleColor(isSelect: self.isSelected)
        
    }
    func configTitleColor(isSelect: Bool) {
        if isSelected {
            titleLabel.textColor = UIColor.colorWithHexStringSwift("fefefe")
        }else {
            titleLabel.textColor = UIColor.colorWithHexStringSwift("999999")
        }
    }
    
    var specQualityModel: ZkqTypeDetailModel = ZkqTypeDetailModel.init(dict: ["data": "" as AnyObject]){
        didSet{
            
            if let isSelected = specQualityModel.isSelected {
                self.isSelected = isSelected
            }
            self.configTitleColor(isSelect: self.isSelected)
            if let quality = specQualityModel.quality {
                titleLabel.text = quality as String
            }else{
                 titleLabel.text = ""
            }
            if let store = specQualityModel.reserced {
                if store.intValue == 0 {
                    self.isUserInteractionEnabled = false
                    self.alpha = 0.5
                }else {
                    self.isUserInteractionEnabled = true
                    self.alpha = 1.0
                }
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZkqSpecColHeader: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let label = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.clear)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        titleLabel.sizeToFit()
        _ = titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.mas_left)?.setOffset(10)
            _ = make?.centerY.equalTo()(self.mas_centerY)
        }
    }
    var specModel = ZkqSpecModel.init(dict: ["data": "" as AnyObject]) {
        didSet{
            if let title = specModel.type {
                titleLabel.text = title as String
            }
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class ZkqSpecColNormalFooter: UICollectionReusableView {
    
}

protocol ZkqSpecStoreFooterDelegate: class {
    func addNumberOfStorewith(num: String)
    func subtructNumberOfStore(num: String)
}



class ZkqSpecStoreFooter: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let label = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.clear)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
        self.addSubview(titleLabel)
        titleLabel.sizeToFit()
        _ = titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.mas_left)?.setOffset(10)
            _ = make?.centerY.equalTo()(self.mas_centerY)
        }
        titleLabel.text = "数量"
        
        subtructBtn = UIButton.init()
        self.addSubview(subtructBtn!)
        subtructBtn?.setImage(UIImage.init(named: "but_minus_normal"), for: UIControlState.normal)
        subtructBtn?.setImage(UIImage.init(named: "but_minus_disable"), for: UIControlState.disabled)
        subtructBtn?.addTarget(self, action: #selector(subtruct(btn:)), for: UIControlEvents.touchUpInside)
        subtructBtn?.layer.borderColor = UIColor.colorWithHexStringSwift("f4f4f4").cgColor
        subtructBtn?.layer.borderWidth = 1
        subtructBtn?.backgroundColor = UIColor.colorWithHexStringSwift("f4f4f4")
        
        addBtn = UIButton.init()
        self.addSubview(addBtn!)
        addBtn?.setImage(UIImage.init(named: "bg_add_normal"), for: UIControlState.normal)
        addBtn?.setImage(UIImage.init(named: "bg_add_disable"), for: UIControlState.disabled)
        addBtn?.addTarget(self, action: #selector(add(btn:)), for: UIControlEvents.touchUpInside)
        addBtn?.layer.borderColor = UIColor.colorWithHexStringSwift("f4f4f4").cgColor
        addBtn?.layer.borderWidth = 1
        addBtn?.backgroundColor = UIColor.colorWithHexStringSwift("f4f4f4")
        
        
        
        countLabel = UILabel.creatLabel(UIFont.systemFont(ofSize: GDCalculator.GDAdaptation(13)), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.white)
        countLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(countLabel!)
        countLabel?.text = "1"
        
        _ = subtructBtn?.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.titleLabel.mas_right)?.setOffset(10)
            _ = make?.centerY.equalTo()(self.titleLabel.mas_centerY)
            _ = make?.width.equalTo()(44)
            _ = make?.height.equalTo()(44)
        })
        
        _ = countLabel?.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.subtructBtn?.mas_right)?.setOffset(0)
            _ = make?.centerY.equalTo()(self.subtructBtn?.mas_centerY)
            _ = make?.width.equalTo()(60)
            _ = make?.height.equalTo()(44)
        })
        
        _ = addBtn?.mas_makeConstraints({ (make) in
            make?.left.equalTo()(self.countLabel?.mas_right)?.setOffset(0)
            _ = make?.centerY.equalTo()(self.subtructBtn?.mas_centerY)
            _ = make?.width.equalTo()(60)
            _ = make?.height.equalTo()(44)
        })
        
    }
    func subtruct(btn: UIButton) {
        if let countStr = countLabel?.text {
            if let count = Int(countStr) {
                if count < 2 {
                    btn.isEnabled = false
                    return
                }
            }
            
            //
            if let count = Int(countStr) {
                let countInt = count - 1
                countLabel?.text = String(countInt)
                if delegate != nil {
                    delegate?.subtructNumberOfStore(num: (countLabel?.text!)!)
                }
                if countInt < 2 {
                    btn.isEnabled = false
                }
                addBtn?.isEnabled =  true
            }
        }
    
        
        
        
    }
    func add(btn: UIButton) {
        if let countS = countLabel?.text {
            if let count = Int(countS) {
                countLabel?.text = String(count + 1)
                if countLabel?.text == countStr {
                    btn.isEnabled = false
                }
                if (count + 1) > 1 {
                    subtructBtn?.isEnabled = true
                }
                if delegate != nil {
                    delegate?.addNumberOfStorewith(num: (countLabel?.text)!)
                }
            }
        }
    }
    
    weak var delegate: ZkqSpecStoreFooterDelegate?
    var subtructBtn: UIButton?
    var addBtn: UIButton?
    var countLabel: UILabel?
    var countStr: String = "1" {
        didSet{
            if let count = Int(countStr) {
                if count < 2 {
                    addBtn?.isEnabled = false
                    subtructBtn?.isEnabled = false
                }else{
                    countLabel?.text = "1"
                    addBtn?.isEnabled = true
                    subtructBtn?.isEnabled = false
                }
            }
            
            
            
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










//模型
class ZkqSelectSpecModel: GDBaseModel {
    var goods_id: String?
    var short_name: String?
    var reserced: String?
    var color: String?
    var rang: String?
    var image: String?
    var price: String?
    var shop_id: String?
    var store: String?
    var brand: String?
    var spec: [ZkqSpecModel]?
    var goodsDeatil: [ZkqGoodsDetailModel]?
    
    var privateDic: [String: AnyObject]?
    
    override init(dict: [String : AnyObject]?) {
        privateDic = dict
        super.init(dict: dict)
        
//        if let specArr = self.spec {
//            for specModel in specArr {
//                if let typename = specModel.typename {
//                    switch typename {
//                    case "spec1":
//                        if let typeDetailArr = specModel.typeDetail {
//                            for typeModel in typeDetailArr {
//                                
//                                if let goodsDetailArr = self.goodsDeatil {
//                                     var sum: Int = 0
//                                    for goodsDetailModel in goodsDetailArr {
//                                        if typeModel.spec1 == goodsDetailModel.spec1 {
//                                            if let reserced = goodsDetailModel.reserced {
//                                                mylog("goodsDetailModel===\(reserced)")
//                                                sum += Int(reserced)!
//                                            }
//                                        }
//                                        
//                                    }
//                                    typeModel.reserced = NSNumber.init(value: sum)
//                                }
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        break
//                    case "spec2":
//                        if let typeDetailArr = specModel.typeDetail {
//                            for typeModel in typeDetailArr {
//                                
//                                if let goodsDetailArr = self.goodsDeatil {
//                                    var sum: Int = 0
//                                    for goodsDetailModel in goodsDetailArr {
//                                        
//                                        if typeModel.spec2 == goodsDetailModel.spec2 {
//                                            if let reserced = goodsDetailModel.reserced {
//                                                sum += Int(reserced)!
//                                                
//                                            }
//                                        }
//                                        
//                                    }
//                                    typeModel.reserced = NSNumber.init(value: sum)
//                                }
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        break
//                    case "spec3":
//                        if let typeDetailArr = specModel.typeDetail {
//                            for typeModel in typeDetailArr {
//                                
//                                if let goodsDetailArr = self.goodsDeatil {
//                                    var sum: Int = 0
//                                    for goodsDetailModel in goodsDetailArr {
//                                        
//                                        if typeModel.spec3 == goodsDetailModel.spec3 {
//                                            if let reserced = goodsDetailModel.reserced {
//                                                sum += Int(reserced)!
//                                                
//                                            }
//                                        }
//                                        
//                                    }
//                                    typeModel.reserced = NSNumber.init(value: sum)
//                                }
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        break
//                    case "spec4":
//                        if let typeDetailArr = specModel.typeDetail {
//                            for typeModel in typeDetailArr {
//                                
//                                if let goodsDetailArr = self.goodsDeatil {
//                                    var sum: Int = 0
//                                    for goodsDetailModel in goodsDetailArr {
//                                        
//                                        if typeModel.spec4 == goodsDetailModel.spec4 {
//                                            if let reserced = goodsDetailModel.reserced {
//                                                sum += Int(reserced)!
//                                                
//                                            }
//                                        }
//                                        
//                                    }
//                                    typeModel.reserced = NSNumber.init(value: sum)
//                                }
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        break
//                    case "spec5":
//                        if let typeDetailArr = specModel.typeDetail {
//                            for typeModel in typeDetailArr {
//                                
//                                if let goodsDetailArr = self.goodsDeatil {
//                                    var sum: Int = 0
//                                    for goodsDetailModel in goodsDetailArr {
//                                        
//                                        if typeModel.spec5 == goodsDetailModel.spec5 {
//                                            if let reserced = goodsDetailModel.reserced {
//                                                sum += Int(reserced)!
//                                                
//                                            }
//                                        }
//                                        
//                                    }
//                                    typeModel.reserced = NSNumber.init(value: sum)
//                                }
//                                
//                                
//                            }
//                        }
//                        
//                        
//                        break
//                    default:
//                        break
//                    }
//                }
//            }
//        }
        
        
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "goodsDeatil" {
            if let array = privateDic?["goodsDeatil"] as? [AnyObject]{
                var goodsDetailArrr = [ZkqGoodsDetailModel]()
                for object in array {
                    if let dict = object as? [String: AnyObject] {
                        let goodsDetailModel = ZkqGoodsDetailModel.init(dict: dict)
                        
                        goodsDetailArrr.append(goodsDetailModel)
                    }
                }
                goodsDeatil = goodsDetailArrr
            }
            return
        }
        if key == "spec" {
            if let array = privateDic?["spec"] as? [AnyObject] {
                var specArr = [ZkqSpecModel]()
                for object in array {
                    if let dict = object as? [String: AnyObject] {
                        let specModel = ZkqSpecModel.init(dict: dict)
                        specArr.append(specModel)
                    }
                    
                }
                spec = specArr
            }
            return
        }
        
        
        
        super.setValue(value, forKey: key)
    }
}
class ZkqSpecModel: GDBaseModel {
    var type: String?
    var typename: String?
    var typeDetail: [ZkqTypeDetailModel]?
    var privateDict: [String: AnyObject]?
    override init(dict: [String : AnyObject]?) {
        privateDict = dict
        super.init(dict: dict)
        if  let spec = self.typename {
            switch spec {
            case "spec1":
                if let detailArr = self.typeDetail {
                    for typeDetailModel in detailArr {
                        if let quality = typeDetailModel.quality {
                            typeDetailModel.spec1 = quality
                        }
                        
                    }
                }
                break
            case "spec2":
                if let detailArr = self.typeDetail {
                    for typeDetailModel in detailArr {
                        if let quality = typeDetailModel.quality {
                            typeDetailModel.spec2 = quality
                        }
                        
                    }
                }
                break
            case "spec3":
                if let detailArr = self.typeDetail {
                    for typeDetailModel in detailArr {
                        if let quality = typeDetailModel.quality {
                            typeDetailModel.spec3 = quality
                        }
                        
                    }
                }
                break
            case "spec4":
                if let detailArr = self.typeDetail {
                    for typeDetailModel in detailArr {
                        if let quality = typeDetailModel.quality {
                            typeDetailModel.spec4 = quality
                        }
                        
                    }
                }
                break
            case "spec5":
                if let detailArr = self.typeDetail {
                    for typeDetailModel in detailArr {
                        if let quality = typeDetailModel.quality {
                            typeDetailModel.spec5 = quality
                        }
                        
                    }
                }
                break
            default:
                break
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "typeDetail" {
            if let array = privateDict?["typeDetail"]  as? [AnyObject]{
                var typeDetailArr = [ZkqTypeDetailModel]()
                for object in array {
                    if let dict = object as? [String: AnyObject] {
                        let typeDetailModel = ZkqTypeDetailModel.init(dict: dict)
//                        if let defaultSelect = typeDetailModel.defaultSelect {
//                            if defaultSelect == 1 {
//                                typeDetailModel.isSelected = true
//                            }else {
//                                typeDetailModel.isSelected = false
//                            }
//                            
//                        }
                        typeDetailArr.append(typeDetailModel)
                    }
                }
                typeDetail = typeDetailArr
            }
            return
        }
        super.setValue(value, forKey: key)
    }
}
class ZkqTypeDetailModel: GDBaseModel {
    var quality: String?
    var reserced: NSNumber?
    var defaultSelect: NSNumber?
    var isSelected: Bool?
    var spec1: String?
    var spec2: String?
    var spec3: String?
    var spec4: String?
    var spec5: String?
}
class ZkqGoodsDetailModel: GDBaseModel{
    var spec1: String?
    var spec2: String?
    var spec3: String?
    var spec4: String?
    var spec5: String?
    var reserced: String?
    var price: String?
    var image: String?
    var sub_id: String?
}



