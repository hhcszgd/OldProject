//
//  CategaryModel.h
//  TTmall
//
//  Created by 0 on 16/1/28.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "BaseModel.h"
//基础的模型包含一些大多数产品都包含的属性
@interface HSepcModel : BaseModel
//NSDictionary *dic = @{
//
//
//@"brand":@"ATAR",//品牌
//@"ID":@"16lao0001",//商品ID
//@"describe":@"ATAR2015冬装新款中长款毛呢外套女女绣花大衣外套女款修身呢子外套",
//@"image":@"http://p3.wmpic.me/article/2016/01/19/1453182722_eFLmZgvu.jpg",
//
//@"reserced":@"149",
//@"price":@"250 - 300",
//@"spec":@[@{@"type":@"颜色",@"typeDetail":@[@{@"quality":@"淡粉色-现货",@"reserced":@"12"},@{@"quality":@"淡粉色-现货",@"reserced":@"12"},@{@"quality":@"淡粉色-现货",@"reserced":@"12"},@{@"quality":@"淡粉色-现货",@"reserced":@"12"},@{@"quality":@"淡粉色-现货",@"reserced":@"12"}]},
//
//@{@"type":@"尺寸",@"typeDetail":@[@{@"quality":@"S",@"reserced":@"12"},@{@"quality":@"X",@"reserced":@"12"},@{@"quality":@"L",@"reserced":@"12"},@{@"quality":@"XL",@"reserced":@"12"},@{@"quality":@"XXL",@"reserced":@"12"}]}],
//
//
//@"detail":@[@{@"quality":@"淡粉色-现货",@"rang":@"现货",@"image":@"http://f.hiphotos.baidu.com/image/pic/item/91529822720e0cf3a2cdbc240e46f21fbe09aa33.jpg",@"":@[@"S",@"M",@"L",@"XL"],@"S":@"15",@"M":@"20",@"L":@"2",@"XL":@"6",@"XXL":@"0",@"XXXL":@"0"},
//@{@"quality":@"蓝色-现货",@"rang":@"加棉",@"image":@"http://b.hiphotos.baidu.com/image/pic/item/ac345982b2b7d0a29559e274cfef76094a369a43.jpg",@"price":@"300",@"size":@[@"S",@"M",@"XL"],@"S":@"15",@"M":@"20",@"L":@"0",@"XL":@"6",@"XXL":@"0",@"XXXL":@"0"},
//@{@"quality":@"淡粉色-加棉",@"rang":@"现货",@"image":@"http://d.hiphotos.baidu.com/image/pic/item/5d6034a85edf8db118248ebb0d23dd54574e74e3.jpg",@"price":@"250",@"size":@[@"M",@"L",@"XL"],@"S":@"0",@"M":@"20",@"L":@"2",@"XL":@"6",@"XXL":@"0",@"XXXL":@"0"},
//@{@"quality":@"蓝色-加棉",@"rang":@"加棉",@"image":@"http://a.hiphotos.baidu.com/image/pic/item/fd039245d688d43f7fd8771b791ed21b0ff43be2.jpg",@"price":@"260",@"size":@[@"S",@"M",@"L"],@"S":@"15",@"M":@"20",@"L":@"2",@"XL":@"0",@"XXL":@"0",@"XXXL":@"0"},
//@{@"quality":@"黑色-加棉",@"rang":@"加棉",@"image":@"http://a.hiphotos.baidu.com/image/pic/item/fd039245d688d43f7fd8771b791ed21b0ff43be2.jpg",@"price":@"260",@"size":@[@"S",@"M",@"L"],@"S":@"0",@"M":@"0",@"L":@"0",@"XXL":@"0",@"XXXL":@"0"}]
//
//
//

/**商品id*/
@property (nonatomic, copy) NSString *goods_id;
/***/
@property (nonatomic, copy) NSString *short_name;
/**库存*/
@property (nonatomic, copy) NSString *reserced;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *rang;
@property (nonatomic, copy) NSString *image;
/**价格*/
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) NSArray *size;
/**店铺id*/
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *M;
@property (nonatomic, copy) NSString *L;
@property (nonatomic, copy) NSString *XL;
@property (nonatomic, copy) NSString *store;
/**规格数据数组*/
@property (nonatomic, strong) NSMutableArray *spec;
@property (nonatomic, strong) NSMutableArray *goodsDeatil;


@end
