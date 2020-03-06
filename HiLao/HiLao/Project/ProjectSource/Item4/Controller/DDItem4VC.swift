//
//  DDItem4VC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit

class DDItem4VC: DDNormalVC {
    var collectionView : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testMidBigLayout()
        self.collectionView?.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
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
extension DDItem4VC : UICollectionViewDataSource , UICollectionViewDelegate{
    func testMidBigLayout() {
        var collectionY : CGFloat = 0
        var collectionH : CGFloat = 0
        collectionY = DDDevice.type == .iphoneX ? 44 : 0
        collectionH = DDDevice.type == .iphoneX ? (self.view.bounds.height - 44 ) - 83 : (self.view.bounds.height - 49 )
        self.collectionView =  UICollectionView.init(frame: CGRect(x: 0, y: collectionY, width: UIScreen.main.bounds.width, height: collectionH), collectionViewLayout: DDSingleLayout())
        self.view.addSubview(self.collectionView!)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "ddmidbig")
        if let layout  = collectionView?.collectionViewLayout as? DDMidBigLayout {
            layout.itemSize = CGSize(width: 90 , height: 50)
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: collectionView!.bounds.width/2 - layout.itemSize.width/2, bottom: 0, right: collectionView!.bounds.width/2 - layout.itemSize.width/2)
        }

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ddmidbig", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

