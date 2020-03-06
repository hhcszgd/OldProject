//
//  CheckImage.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/28.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit
import SDWebImage
@objc protocol CheckImageDelegate: class {
    func sentColIndex(currentIndex: IndexPath)
}
/**图片点击滚动视图*/
class CheckImageView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, RecognizerActionDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout = UICollectionViewFlowLayout.init()
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.itemSize = CGSize.init(width: screenW, height: screenH)
        layout?.scrollDirection = UICollectionViewScrollDirection.horizontal
        col = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: layout!)
        col?.backgroundColor = UIColor.black
        col?.register(CheckImageCell.self, forCellWithReuseIdentifier: "CheckImageCell")
        col?.isPagingEnabled = true
        col?.delegate = self
        col?.dataSource = self
        if #available(iOS 10.0, *) {
            col?.isPrefetchingEnabled = false
        } else {
            // Fallback on earlier versions
        }
        self.addSubview(col!)
        page.currentPageIndicatorTintColor = THEMECOLOR
        page.pageIndicatorTintColor = UIColor.init(white: 0.5, alpha: 0.5)
        page.frame = CGRect.init(x: 0, y: screenH - 40, width: screenW, height: 30)
        self.addSubview(page)
        
        
        
    }
    var page: UIPageControl = UIPageControl.init()
    weak var delegate: CheckImageDelegate?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var layout: UICollectionViewFlowLayout?
    var col: UICollectionView?
    var dataArr: [BannerModel] = [BannerModel]()
    var imgRect: CGRect?
    
    var index: IndexPath = IndexPath.init(row: 0, section: 0)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func model(_ dataArr: [BannerModel], index indexPath: IndexPath, rect: CGRect) {
        col?.reloadData()
        index =  indexPath
        imgRect = rect
        self.dataArr = dataArr
        mylog(indexPath.item)
        page.numberOfPages = dataArr.count
        page.currentPage = indexPath.item;
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CheckImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckImageCell", for: indexPath) as! CheckImageCell
        cell.model(dataArr[indexPath.item], index: index, rect: imgRect!, currentIndex: indexPath)
        cell.delegate = self
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage: Int = Int(scrollView.contentOffset.x) / Int(screenW)
        page.currentPage = currentPage
    }
    
    
    
    //单击手势的实现方法
    func tapRecognizerAction(index: IndexPath) {
        self.removeFromSuperview()
        willDisplayRect = nil
        didDisaplayRect = nil
        delegate?.sentColIndex(currentIndex: index)
    }
   
}

//checkImageCell
//图片放大之后最大的宽度和高度倍数
let imageSize: CGFloat = 2.0
//视图出现之前的图片位置坐标
var willDisplayRect: CGRect?
//视图出现之后图片的位置坐标
var didDisaplayRect: CGRect?
protocol RecognizerActionDelegate: class  {
    /**单击手势，视图消失*/
    func tapRecognizerAction(index: IndexPath)
}

class CheckImageCell: BaseColCell, UIScrollViewDelegate {
    var scrollView: UIScrollView?
    weak var delegate: RecognizerActionDelegate?
    var currentIndex: IndexPath?
    let img: UIImageView = UIImageView.init()
    //记录图片的放大缩小的状态,初始化状态下图片都是缩小的状态
    var isBig: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加scrollview
        setScrollview()
        //将img添加到scrollview
        scrollView?.addSubview(img)
        img.contentMode = UIViewContentMode.scaleAspectFit
        
        setTap()
        
    }
    /**设置scrollview*/
    func setScrollview() {
        scrollView = UIScrollView.init(frame: self.bounds)
        self.contentView.addSubview(scrollView!)
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.bounces = true
        scrollView?.delegate = self
        scrollView?.isUserInteractionEnabled = true
        scrollView?.decelerationRate = UIScrollViewDecelerationRateFast
        scrollView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        //当超过最大最小缩放范围的时候缩放到最大最小范围
        
        
    }
    //设置单击双击手势
    func setTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        tap.numberOfTapsRequired = 1
        scrollView?.addGestureRecognizer(tap)
        //双击手势
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapActon(tap:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView?.addGestureRecognizer(doubleTap)
        //重要语句
        tap.require(toFail: doubleTap)
    }
    //单击收拾对应的方法
    func tapAction(tap: UIGestureRecognizer) {
        
        if didDisaplayRect != nil {
            UIView.animate(withDuration: 0.3, animations: {
                self.img.frame = CGRect.init(x: 0, y: (willDisplayRect?.origin.y)!, width: self.img.frame.size.width, height: self.img.frame.size.height)
                self.superview?.backgroundColor = UIColor.clear
            }, completion: { (false) in
                self.delegate?.tapRecognizerAction(index: self.currentIndex!)
            })
        }
    }
    //双击手势对应的方法,放大
    func doubleTapActon(tap: UIGestureRecognizer) {
        //获取双击手势点击的位置
        let point: CGPoint = tap.location(in: self.scrollView)
        if self.scrollView?.zoomScale == self.scrollView?.maximumZoomScale {
            self.scrollView?.setZoomScale((self.scrollView?.minimumZoomScale)!, animated: true)
            
        }else{
            self.scrollView?.zoom(to: CGRect.init(x: point.x, y: point.y, width: 1, height: 1), animated: true)
            
        }
        
        
    }
    //根据手势放大缩小
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX: CGFloat = (scrollView.bounds.size.width > scrollView.contentSize.width) ?  (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0
        let offsetY: CGFloat = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
            (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0
        img.center = CGPoint.init(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func model(_ model: BannerModel, index indexPath: IndexPath, rect: CGRect ,currentIndex: IndexPath) {
        //在每次赋值的时候都将图片的状态变成未被放大前的状态
        isBig = false
        //保存现在显示的cell的indexpath.在视图消失的时候传回
        self.currentIndex = currentIndex
        willDisplayRect = rect
        if let imgstr = model.img {
            img.sd_setImage(with: imgStrConvertToUrl(imgstr), placeholderImage: placeholderImage, options: SDWebImageOptions.cacheMemoryOnly, completed: { (image, error, imageCacheType, url) in
                if image != nil {
                    let imageSize: CGSize = (image?.size)!
                    let imageWidth: CGFloat = imageSize.width
                    let imageHeight: CGFloat = imageSize.height
                    
                    let scrollSize: CGSize = (self.scrollView?.bounds.size)!
                    let scrollWidth: CGFloat = scrollSize.width
                    let scrollHeight: CGFloat = scrollSize.height
                    //设置伸缩比例
                    let widthRatio: CGFloat = scrollWidth/imageWidth
                    let heightRation: CGFloat = scrollHeight/imageHeight
                    var minScale:  CGFloat =  widthRatio > heightRation ? heightRation : widthRatio
                    if minScale >= 1 {
                        minScale = 0.8
                    }
                    let maxScale: CGFloat = 2.0
                    
                    self.scrollView?.maximumZoomScale = maxScale
                    self.scrollView?.minimumZoomScale = minScale
                    self.scrollView?.zoomScale = minScale
                    
                    //设置imageview的frame
                    var imageFrame: CGRect = CGRect.init(x: 0, y: 0, width: scrollWidth, height: widthRatio * imageHeight)
                    self.scrollView?.contentSize = CGSize.init(width: 0, height: imageFrame.size.height)
                    
                    if imageWidth <= imageHeight && imageHeight < scrollHeight {
                        let x: Float = floorf(Float((scrollWidth - imageFrame.size.width) / 2.0))
                        imageFrame.origin.x = CGFloat(x) * minScale
                        let y:Float = floorf(Float((scrollHeight - imageFrame.size.height) / 2.0))
                        imageFrame.origin.y = CGFloat(y) * minScale
                        
                    }else{
                        let x: Float = floorf(Float((scrollWidth - imageFrame.size.width) / 2.0))
                        imageFrame.origin.x = CGFloat(x)
                        let y:Float = floorf(Float((scrollHeight - imageFrame.size.height) / 2.0))
                        imageFrame.origin.y = CGFloat(y)
                    }
                    
                    
                    
                    //完成出现动画后位置如果为空，那么说明是没有完成动画
                    if didDisaplayRect == nil {
                        self.img.frame = CGRect.init(x: 0, y: (willDisplayRect?.origin.y)!, width: imageFrame.size.width, height: imageFrame.size.height)
                        UIView.animate(withDuration: 0.3, animations: {
                            self.img.frame = imageFrame
                            didDisaplayRect = self.img.frame
                        })
                        
                    }else{
                        self.img.frame = imageFrame
                        
                    }
                    self.img.center = self.contentView.center
                }else {
                    didDisaplayRect = CGRect.zero
                }
                
            })
        
        }
        
    }
    
}

