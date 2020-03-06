//
//  GDBannerView.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/28.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
@objc protocol GDBannerViewDelegate: class {
    /**传送点击cell的下标，传送数据源，传送点击cell在屏幕中的位置*/
    func sentValue(_ index: IndexPath, dataArr data: [BannerModel], rect viewRect: CGRect)
}
//默认全部都有滚动条
enum GDBannerViewType {
    //自动循环滚动
    case AutomaticCycleRollingWithPage
    case AutomaticCycleRollingWithNumPage
    //不自动循环滚动
    case NoAutomaticCycleRollingWithPage
    case NoAutomaticCycleRollingWithNumPage
    
    //
    
}
class GDBannerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    //数据源
    init(frame: CGRect, subFrame: CGRect) {
        super.init(frame: frame)
        subViewFrame = subFrame
        setCollection()
        self.addSubview(collectionview!)
        
//        switch viewType {
//        case .AutomaticCycleRollingWithNumPage:
//            type = .AutomaticCycleRollingWithNumPage
//            setNumLabel()
//            break
//        case .AutomaticCycleRollingWithPage:
//            setPage()
//            type = .AutomaticCycleRollingWithPage
//            break
//        case .NoAutomaticCycleRollingWithNumPage:
            type = .NoAutomaticCycleRollingWithNumPage
            setNumLabel()
//            break
//        case .NoAutomaticCycleRollingWithPage:
//            type = .NoAutomaticCycleRollingWithPage
//            setPage()
//            break
//            
//        }
    }
    var dataArr: [BannerModel] = [BannerModel](){
        didSet{
            collectionview?.reloadData()
            switch type {
            case .AutomaticCycleRollingWithNumPage:
                self.addTimer()
                numLabel.text = String("1/\(dataArr.count)")
                break
            case .AutomaticCycleRollingWithPage:
                self.addTimer()
                page.numberOfPages = dataArr.count
                page.currentPage = 0
                break
            case .NoAutomaticCycleRollingWithNumPage:
                numLabel.text = String("1/\(dataArr.count)")
                break
            case .NoAutomaticCycleRollingWithPage:
                page.numberOfPages = dataArr.count
                page.currentPage = 0
                break
                
            }
            
            
        }
    }
    weak var delegate: GDBannerViewDelegate?
    var numLabel: UILabel = UILabel.init(){
        didSet{
            
        }
    }
    
    lazy var page = UIPageControl.init()
    func setPage() {
        self.addSubview(page)
        page.currentPageIndicatorTintColor = UIColor.colorWithHexStringSwift("ff7900")
        page.pageIndicatorTintColor = UIColor.colorWithHexStringSwift("ffffff").withAlphaComponent(0.7)
        page.frame = CGRect.init(x: (subViewFrame.origin.x), y: (subViewFrame.origin.y), width: (subViewFrame.size.width), height: (subViewFrame.size.height))
    }
    
    
    var subViewFrame: CGRect = CGRect.init(x: 0, y: screenW - 30, width: screenW, height: 20)
    var type: GDBannerViewType = .NoAutomaticCycleRollingWithNumPage
    
    
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(cycleRolling), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    func removeTimer() {
        timer?.invalidate()
    }
    var timer: Timer?
    
    
    func cycleRolling() {
        if let currentIndexPath = collectionview?.indexPathsForVisibleItems.last {
            //重新设置index
            let currentIndexPathReset = IndexPath.init(item: currentIndexPath.item, section: 1)
            collectionview?.scrollToItem(at: currentIndexPathReset, at: UICollectionViewScrollPosition.left, animated: false)
            var nextItem = currentIndexPathReset.item + 1
            var nextSection = currentIndexPathReset.section
            if nextItem ==  self.dataArr.count {
                nextItem = 0
                nextSection += 1
            }
            switch type {
            case .AutomaticCycleRollingWithNumPage:
                numLabel.text = "\(nextItem + 1)/\(dataArr.count)"
                break
            case .AutomaticCycleRollingWithPage:
                page.currentPage = nextItem
                break
            case .NoAutomaticCycleRollingWithNumPage:
                break
            case .NoAutomaticCycleRollingWithPage:
                break
            }
            collectionview?.scrollToItem(at: IndexPath.init(item: nextItem, section: nextSection), at: UICollectionViewScrollPosition.left, animated: true)
            
        }
        
    }
    func setNumLabel () {
        self.addSubview(numLabel)
        numLabel.sizeToFit()
        numLabel.font = UIFont.systemFont(ofSize: 15)
        numLabel.textColor = UIColor.colorWithHexStringSwift("ffffff")
        numLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        numLabel.textAlignment = NSTextAlignment.center
        numLabel.layer.masksToBounds = true
        numLabel.layer.cornerRadius = subViewFrame.size.height / 2.0
        numLabel.frame = CGRect.init(x: (subViewFrame.origin.x), y: (subViewFrame.origin.y), width: (subViewFrame.size.width), height: (subViewFrame.size.height))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var collectionview: UICollectionView?
    func setCollection() -> () {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionview = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height), collectionViewLayout: layout)
        collectionview?.showsHorizontalScrollIndicator = false
        collectionview?.delegate = self
        collectionview?.dataSource = self
        collectionview?.isPagingEnabled = true
        collectionview?.backgroundColor = UIColor.white
        collectionview?.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch type {
        case .AutomaticCycleRollingWithNumPage:
            return 3
        case .AutomaticCycleRollingWithPage:
            return 3
        case .NoAutomaticCycleRollingWithNumPage:
            return 1
        case .NoAutomaticCycleRollingWithPage:
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.bannderModel = dataArr[indexPath.item]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = (Int)(scrollView.contentOffset.x/(collectionview?.frame.size.width)! + 1)
        let allcount = String(self.dataArr.count)
        let i = String(index)
        let num = i.appending("/\(allcount)")
        
        switch type {
        case .AutomaticCycleRollingWithNumPage:
            break
        case .AutomaticCycleRollingWithPage:
            break
        case .NoAutomaticCycleRollingWithNumPage:
            numLabel.text = num
            break
        case .NoAutomaticCycleRollingWithPage:
            page.currentPage = index - 1
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rect = self.convert(self.bounds, to: window)
        let index = IndexPath.init(item: indexPath.item, section: 0)
        delegate?.sentValue(index, dataArr: self.dataArr, rect: rect)
    }
}


