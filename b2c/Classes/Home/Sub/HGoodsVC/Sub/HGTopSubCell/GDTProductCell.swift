//
//  GDTProductCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
import MJExtension
//传送选规格cell在table中的位置
let postIndexPathToGoodsVC = "postIndexPathToGoodsVC"
/**点击选规格cell*/
let clickSelectSpecCell = "clickSelectSpecCell"
/**上拉滚动到详情页面*/
let scrollToDetailCell = "scrollToGoodsDetailCell"
/**下拉滚动到商品页面*/
let scrollToGoodsCell = "scrollToGoodsCell"
/**分享图片的名字*/
let SHARGOODNAME = "sharGoodsName"
/**商品状态*/
let GOODSTATUS = "goodStatus"
/**预售时间*/
let SHELVESTIME = "shelvesTime"
/**是否有多个规格*/
let ISHAVEMULTIPLESPEC = "isHaveMultipleSpec"
/**通知名：传送信息到控制器*/
let POSTINFOTOGOODSVC = "postInfoToGoodsVC"
protocol GDTProductCellDelegate: class {
    
}
class GDTProductCell: GDGoodsBaseCell {

    weak var delegate: GDTProductCellDelegate?
    var isFirstRun: Bool?
    //banner数组
    var tableview: TopGoodsCellTable?
    var bannerData = [BannerModel]()
    var dataArray: [GDGoodsBaseModel] = [GDGoodsBaseModel]()
    override var goods_id: String?{
        didSet{
            if isFirstRun! {
                isFirstRun = false
                self.requestData()
            }
            
        }
    }
    func requestData() {
        GDNetworkManager.shareManager.requestDataFromNewWork(RequestType.GET, urlString: "GoodsItem", parameters: ["goods_id": goods_id! as AnyObject], success: { (result) in
            var valueDic: [String: String] = [String: String]()
            
            if let dataArr = result.data as? [AnyObject] {
                mylog(dataArr)
                for object in dataArr {
                    if let dict = object as? [String: AnyObject] {
                        //取出字典中的key值
                        if let key = dict["key"] as? String {
                            //需要传递的数据字典
                            
                            
                            

                            //屏蔽不存在的key值
                            if self.shieldKey(key: key) {
                                switch key {
                                case "nav":
                                    if let items = dict["items"]  as? [[String: AnyObject]] {
                                        for itemsDic in items{
                                            if let name = itemsDic["name"] as? String{
                                                if name == "购物车" {
                                                    let model = GDBaseModel.init(dict: nil)
                                                    UserInfo.share().isLogin ? (model.keyparamete = itemsDic["number"]) : (model.keyparamete = "0" as AnyObject)
                                                    
//                                                    model.keyparamete = itemsDic["number"]
                                                    let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "toshopcar" as Any]
                                                    NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
                                                }
                                            }
                                        }
                                    }
                                    
                                    break
                                case "focus":
                                    let model:GDGoodsBaseModel = GDGoodsBaseModel.init(dict: dict )
                                    if let array = model.items {
                                        for focusDic in array {
                                            if let dict = focusDic as? [String: String] {
                                                let bannerModel = BannerModel.init(dict: dict as [String : AnyObject])
                                                self.bannerData.append(bannerModel)
                                            }
                                        }
                                    }
                                    
                                    break
                                case "info":
                                    let infoModel = GDInfoModel.init(dict: dict)
                                    if let goodsstatus = infoModel.goods_status {
                                        print(goodsstatus)
                                        valueDic[GOODSTATUS] = String.init(format: "%@", goodsstatus)
                                    }
                                    if let shelves_at = infoModel.shelves_at {
                                        valueDic[SHELVESTIME] = String.init(format: "%@", shelves_at)
                                    }
                                    self.dataArray.append(infoModel)
                                    
                                    break
                                case "sales":
                                    
                                    break
                                case "checked":
                                    let specModel = GDSpecModel.init(dict: dict)
                                    if let ishavespec = specModel.ishavespec {
                                        valueDic[ISHAVEMULTIPLESPEC] = String.init(format: "%@", ishavespec)
                                    }
                                    
                                    if let num = specModel.ishavespec {
                                        if num == 1 {
                                            self.dataArray.append(specModel)
                                        }
                                    }
                                    
                                    break
                                case "comment":
                                    let commentModel = GDEvaluateModel.init(dict: dict)
                                    self.dataArray.append(commentModel)
                                    break
                                    case "shop":
                                    let shopModel = GDGTPShopModel.init(dict: dict)
                                    self.dataArray.append(shopModel)
                                    break
                                default: break
                                    
                                }
                            }
                        }
                        
                        
                    }
                    //判断数组中的对象可以转换成字典
                    
                    
                }
            }
            self.tableview?.bannerData = self.bannerData
            self.tableview?.dataArray = self.dataArray
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: POSTINFOTOGOODSVC), object: nil, userInfo: valueDic as [AnyHashable: Any])
            //在数据加载的时候就已经确定了规格cell 的位置
            var index: Int = 0
            for object in self.dataArray {
                if object is GDSpecModel {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: postIndexPathToGoodsVC), object: nil, userInfo: ["indexpath": IndexPath.init(row: index, section: 0)])
                }
                index += 1
            }
        }) { (error) in
            
        }
    }
    
    
    
    
    /**屏蔽不识别的关键字*/
    func shieldKey(key: String) -> Bool {
        if key.isEqual("button") {
            return false
        }
        
        return true
    }
    
    
    
    
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        isFirstRun = true
        tableview = TopGoodsCellTable.init(frame: CGRect.init(x: 0, y: 0, width: self.contentView.bounds.size.width, height: self.contentView.bounds.size.height), style: UITableViewStyle.plain)
        self.contentView.addSubview(tableview!)
        tableview?.contentInset = UIEdgeInsetsMake(screenW, 0, 0, 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
class TopGoodsCellTable: UITableView, UITableViewDelegate, UITableViewDataSource, GDBannerViewDelegate, CheckImageDelegate {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(GDInfoCell.self, forCellReuseIdentifier: "GDInfoCell")
        self.register(GDBaseCell.self, forCellReuseIdentifier: "GDBaseCell")
        self.register(GDSpecCell.self, forCellReuseIdentifier: "GDSpecCell")
        self.register(GDEvaluateCell.self, forCellReuseIdentifier: "GDEvaluateCell")
        self.register(GDGTPShopCell.self, forCellReuseIdentifier: "GDGTPShopCell")
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.showsHorizontalScrollIndicator = false
        //设置cell自适应高度
        self.estimatedRowHeight = 100
        self.rowHeight = UITableViewAutomaticDimension
        /**添加banner*/
        let backView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenW, height: (self.frame.size.height)))
        self.backgroundView = backView
        self.backgroundColor = BackGrayColor
    
        bannerView = GDBannerView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenW), subFrame: CGRect.init(x: screenW - 45, y: screenW - 30, width: 45, height: 20))
        backView.addSubview(bannerView!)
        bannerView?.delegate = self;
    }

    var dataArray: [GDGoodsBaseModel] = [GDGoodsBaseModel](){
        didSet{
            let footerView = TopGoodsCellTableFooter.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 50 * scale))
            self.tableFooterView = footerView
            self.reloadData()
            bannerView?.dataArr = self.bannerData
        }
    }
    
    /**头部banner图*/
    var bannerView: GDBannerView?
    var bannerData = [BannerModel]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseModel: GDGoodsBaseModel = self.dataArray[indexPath.item]
        if let key = baseModel.key {
            switch key {
            case "info":
                let infoCell: GDInfoCell = tableView.dequeueReusableCell(withIdentifier: "GDInfoCell", for: indexPath) as! GDInfoCell
                infoCell.infoModel = self.dataArray[indexPath.item] as! GDInfoModel
                return infoCell
            case "checked":
                let specCell: GDSpecCell = tableView.dequeueReusableCell(withIdentifier: "GDSpecCell", for: indexPath) as! GDSpecCell
                specCell.specModel = self.dataArray[indexPath.item] as! GDSpecModel
                
                return specCell
            case "comment":
                let evluateCell: GDEvaluateCell = tableView.dequeueReusableCell(withIdentifier: "GDEvaluateCell", for: indexPath) as! GDEvaluateCell
                evluateCell.evaluateModel = self.dataArray[indexPath.item] as! GDEvaluateModel
                return evluateCell
                case "shop":
                    let shopCell: GDGTPShopCell = tableView.dequeueReusableCell(withIdentifier: "GDGTPShopCell", for: indexPath) as! GDGTPShopCell
                    shopCell.shopModel = self.dataArray[indexPath.item] as! GDGTPShopModel
                return shopCell
            default:
                mylog("")
            }
        }
        
        let cell = self.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataArray[indexPath.row] is GDSpecModel {
            
            let model = GDBaseModel.init(dict: nil)
            let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "selectSpec" as Any]
            NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOGOODSVC"), object: nil, userInfo: userinfo)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height + CGFloat(50) - self.frame.size.height) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SCROLLUPORDOWN"), object: nil, userInfo: [AnyHashable("upordown"): "todown" as Any])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //下拉，上拉让bannerview跟随着变化
        let y = self.contentOffset.y
        //移动的距离
        let movey = y + screenW
        let topY = movey/CGFloat(2.0)
        if y > (-screenW) {
            bannerView?.frame = CGRect(x: 0, y: -topY, width: (bannerView?.frame.size.width)!, height: (bannerView?.frame.size.height)!)
        }else{
            bannerView?.frame = CGRect(x: 0, y: -(y) - screenW, width: (bannerView?.frame.size.width)!, height: (bannerView?.frame.size.height)!)
        }
        
        
        
    }
    
    func sentValue(_ index: IndexPath, dataArr data: [BannerModel], rect viewRect: CGRect) {
        let checkView: CheckImageView = CheckImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH))
        window?.addSubview(checkView)
        checkView.delegate = self
        checkView.model(data, index: index, rect: viewRect)
        checkView.col?.scrollToItem(at: index, at: UICollectionViewScrollPosition.left, animated: false)
    }
    
    
    //将backview的col滚动到当前indxpath
    func sentColIndex(currentIndex: IndexPath) {
        bannerView?.collectionview?.scrollToItem(at: currentIndex, at: UICollectionViewScrollPosition.left, animated: false)
    }
    deinit {
        bannerView?.removeTimer()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class TopGoodsCellTableFooter: UIView {
    var rightLine: UIView = UIView.init()
    var leftLine: UIView = UIView.init()
    var titleLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.clear)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(rightLine)
        self.addSubview(leftLine)
        self.addSubview(titleLabel)
        self.backgroundColor = BackGrayColor
        titleLabel.sizeToFit()
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "继续拖动，查看图文详情"
        titleLabel.mas_makeConstraints { (make) in
            _ = make?.centerY.equalTo()(self.mas_centerY)
            _ = make?.centerX.equalTo()(self.mas_centerX)
        }
        leftLine.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.titleLabel.mas_left)?.setOffset(-10)
            _ = make?.centerY.equalTo()(self.mas_centerY)
            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(50))
            _ = make?.height.equalTo()(1)
        }
        leftLine.backgroundColor = UIColor.colorWithHexStringSwift("999999")
        rightLine.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.titleLabel.mas_right)?.setOffset(10)
            _ = make?.centerY.equalTo()(self.mas_centerY)
            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(50))
            _ = make?.height.equalTo()(1)
        }
        rightLine.backgroundColor = UIColor.colorWithHexStringSwift("999999")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}


