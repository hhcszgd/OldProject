//
//  DDItem1VC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit
import CryptoSwift
import CoreLocation
class DDItem1VC: DDNoNavibarVC , UITextFieldDelegate{
    var naviBarStartShowH : CGFloat =  DDDevice.type == .iphoneX ? 164 : 148
    var naviBarEndShowH : CGFloat = DDDevice.type == .iphoneX ? 100 : 80
    var homeModel = DDHomeApiModel()
    var nearbyApiModel = DDNearbyApiModel()
    var shopsContainer = [DDNearbyShopModel]()
    var pageNum : Int  = 0
    
    var arrModel : [DDItemModel] {
        var temp  = [DDItemModel]()
        let channelItemModel = DDItemModel()
        channelItemModel.classIdentify = "classify"
        channelItemModel.items = homeModel.data.channelMenu
        
        let recomItemModel = DDItemModel()
        recomItemModel.classIdentify = "scroll"
        recomItemModel.items = homeModel.data.hotRecom
        temp.append(channelItemModel)
        temp.append(recomItemModel)
        
        if shopsContainer.count > 0  {
            let nearbyShopsItemModel = DDItemModel()
            nearbyShopsItemModel.classIdentify = "shops"
            nearbyShopsItemModel.items = shopsContainer
            temp.append(nearbyShopsItemModel)
        }
        return temp
    }
    
    let searchBox = UITextField.init()
    let messageIcon : GDMsgIconView = GDMsgIconView()
    let nickName = UIButton()
    var  hotWordContainer : UIView = UIView()
    let locationButton : DDLocationArrow = DDLocationArrow()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNaviBar()
        configCollectionView()
        DDLocationManager.share.locationManager.startUpdatingLocation()
//        mylog("\(DDLocationManager.share.locationManager.location?.coordinate)")
        self.requestHomeApi()
    }
    func requestHomeApi(){
        DDRequestManager.share.homePageTopData(true)?.responseJSON(completionHandler: { (response ) in
            mylog(response.value)
            let decode  : JSONDecoder = JSONDecoder.init()
            do {
                let model = try decode.decode(DDHomeApiModel.self, from: response.data ?? Data() )
                self.homeModel = model
                self.collectionView?.gdRefreshControl?.endRefresh(result: GDRefreshResult.success)
                self.setContentToNaviBar()
                self.collectionView?.reloadData()
                mylog(model.status)
                mylog(model.data.hotSearch.first?.keyword)
                mylog(model.data.hotSearch.first?.actionKey)
                
            }catch{
                mylog(error)
                self.collectionView?.gdRefreshControl?.endRefresh(result: GDRefreshResult.failure)
            }
        })
    }
    
    func configNaviBar() {
        
        self.naviBar.backgroundColor = UIColor.colorWithHexStringSwift("#f86565").withAlphaComponent(0.0)
        self.naviBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: naviBarStartShowH)
        
        let hotSearchH : CGFloat = 20
        let extensionMargin : CGFloat = 10
        
        searchBox.delegate =  self //UITextFieldDelegate
        self.naviBar.addSubview(searchBox)
        searchBox.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 44 * 2, height: 30)
        let searchBoxCenterY = (((self.naviBar.bounds.height - hotSearchH) - 5) - searchBox.bounds.height * 0.5) + extensionMargin
        searchBox.center = CGPoint(x: self.naviBar.bounds.width * 0.5, y: searchBoxCenterY)
        searchBox.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        searchBox.borderStyle = UITextBorderStyle.roundedRect
        let rightView = UIButton(frame: CGRect(x: -10, y: 0, width: 20, height: 20))
        rightView.setImage(UIImage(named: "search"), for: UIControlState.normal)
        rightView.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        searchBox.rightView = rightView
        searchBox.rightViewMode = .always
        searchBox.placeholder = "热销"
        
        self.naviBar.addSubview(messageIcon)
        messageIcon.addTarget(self , action: #selector(messageIconClick(sender:)), for: UIControlEvents.touchUpInside)
        let messageCenterY : CGFloat = DDDevice.type == .iphoneX ? (33 + 20 ) : (20 + 20)
        let messageIconWH : CGFloat = 40
        messageIcon.bounds = CGRect(x: 0, y: 0, width: messageIconWH, height: messageIconWH)
        messageIcon.center = CGPoint(x: (self.naviBar.bounds.width - 10) - messageIconWH * 0.5, y: messageCenterY)
        messageIcon.titleLabel.text = nil
        messageIcon.messageCount = 5
        naviBar.addSubview(nickName)
        nickName.addTarget(self , action: #selector(nickNameClick(sender:)), for: UIControlEvents.touchUpInside)
        nickName.titleLabel?.textColor = UIColor.white
        nickName.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        nickName.setTitle("nick name", for: UIControlState.normal)
        naviBar.addSubview(locationButton)
        locationButton.addTarget(self , action: #selector(locationClick(sender:)), for: UIControlEvents.touchUpInside)
        locationButton.setTitle("获取中", for: UIControlState.normal)
        locationButton.sizeToFit()
        locationButton.center = CGPoint(x: naviBar.bounds.width/2, y: messageCenterY + 30)
        naviBar.addSubview(hotWordContainer)
        hotWordContainer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        hotWordContainer.frame = CGRect(x: searchBox.frame.minX, y: (naviBar.bounds.height - hotSearchH ) + extensionMargin, width: searchBox.frame.width, height: hotSearchH )
        setContentToNaviBar()
    }
    func setContentToNaviBar() {
        let messageCenterY : CGFloat = DDDevice.type == .iphoneX ? (33 + 20 ) : (20 + 20)
        nickName.sizeToFit()
        nickName.center = CGPoint(x: 10 + nickName.frame.width * 0.5, y: messageCenterY)
        DDLocationManager.share.placemarkFromLocation(location: DDLocationManager.share.locationManager.location ?? CLLocation()) { (placemark) in
            let city = placemark?.locality ?? "未知"
            self.locationButton.sizeToFit()
            self.locationButton.setTitle(city, for: UIControlState.normal)
            self.locationButton.center = CGPoint(x: self.naviBar.bounds.width/2, y: messageCenterY + 30)
        }
        
        hotWordContainer.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        let margin : CGFloat = 5
        var _maxX : CGFloat = 0
        let keyWorkArr = homeModel.data.hotSearch
        for (_ , model ) in keyWorkArr.enumerated() {
            let button = UIButton.init()
            button.addTarget(self , action: #selector(keywordClick(sender:)), for: UIControlEvents.touchUpInside)
            button.titleLabel?.font = GDFont.systemFont(ofSize: 14)
            button.setTitle(model.keyword, for: UIControlState.normal)
            button.sizeToFit()
            if hotWordContainer.bounds.width - (_maxX + margin) < button.bounds.width{break}
//            button.backgroundColor = UIColor
            hotWordContainer.addSubview(button)
            button.center = CGPoint(x: (_maxX + margin) + button.bounds.width/2 , y: hotWordContainer.bounds.height/2)
            _maxX = button.frame.maxX
        }
    }
    //textfieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        self.navigationController?.pushViewController(DDSearchVC(), animated: true)
        return false
    }
    
    func configCollectionView()  {
        var collectionY : CGFloat = 0
        var collectionH : CGFloat = 0
        collectionY =  0 //DDDevice.type == .iphoneX ? 44 : 0
        collectionH = DDDevice.type == .iphoneX ? (self.view.bounds.height  - 83) : (self.view.bounds.height - 49 )
        self.collectionView =  UICollectionView.init(frame: CGRect(x: 0, y: collectionY, width: UIScreen.main.bounds.width, height: collectionH), collectionViewLayout: DDSingleLayout())
//        mylog("print status bar bounds : \(UIApplication.shared.statusBarFrame)")
        testMidBigLayout()
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0    )
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        let refresh = GDRefreshControl.init(target: self , selector: #selector(performRefresh))
        refresh.refreshHeight = scrollCritical
        collectionView?.gdRefreshControl = refresh
        collectionView?.gdLoadControl = GDLoadControl.init(target: self , selector: #selector(loadMore))
    }
    func cal(du : CGFloat , fen : CGFloat , miao : CGFloat) {
        let result = du  + ((fen / 60)  +  (miao / 3600))
        mylog("result : \(result)")
    }
    @objc func loadMore()  {
        self.pageNum += 1
    DDRequestManager.share.homepageNearbyShops(page:pageNum , true )?.responseJSON(completionHandler: { (response) in
//        mylog(response.value)
            switch response.result {
            case .success:
                let decode = JSONDecoder.init()
                do{
                    let nearbyApiModel = try decode.decode(DDNearbyApiModel.self, from: response.data ?? Data() )
                    self.nearbyApiModel = nearbyApiModel
                    
                    if self.nearbyApiModel.data.shops?.count ?? 0 > 0{
                        self.shopsContainer.append(contentsOf: self.nearbyApiModel.data.shops!)
                        self.collectionView?.gdLoadControl?.endLoad(result: GDLoadResult.success)
                        self.collectionView?.reloadData()
                    }else{
                        self.collectionView?.gdLoadControl?.endLoad(result: GDLoadResult.nomore)
                    }
                }catch{
                    mylog(error)
                    self.collectionView?.gdLoadControl?.endLoad(result: GDLoadResult.failure)
                }
            case .failure(let error):
                print(error)
                
                self.collectionView?.gdLoadControl?.endLoad(result: GDLoadResult.failure)
            }
        })
    }
    @objc func performRefresh() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.shopsContainer.removeAll()
            self.pageNum = 0
            self.collectionView?.reloadData()
            self.requestHomeApi()
        }
    }
    func testLocalize() {
        let willBeShowLocalIdentifier =  DDLanguageManager.text("language_identifier") // 中文是:"zh_cn"
        let willBeShowLocal = Locale.init(identifier: "th_th")//localID为"th_th"的本地化对象
        let showInLocal = Locale.init(identifier: "ch_en")//以中文显示泰文信息
//        print(Locale.current.regionCode)//以当前区域(国家)显示localID为"zh_cn"的本地化对象的相关信息(国家 ,语言名称等)
        mylog(showInLocal.localizedString(forRegionCode: willBeShowLocal.regionCode!))
        mylog(showInLocal.localizedString(forLanguageCode: willBeShowLocal.languageCode!))
        /*
         输出
         Optional("泰国")
         Optional("泰文")
         */
    }
    override func contentOffsetChanged(scrollView: UIScrollView, contentOffset: CGPoint) {
//        mylog(contentOffset)
        let dynamicChangeValue : CGFloat = 10
        if contentOffset.y <= 0  {
            self.naviBar.frame = CGRect(x: 0, y: -contentOffset.y, width: self.view.bounds.width, height: naviBarStartShowH + dynamicChangeValue)
            
            self.naviBar.backgroundColor = UIColor.colorWithHexStringSwift("#f86565").withAlphaComponent(0.0)
            self.searchBox.backgroundColor =  UIColor.white.withAlphaComponent(0.5)
            self.hotWordContainer.alpha = 1
            self.nickName.alpha = 1
            locationButton.alpha = 1
            self.messageIcon.alpha = 1
        }else{
            let linjie = naviBarStartShowH - naviBarEndShowH
            if contentOffset.y <= linjie{
                self.naviBar.frame = CGRect(x: 0, y: -contentOffset.y, width: self.view.bounds.width, height: naviBarStartShowH)
                let scale = contentOffset.y / linjie
//                mylog(scale)
                self.naviBar.backgroundColor = UIColor.colorWithHexStringSwift("#f86565").withAlphaComponent(scale)
                self.searchBox.backgroundColor =  UIColor.white.withAlphaComponent(0.5 + scale)
                
                self.hotWordContainer.alpha = 1 - scale 
                self.nickName.alpha = 1 - scale
                self.messageIcon.alpha = 1 - scale
                locationButton.alpha = 1 - scale
                self.naviBar.frame = CGRect(x: 0, y: -contentOffset.y, width: self.view.bounds.width, height: naviBarStartShowH + dynamicChangeValue * (1 - scale))
            }else{
                locationButton.alpha = 0
                self.hotWordContainer.alpha = 0
                self.searchBox.backgroundColor = UIColor.white
                
                self.naviBar.frame = CGRect(x: 0, y: -linjie, width: self.view.bounds.width, height: naviBarStartShowH)
                self.naviBar.backgroundColor = UIColor.colorWithHexStringSwift("#f86565")
            }
        }
    }

}


extension DDItem1VC : UICollectionViewDataSource , UICollectionViewDelegate,DDSingleLayoutProtocol{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        mylog("select item \(indexPath.description)")
        if let nearbyShops = arrModel[indexPath.section].items as? [DDNearbyShopModel]{
            let shopModel = nearbyShops[indexPath.item]
            self.gotoShopDetail(id: shopModel.id)
//            mylog("go to shop detail:\(shopModel.shop_name)id:\(shopModel.id)")
        }
    }
    func provideSessionHeaderHeight(layout: DDSingleLayout?, section: Int) -> CGFloat {
      let identify =  arrModel[section].classIdentify
        switch identify  {
            case "classify":
                return 0
            case "shops":
                if shopsContainer.count > 0 {return 52}
                return 0
            case "scroll":
                return 52
            default:
                return 0
        }
    }
    func provideItemHeight(layout: DDSingleLayout?, indexPath: IndexPath) -> CGFloat {
      let identify =  arrModel[indexPath.section].classIdentify
            switch identify  {
            case "classify":
                return  DDDevice.type == .iphoneX ? 420 :400
            case "shops":
                return 105
            case "scroll":
                return 195
            default:
                return 44
                
            }
        
    }
    func provideEdgeInsets(layout: DDSingleLayout?) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0 )
    }
    func testMidBigLayout() {
        self.view.addSubview(self.collectionView!)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        if #available(iOS 11.0, *) {
            self.collectionView?.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.collectionView?.register(HomeClassifyItem.self , forCellWithReuseIdentifier: "HomeClassifyItem")
        self.collectionView?.register(HomeShopItem.self , forCellWithReuseIdentifier: "HomeShopItem")
        self.collectionView?.register(HomeScrollItem.self , forCellWithReuseIdentifier: "HomeScrollItem")
        collectionView?.register(HomeReusableHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeReusableHeader")
        collectionView?.register(DDSearchSessionFooter.self , forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DDSearchCollectionFooter")
        if let layout  = collectionView?.collectionViewLayout as? DDSingleLayout {
            layout.delegate = self
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sectionCount = arrModel.count
        return sectionCount
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrModel[section].classIdentify == "shops"{
            let shopsCount  = arrModel[section].items.count
            
            return shopsCount
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let identify =  arrModel[indexPath.section].classIdentify
        switch identify  {
        case  "classify" :
            if let classifyItem = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeClassifyItem", for: indexPath) as? HomeClassifyItem{
                classifyItem.delegate = self
//                classifyItem.nearbyComments = homeModel.data.nearbyComments ?? [DDHotComment]()
                classifyItem.hudong = homeModel.data.hudong
                if let channels = arrModel[indexPath.section].items as? [DDChannelMenuModel]{
                    classifyItem.channels = channels
                }
                return classifyItem
            }
            
        case  "scroll" :
            if let homeScrollItem = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScrollItem", for: indexPath) as? HomeScrollItem{
                homeScrollItem.delegate = self
                if let recomShops = arrModel[indexPath.section].items as? [DDHotRecom]{
                    homeScrollItem.models = recomShops
                }
                return homeScrollItem
            }
            
        case  "shops" :
            if let homeShopItem = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeShopItem", for: indexPath) as? HomeShopItem{
                if let nrstbyShops = arrModel[indexPath.section].items as? [DDNearbyShopModel]{
                    homeShopItem.shopModel = nrstbyShops[indexPath.item]
                }
                return homeShopItem
            }
            
        default :
        return collectionView.dequeueReusableCell(withReuseIdentifier: "HomeShopItem", for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeClassifyItem", for: indexPath)
        if let homeClassifyItem = cell as? HomeClassifyItem{
            
        }
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let sectionTitle = arrModel[indexPath.section].classIdentify
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeReusableHeader", for: indexPath)
            if let realHeader = header as? HomeReusableHeader{
                switch sectionTitle {
//                case  "classify" :
//                    realHeader.imageView.image = UIImage(named: "Peripheralmerchants")
                case  "scroll" :
                   
                    realHeader.imageView.image = UIImage(named: "Hotrecommendation")
                    
                case  "shops" :
                  realHeader.imageView.image = UIImage(named: "Peripheralmerchants")
                default :
                    break
                }
            }
            
            return header
        }else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DDSearchCollectionFooter", for: indexPath)
            if let realfooter = footer as? DDSearchSessionFooter{
                realfooter.label1.text =  sectionTitle //"\(indexPath.section)组,\(indexPath.item)个"
            }
            return footer
        }
    }
}
class DDLocationArrow: UIButton {
    let arrowBackImgView = UIImageView()
    let imgView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.addSubview(arrowBackImgView)
        arrowBackImgView.addSubview(imgView)
        self.setBackgroundImage(UIImage(named:"locationBackGray"), for: UIControlState.normal)
        imgView.image = UIImage(named: "position")
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        self.contentMode = UIViewContentMode.scaleAspectFit
        arrowBackImgView.image = UIImage(named: "locationArrow")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        arrowBackImgView.bounds = CGRect(x: 0, y: 0, width: 24, height: 13)
        arrowBackImgView.center = CGPoint(x:  self.bounds.width/2, y: self.bounds.height + arrowBackImgView.bounds.height/2)
        
        imgView.bounds = CGRect(x: 0, y: 0, width: arrowBackImgView.bounds.width * 0.55, height: arrowBackImgView.bounds.height * 0.55)
        imgView.center = CGPoint(x: arrowBackImgView.bounds.width/2, y: arrowBackImgView.bounds.height * 0.15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DDItem1VC : HomeScrollItemDelegate , HomeClassifyItemDelegate{
    func performSearch(keyword keyWord:String ){
        mylog("perform search : \(keyWord)")
        let searchResultVC = KeywordSearchResultVC.init(keyWord: keyWord)
        self.navigationController?.pushViewController(searchResultVC, animated: true )
    }
    func commentClick(id: String) {
        mylog("comment click \(id)")
    }
    
    @objc func keywordClick(sender:UIButton)  {
        let searchResultVC = KeywordSearchResultVC.init(keyWord: sender.title(for: UIControlState.normal) ?? "")
        self.navigationController?.pushViewController(searchResultVC, animated: true )
    }
//    func performSearch(keyword: String) {
//        mylog(keyword)
//    }
    func gotoShopDetail(id:Int) {
        mylog(id)
        let shop = DDShopVC.init(shopID: "\(id)")
        self.navigationController?.pushViewController(shop, animated: true )
    }
    @objc func locationClick(sender:DDLocationArrow){
        self.navigationController?.pushViewController(ChangeCityVC(), animated: true )
       mylog(sender.title(for: UIControlState.normal))
    }
    @objc func messageIconClick(sender:GDMsgIconView){
        mylog("meesage icon click ")
    }
    @objc func nickNameClick(sender:UIButton){
        mylog("nick name click")
        self.navigationController?.pushViewController(ChooseLanguageVC(), animated: true )
    }
}

