//
//  UAchieveColCell.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UAchieveColCell: UseBaseColCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myFrame = frame
        self.contentView.addSubview(self.collectionView)
        self.setUI(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var myFrame: CGRect = CGRect.zero
    func setUI(frame: CGRect) {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UAchieveSubColCell.self, forCellWithReuseIdentifier: "UAchieveSubColCell")
       
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectionView.bounces = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UAchieveSubColCell", for: indexPath) as! UAchieveSubColCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.myFrame.size.width / 2.0, height: self.myFrame.size.width / 2.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    lazy var collectionView: UICollectionView = {
        let collect = UICollectionView.init(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.contentView.addSubview(collect)
        collect.dataSource = self
        collect.delegate = self
        collect.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "item")
        return collect
    }()
    
}
