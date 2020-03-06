//
//  SelectAreaCodeVC.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/26.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class SelectAreaCodeVC: GDNormalVC {
    let viewModel = AreaCodeViewModel.init()
    let bag = DisposeBag.init()
    var modelSelect: PublishSubject<AreaCodeModel> = PublishSubject<AreaCodeModel>.init()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.attributeTitle = GDNavigatBar.attributeTitle(font: UIFont.systemFont(ofSize: 17), textColor: UIColor.white, text: "searchCode")
        self.naviBar.backgroundColor = mainColor
        
        self.viewModel.getData()
        self.tableView.delegate = self
        self.tableView.dataSource = nil
        self.configMentTable()
        // Do any additional setup after loading the view.
    }
    
    func configMentTable() {
        self.tableView.register(AreaCodeCell.self, forCellReuseIdentifier: "AreaCodeCell")
        self.tableView.register(AreaCodeHeader.self, forHeaderFooterViewReuseIdentifier: "AreaCodeHeader")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        self.view.setNeedsUpdateConstraints()
        self.view.updateConstraintsIfNeeded()
        
        
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, AreaCodeModel>>.init(configureCell:{ (source, table, index, model) -> UITableViewCell in
            let cell: AreaCodeCell = table.dequeueReusableCell(withIdentifier: "AreaCodeCell", for: index) as! AreaCodeCell
            cell.model = model
            return cell
        })
        
        self.viewModel.items.asObservable().bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        self.tableView.rx.modelSelected(AreaCodeModel.self).asObservable().subscribe { [weak self](model) in
            guard let myModel = model.element else {
                return
            }
            self?.modelSelect.onNext(myModel)
            self?.modelSelect.onCompleted()
            self?.navigationController?.popViewController(animated: true)
        }
        
        
        viewModel.items.asObservable().subscribe { [weak self](dataArr) in
            self?.tableView.reloadData()
        }
       
        
        self.tableView.rowHeight = 40
    
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = 44
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var header: AreaCodeHeader? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AreaCodeHeader") as? AreaCodeHeader
//        if header == nil {
//            header = AreaCodeHeader.init(reuseIdentifier: "AreaCodeHeader")
//        }
//        let sectionModel = viewModel.items.value[section]
//        header?.titleLabel.text = sectionModel.model
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.tableView.frame = CGRect.init(x: 0, y: DDNavigationBarHeight, width: SCREENWIDTH, height: childVCHeightNoNaviAndTabBar)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        mylog("销毁")
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
