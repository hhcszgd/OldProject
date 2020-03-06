//
//  SChoseLanguage.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/11/3.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift

let choseLanguage = "choseLanguage"
class SChoseLanguage: GDNormalVC {

    
    let language: PublishSubject<String> = PublishSubject<String>.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(text: choseLanguage)
        self.setUI()
        // Do any additional setup after loading the view.
    }
    func setUI() {
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar)
        self.tableView.separatorStyle = .none
        self.tableView.register(NormalCell.self, forCellReuseIdentifier: "NormalCell")
        items = ["汉语", "汉语", "英语"]
        self.tableView.reloadData()
    }
    var items: [String] = [String]()
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath) as? NormalCell
        
        cell?.myTitleLabel.text = items[indexPath.row]
        return cell!
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        click.onNext(items[indexPath.row])
        click.onCompleted()
    }
    
    let click: PublishSubject<String> = PublishSubject<String>.init()
    
    
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
