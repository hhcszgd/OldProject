//
//  DDShopVC.swift
//  Project
//
//  Created by WY on 2017/12/15.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import CoreLocation

import Alamofire
class DDItem2VC: DDNoNavibarVC {
    var pageNum : Int  = 1
    var hudongApiModel : DDHuDongApiModel?
    var cover  : GDCoverView?
    var shopID :String = ""
//    let backBtn = UIButton.init(frame: CGRect.zero)
//    let likeBtn = UIButton.init(frame: CGRect.zero)
    let shareBtn = UIButton.init(frame: CGRect.zero)
//    let addBtn =  UIButton.init(frame: CGRect.zero)
    let titleLbl = UILabel.init(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        configNaviBar()
        configTableView()
        // Do any additional setup after loading the view.
        DDRequestManager.share.huDong(page: pageNum , true )?.responseJSON(completionHandler: { (response ) in

            let jsonDecoder = JSONDecoder.init()
            mylog(response.value)
            do{
                let result = try jsonDecoder.decode(DDHuDongApiModel.self , from: response.data ?? Data())
                self.hudongApiModel  = result
                self.tableView?.reloadData()
                mylog(result.data)
            }catch{
                mylog(error)
            }
        })
    }
    @objc func refresh()  {
        request(.refresh)?.responseJSON(completionHandler: { (response ) in

            let jsonDecoder = JSONDecoder.init()
            mylog(response.value)
            do{
                let result = try jsonDecoder.decode(DDHuDongApiModel.self , from: response.data ?? Data())
                self.hudongApiModel  = result
                self.tableView?.reloadData()
                mylog(result.data)
            self.tableView?.gdRefreshControl?.endRefresh(result: .success)
            }catch{
                mylog(error)
            self.tableView?.gdRefreshControl?.endRefresh(result: .failure)
            }
        })
    }
    func request(_ loadType : DDLoadType) -> DataRequest?  {
        switch loadType {
        case .initialize , .refresh:
            self.pageNum = 1
        case .loadMore:
            self.pageNum += 1
        }
        return  DDRequestManager.share.huDong(page: pageNum , true )
    }
    @objc func loadMore()  {
        request(.loadMore)?.responseJSON(completionHandler: { (response ) in
            
            let jsonDecoder = JSONDecoder.init()
            mylog(response.value)
            do{
                let result = try jsonDecoder.decode(DDHuDongApiModel.self , from: response.data ?? Data())
                if let tempData = result.data {
                    self.hudongApiModel?.data?.append(contentsOf: tempData)
                    self.tableView?.gdLoadControl?.endLoad(result: GDLoadResult.success)
                }else{
                    self.tableView?.gdLoadControl?.endLoad(result: GDLoadResult.nomore)
                }
                self.tableView?.reloadData()
                mylog(result.data)
            }catch{
                mylog(error)
                self.tableView?.gdLoadControl?.endLoad(result: GDLoadResult.failure)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
///ui
extension DDItem2VC{
    func configNaviBar() {
//        self.naviBar.addSubview(backBtn)
//        self.naviBar.addSubview(likeBtn)
        self.naviBar.addSubview(shareBtn)
//        self.naviBar.addSubview(addBtn)
        self.naviBar.addSubview(titleLbl)
        titleLbl.textAlignment = NSTextAlignment.center
//        self.likeBtn.setImage(UIImage(named:"unselectedcollection"), for: UIControlState.normal)
//        self.likeBtn.setImage(UIImage(named:"heart_icon"), for: UIControlState.selected)
        self.shareBtn.setImage(UIImage(named:"share_icon"), for: UIControlState.normal)
//        self.addBtn.setImage(UIImage(named:"plus_icon"), for: UIControlState.normal)
        
//        backBtn.frame = CGRect(x: 10, y: self.naviBar.height - 44, width: 44, height: 44)
//        backBtn.setImage(UIImage(named: "back_icon"), for: UIControlState.normal)
//        backBtn.addTarget(self , action: #selector(goback), for: UIControlEvents.touchUpInside)
        self.naviBar.backgroundColor = mainColor
        
//        likeBtn.frame = CGRect(x: naviBar.bounds.width - 44 * 2 , y: naviBar.height - 44, width: 44, height: 44)
        
        shareBtn.frame = CGRect(x: naviBar.bounds.width - 44 , y: naviBar.height - 44, width: 44, height: 44)
//        addBtn.frame = CGRect(x: naviBar.bounds.width - 44 , y: naviBar.height - 44, width: 44, height: 44)
//        addBtn.addTarget(self , action: #selector(addBtnClick(sender:)), for: UIControlEvents.touchUpInside)
//        addBtn.adjustsImageWhenHighlighted = false
        
//        likeBtn.addTarget(self , action: #selector(lickBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        shareBtn.addTarget(self , action: #selector(shareBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        
        titleLbl.bounds = CGRect(x: 0 , y: 0 , width: shareBtn.frame.minX - shareBtn.bounds.width , height: 44)
        titleLbl.center = CGPoint(x: naviBar.bounds.width/2, y: naviBar.bounds.height - titleLbl.bounds.height/2)
                titleLbl.text = DDLanguageManager.text("tabbar_item2_title")
        titleLbl.textColor = UIColor.white
//        changeShareBtnStatus()
    }
    func configTableView() {
        
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: DDNavigationBarHeight, width:  self.view.bounds.width, height:  self.view.bounds.height - DDNavigationBarHeight - 88), style: UITableViewStyle.grouped)
        self.view.addSubview(tableView!)
        
        self.tableView?.estimatedRowHeight = 0;
        self.tableView?.estimatedSectionHeaderHeight = 0;
        self.tableView?.estimatedSectionFooterHeight = 0;
        self.tableView?.separatorStyle = .none
        self.tableView?.gdLoadControl = GDLoadControl.init(target: self , selector: #selector(loadMore))
        self.tableView?.gdRefreshControl = GDRefreshControl.init(target: self , selector: #selector(refresh))
        tableView?.delegate = self
        tableView?.dataSource = self
        if #available(iOS 11.0, *) {
            self.tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
       
    }
    
}
/// actions
extension DDItem2VC{
    
    @objc func lickBtnClick(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        self.tableView?.reloadData()
    }
    @objc func corverItemClick(sender:UIButton){
        mylog(sender.tag)
        //to do something
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            self.navigationController?.pushViewController(DDCreateDahuoVC(), animated: true )
            break
        default:
            break
        }
        self.cover?.remove()
        self.cover = nil
    }
    @objc func shareBtnClick(sender:UIButton){
            let titles = ["发布点评","发现商家","发起搭伙","发布点评","发现商家","发起搭伙"]
            cover = GDCoverView.init(superView: self.view)
            cover?.addTarget(self , action: #selector(conerClick(sender:)) , for: UIControlEvents.touchUpInside)
//            cover?.layoutViewToBeShow(action: { () in
                for index in 0..<titles.count{
                    let button  = UIButton.init(frame:CGRect(x: SCREENWIDTH, y: DDNavigationBarHeight + CGFloat(44 * index), width: 88, height: 40))
                    button.tag = index
                    button.addTarget(self , action: #selector(corverItemClick(sender:)), for: UIControlEvents.touchUpInside)
                    cover?.addSubview(button)
                    button.backgroundColor = UIColor.randomColor()
                    button.setTitle(titles[index], for: UIControlState.normal)
                }
                    for (index ,view) in (self.cover?.subviews.enumerated())!{
                        UIView.animate(withDuration: 0.3, delay: TimeInterval(CGFloat(index) * 0.05), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            view.frame = CGRect(x: SCREENWIDTH - 88 , y: DDNavigationBarHeight + CGFloat(44 * index), width: 88, height: 40)
                        }, completion: { (bool ) in
                            
                        })
                    }
                
//            })
    }
    
    @objc func conerClick(sender : GDCoverView)  {
        for (index ,view) in sender.subviews.enumerated(){
            UIView.animate(withDuration: 0.3, delay: TimeInterval(CGFloat(index) * 0.05), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                view.frame = CGRect(x: SCREENWIDTH + 22 , y: DDNavigationBarHeight + CGFloat(44 * index), width: 88, height: 40)
            }, completion: { (bool ) in
                sender.remove()
                self.cover = nil
            })
        }
    }
//    func changeShareBtnStatus(_ status:Bool = false)  {
//        shareBtn.isHidden = status
//        addBtn.isHidden = !status
//        titleLbl.isHidden = !status
//        if status {
//            self.naviBar.backgroundColor = UIColor.orange.withAlphaComponent(1)
//        }else{
//            self.naviBar.backgroundColor = UIColor.orange.withAlphaComponent(0)
//        }
//    }
    @objc func addBtnClick(sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            })
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
    }
    @objc func goback()  {
        self.popToPreviousVC()
    }
}

extension DDItem2VC :UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rowModel =  hudongApiModel?.data?[indexPath.row]{
            switch rowModel.data_type {
            case "1"://发表评论
                self.navigationController?.pushViewController(DDCommentDetailVC(rowModel.comment_id ?? ""), animated: true)
                break
            case "4" , "10" , "15"://关注店铺 , 发现店铺 , 入驻店铺
                self.navigationController?.pushViewController(DDShopVC(shopID: rowModel.shop_id ?? ""), animated: true)
                break
            case "6"://获得成就
                break
            case "7"://创建新搭伙
                self.navigationController?.pushViewController(DDHudongDetailVC(rowModel.board_id ?? ""), animated: true)
                
                break
            default:
                break;
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hudongApiModel?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rowModel =  hudongApiModel?.data?[indexPath.row]{
            switch rowModel.data_type {
            case "1"://发表评论
                if let cell  = tableView.dequeueReusableCell(withIdentifier: "DDHDCommentCell") as? DDHDCommentCell{
                    cell.model1 = rowModel
                    return cell
                }else{
                    let cell =   DDHDCommentCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DDHDCommentCell")
                    cell.model1 = rowModel
                    return cell
                }
            case "4" , "10" , "15"://关注店铺 , 发现店铺 , 入驻店铺
                if let cell  = tableView.dequeueReusableCell(withIdentifier: "DDHDShopCell") as? DDHDShopCell{
                    cell.model1 = rowModel
                    return cell
                }else{
                    let cell =   DDHDShopCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DDHDShopCell")
                    cell.model1 = rowModel
                    return cell
                }
            case "6"://获得成就
                if let cell  = tableView.dequeueReusableCell(withIdentifier: "DDHDFruitionCell") as? DDHDFruitionCell{
                    cell.model1 = rowModel
                    return cell
                }else{
                    let cell =   DDHDFruitionCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DDHDFruitionCell")
                    cell.model1 = rowModel
                    return cell
                }
            case "7"://创建新搭伙
                if let cell  = tableView.dequeueReusableCell(withIdentifier: "DDHDDahuoCell") as? DDHDDahuoCell{
                    cell.model1 = rowModel
                    return cell
                }else{
                    let cell =   DDHDDahuoCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DDHDDahuoCell")
                    cell.model1 = rowModel
                    return cell
                }
            default:
                break;
            }
        }
        
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "DDHudongCell") {
            return cell
        }else{
            let cell =   UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DDHudongCell")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let model  =  hudongApiModel?.data?[indexPath.row] {
            switch model.data_type {
            case "1"://发表评论
                return DDHDCommentCell.rowHeight(model: model)
//                return 288//计算
            case "4" , "10" , "15"://关注店铺 , 发现店铺 , 入驻店铺
                return DDHDShopCell.rowHeight(model)
            case "6"://获得成就
                return DDHDFruitionCell.rowHeight(model: model)
//                return 130
            case "7"://创建新搭伙
                return DDHDDahuoCell.rowHeight(model: model)
//                return 288 // 计算
            default:
                return 110
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
    }
//
    //    override var preferredStatusBarStyle: UIStatusBarStyle{
    //        return .lightContent
    //    }
}

