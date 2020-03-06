//
//  BaseWebVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
#import <WebKit/WebKit.h>
#import "HGTopSepecificationModel.h"
#import "HSpecSubGoodsDeatilModel.h"
#import "HSepcModel.h"



@interface BaseWebVC : SecondBaseVC
/**被选中的具体的组*/
@property (nonatomic, strong) NSMutableArray *selectIndexPaths;
/**规格模型*/
@property (nonatomic, strong) HSepcModel *sepcModel;
@property (nonatomic, strong) HGTopSepecificationModel *sepecificationModel;
/**规格组合模型*/
@property (nonatomic, strong) HSpecSubGoodsDeatilModel *goodsDetailModel;
@property(nonatomic,assign)CGRect  shopCarIconFrame ;//购物车图标在控制器view上的位置 , 方便执行添加购物车动画 , 有购物车icon的子类去赋值

@property(nonatomic,strong)UIActivityIndicatorView * activetyIndicator ;
-(instancetype)initWithURLStr:(NSString*)urlStr;
@property(nonatomic,copy)NSString * originURL ;
@property(nonatomic,weak)WKWebView * webview ;

-(void)uploadimg;
@end
