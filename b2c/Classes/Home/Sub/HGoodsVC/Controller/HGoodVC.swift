//
//  HGoodVC.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/6.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImage {
    func imageByScalingToSize(size: CGSize) -> (UIImage){
        let sourceImage = self
        var newImage: UIImage?
        let imageSize = sourceImage.size
        let width: CGFloat = imageSize.width
        let height: CGFloat = imageSize.height
        let targetWidth: CGFloat = size.width
        let targetHeight: CGFloat = size.height
        var scaleFactor: CGFloat = 0.0
        var scaleWidth: CGFloat = targetWidth
        var scaleHeight: CGFloat = targetHeight
        var thumbailPoint: CGPoint = CGPoint.init(x: 0.0, y: 0.0)
        if !__CGSizeEqualToSize(imageSize, size) {
            let widthfactor = targetWidth / width
            let heightfactor = targetHeight / height
            if widthfactor < heightfactor {
                scaleFactor = widthfactor
            }else {
                scaleFactor = heightfactor
            }
            scaleWidth = width * scaleFactor
            scaleHeight = height * scaleFactor
            if widthfactor < heightfactor {
                thumbailPoint.y = targetHeight * 0.5 - scaleHeight * 0.5
            }else if (widthfactor > heightfactor) {
                thumbailPoint.x = targetWidth * 0.5 - scaleWidth * 0.5
            }
            
        }
        UIGraphicsBeginImageContext(size)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbailPoint
        thumbnailRect.size.width = scaleWidth
        thumbnailRect.size.height = scaleHeight
        sourceImage.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if newImage == nil {
            return self
        }else {
            return newImage!
        }
        
        
        
    }
}

class HGoodVC: GDNormalVC, ZkqNavTitleViewDelegate, GDMenuBtnDelegate, GDBottomViewDelegate, UICollectionViewDelegateFlowLayout, UMSocialUIDelegate, GDGTopCellDelegate, ZkqSelectSpecDelegate {
    var myTitleView: GDNavTitleView?
    var shopCar: GDShopCar?
    var goods_id: String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeshopcarNum), name: NSNotification.Name.init("LOGINSUCCESS"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToProductCell), name: NSNotification.Name.init("SCROLLUPORDOWN"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(productCellSentValue(notification:)), name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(postinfotogoodsVC(notification:)), name: NSNotification.Name.init(POSTINFOTOGOODSVC), object: nil)
        if let dic = self.keyModel?.keyparamete as? [String: AnyObject] {
            if let goodsid = dic["paramete"] as? String {
                self.goods_id = goodsid
            }
        }else {
            if  let goodsid = self.keyModel?.keyparamete as? String {
                self.goods_id = goodsid
            }else {
                
            }
        }
        self.view.backgroundColor = UIColor.white
        //设置导航栏
        self.configmentNav()
        //设置UI
        self.configmentUI()
        
        // Do any additional setup after loading the view.
    }
    func postinfotogoodsVC(notification: Notification){
        if let dict = notification.userInfo as? [String: String]{
            if let goodStatus = dict[GOODSTATUS] {
                self.goodStatus = NSString.init(format: "%@", goodStatus).integerValue
                _ = self.judgeGoodsStatusDecideIsBuy()
            }
            if let spec = dict[ISHAVEMULTIPLESPEC] {
                self.isHaveSpec = spec
            }
            
        }
        
    }
    func judgeGoodsStatusDecideIsBuy() -> Bool {
        if self.goodStatus > 0 {
            switch self.goodStatus {
            case 206:
                alert(message: "商品预售中", timeInterval: 1)
                break
            default:
                break
            }
            return true
            
        }else {
            switch self.goodStatus {
            case -205:
                alert(message: "商品已经下架", timeInterval: 1)
                break
            case -206:
                alert(message: "商品预售中", timeInterval: 1)
                break
            default:
                break
            }
            return false
        }
        
    }
    var goodStatus: NSInteger = 200;
    var isHaveSpec: String?
    
    func productCellSentValue(notification: NSNotification){
        let gdmodel = notification.userInfo?[AnyHashable("model")] as! GDBaseModel
        if let action = notification.userInfo?[AnyHashable("action")] as? String {
            switch action {
            case "jump":
                let baseModel = BaseModel.init()
                baseModel.actionKey = gdmodel.actionkey!
                baseModel.keyParamete = gdmodel.keyparamete as! [AnyHashable : Any]!
                SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                break
                case "chat":
                    let baseModel = BaseModel.init()
                    baseModel.actionKey = gdmodel.actionkey!
                    baseModel.keyParamete = gdmodel.keyparamete as! [AnyHashable: Any]!
                    SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                break
                case "shopShar":
                    if !self.judgeGoodsStatusDecideIsBuy() {
                        return
                    }
                    self.shopShar(shopModel: gdmodel as! GDGTPShopModel)
                break
                case "goodsShar":
                    if !self.judgeGoodsStatusDecideIsBuy() {
                        return
                    }
                    self.goodsShar(goodsModel: gdmodel as! GDInfoModel)
                break
                case "allGoods":
                    let baseModel = BaseModel.init()
                    baseModel.actionKey = gdmodel.actionkey!
                    baseModel.keyParamete = gdmodel.keyparamete as! [AnyHashable: Any]!
                    SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                break
            case "shangxin":
                let baseModel = BaseModel.init()
                baseModel.actionKey = gdmodel.actionkey!
                baseModel.keyParamete = gdmodel.keyparamete as! [AnyHashable: Any]!
                SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                break
            case "goodsJump":
                GDSkipManager.skip(viewController: self, model: gdmodel)
                break
            case "toshopcar":
                if let number = gdmodel.keyparamete as? String {
                    self.shopCar?.num = number
                }else {
                    if let number = gdmodel.keyparamete as? NSInteger {
                        self.shopCar?.num = String.init(format: "%d", number)
                    }
                }
                break
                
            case "selectSpec":
                self.presemiView()
                break
            default:
                break
            }
        }
    }
    func presemiView() {
        if !self.judgeGoodsStatusDecideIsBuy() {
            return
        }
        if let spec = self.isHaveSpec {
            if spec == "1" {
                self.presentSemiViewwithGoodsID(goods_id: self.goods_id, viewtype: ZkqSelectSpecType.addCarAndBuyBtn, isScreen: true)
            }
        }
        
        

    }
    weak var specView: ZkqSelectSpec?
    func presentSemiViewwithGoodsID(goods_id: String, viewtype:ZkqSelectSpecType, isScreen:Bool ){
        /** 确认收货相关  结束 */
        let rect = CGRect.init(x: 0, y: 0, width: screenW, height: screenH)
        specView = ZkqSelectSpec.init(frame: rect, viewType: viewtype, goods_id: goods_id)
        specView?.delegate = self
        if self.indexPathArr != nil {
            specView?.selectedIndexPath = self.indexPathArr!
        }
        specView?.block = {[unowned self] in
            self.specView?.presentSemiView(semiView: self.specView!, backView: nil, target: self, isScreenShot: true)
        }
    
    
    }
    var indexPathArr: [IndexPath]?
    //选择出的规格模型
    func selectGoodsDetailModel(model: ZkqGoodsDetailModel){
        
    }
    //将数组传过去
    func sentSelectIndexPathArr(arr: [IndexPath]){
        self.indexPathArr = arr
    }
    /**页面将要弹出的时候的代理*/
    func viewWillDisPlay(){
        
    }
    /**页面出现的时候的代理*/
    func viewDidDisPlay(){
    
    }
    /**页面消失的时候的代理*/
    func viewDidEndDisPaly(){
        
    }
    /**页面消失然后开始动画*/
    func viewHiddenAndBeginAnimation(){
        
    }
    /**加入购物车失败*/
    func addShopCarFail() {
        
    }
    func changeshopcarNum() {
        GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.GET, urlString: "ShopCartNumber", parameters: [String: AnyObject](), success: { (result) in
            if let number = result.data as? String {
                self.shopCar?.num = number
            }
        }) { (error) in
            
        }
    }
    func goodsShar(goodsModel: GDInfoModel) {
        let url = String.init(format: "%@/Shop/goods_detail/goods_id/%@.html?actionkey=goods&ID=%@", WAPDOMAIN, self.goods_id, self.goods_id)
        if let goodsName = goodsModel.short_name {
            UMSocialData.default().extConfig.title = goodsName
            UMSocialData.default().extConfig.sinaData.shareText = String.init(format: "我在直接捞发现了一个很棒的商品，快来看看吧。%@ @直接捞 %@", goodsName, url)
            UMSocialData.default().extConfig.wechatTimelineData.shareText = String.init(format: "%@", goodsName)
        }else{
            UMSocialData.default().extConfig.title = ""
            UMSocialData.default().extConfig.sinaData.shareText = String.init(format: "我在直接捞发现了一个很棒的商品，快来看看吧。%@ @直接捞 %@", "", url)
            UMSocialData.default().extConfig.wechatTimelineData.shareText = String.init(format: "%@", "")
        }
        UMSocialData.default().extConfig.qqData.url = url
        UMSocialData.default().extConfig.wechatSessionData.url = url
        UMSocialData.default().extConfig.wechatTimelineData.url = url
        
        
        let sharImage = UIImageView.init()
        sharImage.sd_setImage(with: URL.init(string: url), placeholderImage: placeholderImage, options: SDWebImageOptions.cacheMemoryOnly, completed: { (image, error, SDImageCacheType, imageUrl) in
            let img = image?.imageByScalingToSize(size: CGSize.init(width: 100, height: 100))
            UMSocialData.default().extConfig.sinaData.shareImage = img
            UMSocialData.default().extConfig.wechatTimelineData.shareImage = img
            UMSocialSnsService.presentSnsIconSheetView(self, appKey: "574e769467e58efcc2000937", shareText: "我在直接捞发现了一个很棒的商品，快来看看吧", shareImage: img, shareToSnsNames: [UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ], delegate: self)
        })

        
    }
    
    func shopShar(shopModel: GDGTPShopModel) {
        if let shopID = shopModel.shop_id {
            let url = String.init(format: "%@/Shop/index/shop_id/%@.html?actionkey=shop&ID=%@", WAPDOMAIN, shopID, shopID)
            if let shopName = shopModel.shop_name {
                UMSocialData.default().extConfig.title = shopName
                UMSocialData.default().extConfig.sinaData.shareText = String.init(format: "我在直接捞发现了一个很棒的店铺，快来看看吧 %@@直接捞 %@", shopName, url)
                UMSocialData.default().extConfig.wechatTimelineData.shareText = String.init(format: "我在直接捞发现了一个很棒的店铺：%@", shopName)
                
            }else {
                alert(message: "店铺名字为空", timeInterval: 1)
                UMSocialData.default().extConfig.title = ""
                UMSocialData.default().extConfig.sinaData.shareText = String.init(format: "我在直接捞发现了一个很棒的店铺，快来看看吧 %@@直接捞 %@", "", url)
                UMSocialData.default().extConfig.wechatTimelineData.shareText = String.init(format: "我在直接捞发现了一个很棒的店铺：%@", "")
            }
            UMSocialData.default().extConfig.qqData.url = url
            UMSocialData.default().extConfig.wechatSessionData.url = url
            UMSocialData.default().extConfig.wechatTimelineData.url = url
            
            let sharImage = UIImageView.init()
            sharImage.sd_setImage(with: URL.init(string: url), placeholderImage: placeholderImage, options: SDWebImageOptions.cacheMemoryOnly, completed: { (image, error, SDImageCacheType, imageUrl) in
                let img = image?.imageByScalingToSize(size: CGSize.init(width: 100, height: 100))
                UMSocialData.default().extConfig.sinaData.shareImage = img
                UMSocialData.default().extConfig.wechatTimelineData.shareImage = img
                UMSocialSnsService.presentSnsIconSheetView(self, appKey: "574e769467e58efcc2000937", shareText: "我在直接捞发现了一个很棒的店铺，快来看看吧", shareImage: img, shareToSnsNames: [UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ], delegate: self)
            })
            
            
            
            
        }else{
            alert(message: "店铺id为空", timeInterval: 1)
        }
        
    }
    
    func didFinishGetUMSocialDataResponse(_ response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
                print("分享成功")
        }
    }
    
    func scrollToProductCell(notification: Notification){
        print(notification.userInfo?[AnyHashable("upordown")])
        if let direct = notification.userInfo?[AnyHashable("upordown")] as? String {
            switch direct {
            case "todown":
                self.collectionView.scrollToItem(at: IndexPath.init(item: 1, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                UIView.animate(withDuration: 0.25, animations: {
                    self.myTitleView?.scroll?.contentOffset = CGPoint.init(x: 0, y: 44)
                }) { (finish) in
                    
                }
                break
            case "toup":
                self.collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                UIView.animate(withDuration: 0.25, animations: {
                    self.myTitleView?.scroll?.contentOffset = CGPoint.init(x: 0, y: 0)
                }) { (finish) in
                    
                }
                break
            default:
                break
            }
        }
        
    }
    
    
    func configmentNav() {
        self.naviBar.backgroundColor = UIColor.white
        myTitleView = GDNavTitleView.init(frame: CGRect.init(x: 115 * scale, y: 0, width: screenW - (115 + 88 + 10) * scale, height: 44), titleArr: ["商品", "详情", "评价"], font: UIFont.systemFont(ofSize: 15))
        myTitleView?.insets = UIEdgeInsets.init(top: 0, left: 115 * scale - 44, bottom: 0, right: 88 + 10)
        myTitleView?.delegate = self
        myTitleView?.titleLabel?.text = "图文详情"
        self.naviBar.navTitleView = myTitleView!
        
        //菜单按钮
        let btn = GDMenuBtn.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44), dataArr: [["image": "", "title": "首页"], ["image": "", "title": "搜索"], ["image": "", "title": "消息"], ["image": "", "title": "收藏"]], point: CGPoint.init(x: screenW - 33 * scale, y: 56))
        btn.delegate = self
        btn.fatherVC = self
        btn.selectItemsBlock = {[unowned self] indxpath in
            switch indxpath.item {
            case 0:
                
                self.navigationController?.popToRootViewController(animated: false)
                GDKeyVC.share.selectChildViewControllerIndex(index: 0)
                break
            case 1:
                let baseModel = BaseModel.init()
                baseModel.actionKey = "HSearchVC"
                SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                break
            case 2:
                if UserInfo.share().isLogin {
                    let baseModel = BaseModel.init()
                    baseModel.actionKey = "FriendListVC"
                    SkipManager.share().skip(byVC: self, withActionModel: baseModel)
                }else {
                    let login = LoginNavVC.init(loginNavVC: ())
                    GDKeyVC.share.present(login!, animated: true, completion: nil)
                }
                break

            case 3:
                if !self.judgeGoodsStatusDecideIsBuy() {
                    return
                }
                if UserInfo.share().isLogin {
                    GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.POST, urlString: "IsGoodsCollect", parameters: ["member_id": UserInfo.share().member_id as AnyObject, "goods_id": self.goods_id as AnyObject], success: { (result) in
                        if result.status < 0{
                            alert(message: "商品已收藏", timeInterval: 1)
                        }else {
                            GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.POST, urlString: "GoodsCollect", parameters: ["member_id": UserInfo.share().member_id as AnyObject, "goods_id": self.goods_id as AnyObject], success: { (result) in
                                if let msg = result.msg {
                                    alert(message: msg, timeInterval: 1)
                                }
                                
                            }, failure: { (error) in
                                alert(message: "收藏失败，请重新收藏", timeInterval: 1)
                            })
                        }
                    }, failure: { (error) in
                        alert(message: "收藏失败，请重新操作", timeInterval: 1)
                    })
                    
                }else {
                    let login = LoginNavVC.init(loginNavVC: ())
                    GDKeyVC.share.present(login!, animated: true, completion: nil)
                }
                
                break

                
            default:
                break
            }
        }
        //购物车
        shopCar = GDShopCar.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        shopCar?.addTarget(self, action: #selector(toShopCarVC), for: UIControlEvents.touchUpInside)
        self.naviBar.rightBarButtons = [shopCar!,btn] as [UIView]
        
    }
    func toShopCarVC() {
        let model = BaseModel.init()
        model.judge = true
        model.actionKey = "ShopCarVC"
        SkipManager.share().skip(byVC: self, withActionModel: model)
    }
    //标题的代理
    func titleViewScrollToTarget(index: Int) {
        //滑动到某个页面
        if TCell != nil {
            TCell?.col?.scrollToItem(at: IndexPath.init(item: index, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
        }
    }
    func configmentSelectButtonWithItem(tag: Int) {
        myTitleView?.configmentBtn(tag: tag)
    }
    //菜单代理
    func itemselectClick(indexPath: IndexPath) {
        
    }
    func configmentUI(){
        let bottomBarView = GDBottomView.init(frame: CGRect.init(x: 0, y: screenH - 50, width: screenW, height: 50))
        self.view.addSubview(bottomBarView)
        bottomBarView.delegate = self
        //
        self.collectionView.frame = CGRect.init(x: 0, y: 64, width: screenW, height: screenH - 64 - 50)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.register(GDGTopCell.self, forCellWithReuseIdentifier: "GDGTopCell")
        self.collectionView.register(GDGBottomCell.self, forCellWithReuseIdentifier: "GDGBottomCell")
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = false
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    var TCell: GDGTopCell?
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GDGTopCell", for: indexPath) as! GDGTopCell
            topCell.contentView.backgroundColor = UIColor.red
            topCell.goods_id = self.goods_id
            topCell.delegate = self
            TCell = topCell
            return topCell
        }else {
            let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GDGBottomCell", for: indexPath) as! GDGBottomCell
            bottomCell.goods_id = self.goods_id
            bottomCell.contentView.backgroundColor = UIColor.yellow
            return bottomCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: screenW, height: screenH - 50 - 64)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0.0)
    }
    
    
    
    func addShopCar(btn: UIButton) {
        if self.isHaveSpec == "1"{
            self.presemiView()
            return
        }
        
        
        
    }
    func buy(btn: UIButton) {
        if self.isHaveSpec == "1"{
            self.presemiView()
            return
        }
        
    }
    //客服
    func service(btn: UIButton) {
        
    }
    
    
    
    
    //店铺
    func enterStore(btn: UIButton) {
        
    }
    
    //收藏
    func collection(btn: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        print("HGoodVC销毁")
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






