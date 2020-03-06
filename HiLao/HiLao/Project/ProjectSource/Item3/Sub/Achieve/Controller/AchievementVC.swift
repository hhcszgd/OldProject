//
//  AchievementVC.swift
//  Project
//
//  Created by 张凯强 on 2017/11/30.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class AchievementVC: GDNormalVC, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: "achievement")
        self.naviBar.rightBarButtons = [self.classDescriptionBtn]
        self.mainView.backgroundColor = UIColor.white
        
        self.leftBackImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.mainView.snp.left)
            make.width.equalTo(124)
            make.height.equalTo(30)
            make.bottom.equalTo(self.mainView.snp.top).offset(1)
        }
        self.rightBackImage.snp.makeConstraints { (make) in
            make.right.equalTo(self.mainView.snp.right)
            make.width.equalTo(124)
            make.height.equalTo(30)
            make.bottom.equalTo(self.mainView.snp.top).offset(1)
        }
        self.haveBtn.snp.makeConstraints { (make) in
            make.width.equalTo(124)
            make.left.equalTo(self.mainView.snp.left)
            make.height.equalTo(30)
            make.bottom.equalTo(self.mainView.snp.top).offset(1)
        }
        self.noHaveBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.mainView.snp.right)
            make.width.equalTo(124)
            make.height.equalTo(30)
            make.bottom.equalTo(self.mainView.snp.top).offset(1)
        }
        self.haveAction(btn: self.haveBtn)
        
        
        self.mainView.addSubview(self.collectionView)
        self.collectionView.frame = self.mainView.bounds
        self.setUI()
        
        // Do any additional setup after loading the view.
    }
    func setUI() {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UAchieveSubColCell.self, forCellWithReuseIdentifier: "UAchieveSubColCell")
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectionView.bounces = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.white
        
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.haveBtn.isSelected {
            return self.haveItems.count
        }else {
            return self.noHaveItems.count
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UAchieveSubColCell", for: indexPath) as! UAchieveSubColCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.mainView.bounds.size.width / 2.0, height: self.mainView.bounds.size.width / 2.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    let leftSelectImage = UIImage.init(named: "achievementselection")
    let leftNoSelectImage = UIImage.init(named: "unselectedachievements_r")
    let rightSelectImage = UIImage.init(named: "achievementselection_r")
    let rightNoSelectImage = UIImage.init(named: "unselectedachievements")
    ///等级说明
    @objc func classdescriptionAction(btn: UIButton) {
        
    }
    @objc func haveAction(btn: AchieveBtn) {
        btn.isSelected = true
        self.noHaveBtn.isSelected = false
        self.leftBackImage.image = leftSelectImage
        self.rightBackImage.image = rightNoSelectImage
        guard let memeberID = DDAccount.share().id else {
            return
        }
        let paramte = ["l": LCode, "c": CountryCode, "member_id": memeberID] as [String: Any]
        NetWork.manager.requestData(router: Router.post("member/achievement", .memberNoPassPort, paramte)).subscribe(onNext: { (dict) in
            let model = BaseModel<AchieveModel<AchieveInfoModel>>.deserialize(from: dict)
            if model?.status == 501 {
                guard let dataArr = model?.data?.info else {
                    return
                }
                self.haveItems = dataArr
                self.collectionView.reloadData()
            }else {
                
            }
        }, onError: { (error ) in
            
        }, onCompleted: {
            mylog("结束")
        }, onDisposed: nil)
        
        
    }
    var haveItems: [AchieveInfoModel] = []
    var noHaveItems: [AchieveInfoModel] = []
    @objc func noHaveAction(btn: AchieveBtn) {
        btn.isSelected = true
        self.haveBtn.isSelected = false
        self.leftBackImage.image = leftNoSelectImage
        self.rightBackImage.image = rightSelectImage
        
        guard let memeberID = DDAccount.share().id else {
            return
        }
        let paramte = ["l": LCode, "c": CountryCode, "member_id": memeberID] as [String: Any]
        NetWork.manager.requestData(router: Router.post("member/noAchieves", .memberNoPassPort, paramte)).subscribe(onNext: { (dict) in
            let model = BaseModel<AchieveModel<AchieveInfoModel>>.deserialize(from: dict)
            if model?.status == 501 {
                guard let dataArr = model?.data?.info else {
                    return
                }
                self.noHaveItems = dataArr
                self.collectionView.reloadData()
            }else {
                
            }
        }, onError: { (error ) in
            
        }, onCompleted: {
            mylog("结束")
        }, onDisposed: nil)
    }
    lazy var leftBackImage: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(view)
        return view
    }()
    lazy var rightBackImage: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(view)
        return view
    }()
    lazy var haveBtn: AchieveBtn = {
        let btn = AchieveBtn.init(frame: CGRect.zero)
        self.view.addSubview(btn)
        btn.titleLabel.text = "已有"
        btn.subTitlelabel.text = "8"
        btn.addTarget(self, action: #selector(haveAction(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var noHaveBtn: AchieveBtn = {
        let btn = AchieveBtn.init(frame: CGRect.zero)
        btn.addTarget(self, action: #selector(noHaveAction(btn:)), for: .touchUpInside)
        btn.titleLabel.text = "尚未获得"
        btn.subTitlelabel.text = "99"
        btn.isSelected = false
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var classDescriptionBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(DDLanguageManager.text("classDescription"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        let size = DDLanguageManager.text("classDescription").sizeWith(font: UIFont.systemFont(ofSize: 17), maxWidth: 200)
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(classdescriptionAction(btn:)), for: .touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: size.width + 10, height: 44)
        return btn
    }()
    lazy var mainView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = lineColor.cgColor
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        self.view.addSubview(view)
        view.frame = CGRect.init(x: 27, y: DDNavigationBarHeight + 75, width: SCREENWIDTH - 54, height: SCREENHEIGHT - DDNavigationBarHeight - 30 - 35 - TabBarHeight - 50)
        return view
    }()

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

class AchieveBtn: GDControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitlelabel)
        self.titleLabel.sizeToFit()
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.textColor = UIColor.colorWithRGB(red: 72, green: 72, blue: 72)
        self.subTitlelabel.sizeToFit()
        self.subTitlelabel.font = UIFont.systemFont(ofSize: 14)
        self.subTitlelabel.textColor = UIColor.colorWithHexStringSwift("fe5f5f")
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.subTitlelabel.snp.makeConstraints { (make ) in
            make.left.equalTo(self.titleLabel.snp.right)
            make.centerY.equalToSuperview()
        }
        
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.titleLabel.textColor = UIColor.colorWithRGB(red: 72, green: 72, blue: 72)
                self.subTitlelabel.textColor = UIColor.colorWithHexStringSwift("fe5f5f")
                
            }else {
                self.titleLabel.textColor = UIColor.white
                self.subTitlelabel.textColor = UIColor.white
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



