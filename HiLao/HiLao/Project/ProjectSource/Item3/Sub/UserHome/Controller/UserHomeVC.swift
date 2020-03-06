//
//  UserHomeVC.swift
//  Project
//
//  Created by 张凯强 on 2017/12/17.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UserHomeVC: GDNormalVC, UICollectionViewDelegateFlowLayout {
    let viewModel = UseHomeViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.backgroundColor = UIColor.clear
        self.naviBar.showLineview = false
        self.headerView.backgroundColor = UIColor.white
        self.headerView.index.subscribe(onNext: { [weak self](index) in
            self?.collectionView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        self.configNav()
        self.setUI()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func configNav() {
        let privatechat = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        let unselectedcollection = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        privatechat.setImage(UIImage.init(named: "privatechat"), for: .normal)
        privatechat.addTarget(self, action: #selector(privatechatAction), for: .touchUpInside)
        unselectedcollection.setImage(UIImage.init(named: "unselectedcollection"), for: .normal)
        unselectedcollection.addTarget(self, action: #selector(unselectedcollectionAction), for: .touchUpInside)
        self.naviBar.rightBarButtons = [privatechat, unselectedcollection]
        
        
    }
    func setUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UseBaseColCell.self, forCellWithReuseIdentifier: "UseBaseColCell")
        self.collectionView.register(UContentColCell.self, forCellWithReuseIdentifier: "UContentColCell")
        self.collectionView.register(UFollowColCell.self, forCellWithReuseIdentifier: "UFollowColCell")
        self.collectionView.register(UAchieveColCell.self, forCellWithReuseIdentifier: "UAchieveColCell")
        let height = SCREENHEIGHT - self.headerView.max_Y - TabBarHeight - 5
        self.collectionView.frame = CGRect.init(x: 0, y: self.headerView.max_Y + 5, width: SCREENWIDTH, height: height)
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView.isPagingEnabled = true
        self.collectionView.bounces = false
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UContentColCell", for: indexPath) as! UContentColCell
            cell.backgroundColor = UIColor.randomColor()
            return cell
        }else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFollowColCell", for: indexPath) as! UFollowColCell
            cell.backgroundColor = UIColor.randomColor()
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UAchieveColCell", for: indexPath) as! UAchieveColCell
            cell.backgroundColor = UIColor.randomColor()
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = SCREENHEIGHT - self.headerView.max_Y - TabBarHeight - 5
        return CGSize.init(width: SCREENWIDTH, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / SCREENWIDTH)
        self.headerView.scrollIndex(index: index)
    }
    
    
    
    @objc func privatechatAction() {
        
    }
    @objc func unselectedcollectionAction() {
        
    }
    
    
    lazy var headerView: UseHomeHeaderView = {
        let propert = CGFloat(440) / CGFloat(750)
        let view = UseHomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: propert * SCREENWIDTH), viewModel: self.viewModel)
        self.view.addSubview(view)
        return view
    }()
    
    deinit {
        mylog("个人主页销毁")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
