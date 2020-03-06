//
//  GDEvaluateCell.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDEvaluateCell: GDBaseCell {

    var titleLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.white)
    lazy var lineView1 = { () -> UIView in
        let view = UIView.init()
        view.backgroundColor = BackGrayColor
        return view
    }()
    lazy var lineView2 =  { () -> UIView in
        let view = UIView.init()
        view.backgroundColor = BackGrayColor
        return view
    }()
    lazy var lineView3 =  { () -> UIView in
        let view = UIView.init()
        view.backgroundColor = BackGrayColor
        return view
    }()
    lazy var lineView4 =  { () -> UIView in
        let view = UIView.init()
        view.backgroundColor = BackGrayColor
        return view
    }()
    lazy var evluateOne: ZkqEvaluateSubView = ZkqEvaluateSubView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    lazy var evluateTWo: ZkqEvaluateSubView = ZkqEvaluateSubView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    lazy var checkEvaluateLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.white)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(10)
            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(14)
        }
        
    }
    
    var evaluateModel: GDEvaluateModel = GDEvaluateModel.init(dict: ["data": "" as AnyObject]){
        didSet{
            titleLabel.text = evaluateModel.channel!
            if let items = evaluateModel.items {
                switch items.count {
                case 0:
                    if !self.contentView.subviews.contains(lineView4) {
                        self.contentView.addSubview(lineView4)
                        lineView4.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(10)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
                            _ = make?.width.equalTo()(screenW)
                            _ = make?.height.equalTo()(10)
                        })
                    }
                    if let channel = evaluateModel.channel {
                        titleLabel.text = channel
                    }
                    
                    
                    break
                case 1:
                    if !self.contentView.subviews.contains(lineView1) {
                        self.contentView.addSubview(lineView1)
                        self.contentView.addSubview(evluateOne)
                        self.contentView.addSubview(lineView4)
                        lineView1.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(12)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(1)
                        })
                        
                        evluateOne.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.lineView1.mas_bottom)?.setOffset(0)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(60))
                        })
                        
                        lineView4.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.evluateOne.mas_bottom)?.setOffset(0)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
                            _ = make?.height.equalTo()(10)
                        })
                        evluateOne.evaluateSubModel = items[0] as! ZkqEvaluateModel
                        if (evaluateModel.channel != nil) && (evaluateModel.num != nil) {
                            titleLabel.text = "\(evaluateModel.channel!)(\(evaluateModel.num!))"
                        }

                    }
                    
                    break
                case 2:
                    if !self.contentView.subviews.contains(lineView1) {
                        self.contentView.addSubview(lineView1)
                        self.contentView.addSubview(evluateOne)
                        self.contentView.addSubview(lineView2)
                        self.contentView.addSubview(lineView4)
                        self.contentView.addSubview(evluateTWo)
                        self.contentView.addSubview(lineView3)
                        self.contentView.addSubview(checkEvaluateLabel)
                        lineView1.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(12)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(1)
                        })
                        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(checkAllEvaluate))
                        evluateOne.isUserInteractionEnabled = true
                        evluateOne.addGestureRecognizer(tap1)
                        evluateOne.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.lineView1.mas_bottom)?.setOffset(0)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(60))
                        })
                        lineView2.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.evluateOne.mas_bottom)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.width.equalTo()(screenW - GDCalculator.GDAdaptation(55) - 21)
                            _ = make?.height.equalTo()(1)
                            
                        })
                        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(checkAllEvaluate))
                        evluateTWo.isUserInteractionEnabled = true
                        evluateTWo.addGestureRecognizer(tap2)
                        evluateTWo.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.lineView2.mas_bottom)?.setOffset(0)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(60))
                        })
                        
                        lineView3.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.evluateTWo.mas_bottom)?.setOffset(0)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            _ = make?.height.equalTo()(1)
                        })
                        
                        checkEvaluateLabel.mas_makeConstraints({ (make) in
                            _ = make?.centerX.equalTo()(self.contentView)
                            make?.top.equalTo()(self.lineView3.mas_bottom)?.setOffset(11)
                            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(33))
                            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(100))
                        })
                        
                        
                        
                        lineView4.mas_makeConstraints({ (make) in
                            make?.top.equalTo()(self.checkEvaluateLabel.mas_bottom)?.setOffset(11)
                            make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
                            _ = make?.height.equalTo()(10)
                        })
                        evluateTWo.evaluateSubModel = items[1] as! ZkqEvaluateModel
                        evluateOne.evaluateSubModel = items[0] as! ZkqEvaluateModel
                        
                    }
                    if (evaluateModel.channel != nil) && (evaluateModel.num != nil) {
                        titleLabel.text = "\(evaluateModel.channel!)(\(evaluateModel.num!))"
                    }
                    checkEvaluateLabel.text = "查看全部评价"
                    checkEvaluateLabel.textAlignment = NSTextAlignment.center
                    checkEvaluateLabel.layer.borderColor = UIColor.colorWithHexStringSwift("999999").cgColor
                    checkEvaluateLabel.layer.borderWidth = 1
                    checkEvaluateLabel.layer.cornerRadius = GDCalculator.GDAdaptation(6)
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(checkAllEvaluate))
                    checkEvaluateLabel.isUserInteractionEnabled = true
                    checkEvaluateLabel.addGestureRecognizer(tap)
                    break
                default:
                    break
                }
            }else {
                if !self.contentView.subviews.contains(lineView4) {
                    self.contentView.addSubview(lineView4)
                    lineView4.mas_makeConstraints({ (make) in
                        make?.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(10)
                        make?.left.equalTo()(self.contentView.mas_left)?.setOffset(0)
                        make?.right.equalTo()(self.contentView.mas_right)?.setOffset(0)
                        make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(0)
                        _ = make?.width.equalTo()(screenW)
                        _ = make?.height.equalTo()(10)
                    })
                }
                if let channel = evaluateModel.channel {
                    titleLabel.text = channel
                }
            }
        }
    }
    //查看全部评价
    func checkAllEvaluate() {
        let model = GDBaseModel.init(dict: nil)

        let userinfo = [AnyHashable("model"): model as Any, AnyHashable("action"): "evaluate" as Any]
        NotificationCenter.default.post(name: NSNotification.Name.init("SENTVALUETOTOP"), object: nil, userInfo: userinfo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ZkqEvaluateSubView: UIView {
    var nickImageView: UIImageView = UIImageView.init()
    var nickLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 11), textColor: UIColor.colorWithHexStringSwift("999999"), backColor: UIColor.white)
    var contentLabel: UILabel = UILabel.creatLabel(GDFont.systemFont(ofSize: 13), textColor: UIColor.colorWithHexStringSwift("333333"), backColor: UIColor.white)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(nickImageView)
        self.addSubview(nickLabel)
        self.addSubview(contentLabel)
        nickLabel.sizeToFit()
        contentLabel.sizeToFit()
        nickImageView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.mas_top)?.setOffset(5)
            make?.left.equalTo()(self.mas_left)?.setOffset(20)
            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(25))
            _ = make?.height.equalTo()(GDCalculator.GDAdaptation(25))
        }
        nickImageView.layer.masksToBounds = true
        nickImageView.layer.cornerRadius = GDCalculator.GDAdaptation(25)/2.0
        
        
        nickLabel.mas_makeConstraints { (make) in
            _ = make?.centerX.equalTo()(self.nickImageView.mas_centerX)
            make?.top.equalTo()(self.nickImageView.mas_bottom)?.setOffset(0)
            _ = make?.width.equalTo()(GDCalculator.GDAdaptation(55))
            
        }
        nickLabel.textAlignment = NSTextAlignment.center
        
        contentLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.nickLabel.mas_right)?.setOffset(21)
            make?.top.equalTo()(self.mas_top)?.setOffset(0)
            make?.bottom.equalTo()(self.mas_bottom)?.setOffset(0)
            make?.right.equalTo()(self.mas_right)?.setOffset(0)
        }
        
    }
    
    
    var evaluateSubModel: ZkqEvaluateModel = ZkqEvaluateModel.init(dict: ["data": "" as AnyObject]) {
        didSet{
            if let img = evaluateSubModel.img {
                nickImageView.sd_setImage(with: imgStrConvertToUrl(img), placeholderImage: placeholderImage)
            }
            if let nick = evaluateSubModel.nick {
                nickLabel.text = nick
            }
            if let content = evaluateSubModel.content {
                contentLabel.text = content
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
