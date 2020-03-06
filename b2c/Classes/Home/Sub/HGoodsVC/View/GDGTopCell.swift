//
//  GDGTopCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//
class MyCollection: UICollectionView, UIGestureRecognizerDelegate {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.panBack(gestureRecognizer: gestureRecognizer) {
            return true
        }
        return false
    }
    func panBack(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location_c: CGFloat = 100
        if gestureRecognizer == self.panGestureRecognizer {
            if let pan = gestureRecognizer as? UIPanGestureRecognizer {
                let point = pan.translation(in: self)
                let state = gestureRecognizer.state
                if ((state == UIGestureRecognizerState.began) || (state == UIGestureRecognizerState.possible)) {
                    let location = gestureRecognizer.location(in: self)
                    if (point.x >= 0 && location.x < location_c) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//if ([self panBack:gestureRecognizer]) {
//    return YES;
//}
//return NO;
//}
//- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer{
//    CGFloat location_c = 100;
//    if (gestureRecognizer == self.panGestureRecognizer) {
//        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
//        CGPoint point = [pan translationInView:self];
//        UIGestureRecognizerState state = gestureRecognizer.state;
//        if ((state == UIGestureRecognizerStateBegan)|| (state == UIGestureRecognizerStatePossible)) {
//            CGPoint location = [gestureRecognizer locationInView:self];
//            if (point.x > 0 && location.x < location_c && self.contentOffset.x <= 0) {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

import UIKit
protocol GDGTopCellDelegate: class {
    
    func configmentSelectButtonWithItem(tag: Int)
}

class GDGTopCell: GDGoodsBaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var delegate:GDGTopCellDelegate?
    override var goods_id: String? {
        didSet{
            col?.reloadData()
        }
    }
    var col: MyCollection?
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(productCellSentValue(notification:)), name: NSNotification.Name.init("SENTVALUETOTOP"), object: nil)
        setCollection()
        self.contentView.addSubview(col!)
    }
    func setCollection() -> () {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        col = MyCollection.init(frame: CGRect(x: 0, y: 0, width: screenW, height: self.contentView.bounds.size.height), collectionViewLayout: layout)
        col?.register(GDTProductCell.self, forCellWithReuseIdentifier: "GDTProductCell")
        col?.register(GDTDetailCell.self, forCellWithReuseIdentifier: "GDTDetailCell")
        col?.register(GDTEvaluateCell.self, forCellWithReuseIdentifier: "GDTEvaluateCell")
        col?.delegate = self
        col?.dataSource = self
        col?.isPagingEnabled = true
        col?.bounces = false
        
    }
    //dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let goodsCell:GDGoodsBaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GDTProductCell", for: indexPath) as! GDGoodsBaseCell
            if goods_id != "" {
                goodsCell.goods_id = goods_id
            }
            goodsCell.backgroundColor = UIColor.randomClr()
            return goodsCell
        }
        if indexPath.item == 1 {
            let detailCell:GDGoodsBaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GDTDetailCell", for: indexPath) as! GDGoodsBaseCell
            if goods_id != "" {
                detailCell.goods_id = goods_id
            }
            detailCell.backgroundColor = UIColor.randomClr()
            return detailCell
        }
        if indexPath.item == 2 {
            let evCell:GDGoodsBaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GDTEvaluateCell", for: indexPath) as! GDGoodsBaseCell
            if goods_id != "" {
                evCell.goods_id = goods_id
            }
            evCell.backgroundColor = UIColor.randomClr()
            return evCell
        }
        return UICollectionViewCell.init()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: screenW, height: screenH - 64 - 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = (col?.contentOffset.x)!/screenW
        if delegate != nil {
            delegate?.configmentSelectButtonWithItem(tag: Int(index))
        }
    }
    
    func productCellSentValue(notification: NSNotification){
        _ = notification.userInfo?[AnyHashable("model")] as! GDBaseModel
        if let action = notification.userInfo?[AnyHashable("action")] as? String {
            switch action {
            case "evaluate":
                self.col?.scrollToItem(at: IndexPath.init(item: 2, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
                delegate?.configmentSelectButtonWithItem(tag: 2)
                break
            default:
                break
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
