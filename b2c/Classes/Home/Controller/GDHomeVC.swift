//
//  GDHomeVC.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDHomeVC: GDNormalVC {
    var img: UIImage?
    var scrollToTopButton: UIButton?
    var searchContentLabel: UILabel?
//    var messageButton: 
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        scrollToTopButton = UIButton.init(frame: CGRect.init(x: screenW - 60, y: screenH - 132, width: 42, height: 42))
        scrollToTopButton?.adjustsImageWhenHighlighted = false
        scrollToTopButton?.isHidden = true
        scrollToTopButton?.setImage(UIImage.init(named: "btn_Top"), for: UIControlState.normal)
        self.view.addSubview(scrollToTopButton!)
        scrollToTopButton?.addTarget(self, action: #selector(scrollToTop), for: UIControlEvents.touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    func scrollToTop() {
        
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
