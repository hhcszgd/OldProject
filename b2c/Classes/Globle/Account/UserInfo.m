//
//  UserInfo.m
//  TTmall
//
//  Created by wangyuanfei on 16/1/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "UserInfo.h"
//#import "CellModel.h"
#import "GDXMPPStreamManager.h"
//#import "PersonalInfo.h"
#import "UserInfoViewModel.h"
#import "PerformChatTool.h"
#import "ChatModel.h"
#import "AMCellModel.h"//地址模型
#import "b2c-Swift.h"
@interface UserInfo ()<PerformChatToolDelegate,UserInfoViewModelDelegate>

@property(nonatomic,strong)  PerformChatTool * chatTool ;
@property(nonatomic,strong)UserInfoViewModel * viewModel ;
/** 联系人查询控制器 */
//@property (nonatomic , strong)NSFetchedResultsController * contactFetchedresultsController;
/** 单个联系人的消息查询控制器 */
//@property (nonatomic , strong)NSFetchedResultsController * messageFetchedresultsController;

@end


@implementation UserInfo
static UserInfo * userInfo = nil;


//+(instancetype)shareUserInfo{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        userInfo = [[UserInfo alloc]init];
//    });
//    return userInfo;
//}

+(void)initialize{
    [[UserInfo shareUserInfo] initialization];
}

+(instancetype)shareUserInfo{
    if (userInfo==nil) {
        userInfo = [[UserInfo alloc]init];
        userInfo.member_id=@"loginout";

    }

    return userInfo;

}
-(NSString *)head_images{
    if (_head_images) {
        
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).absoluteString);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).path);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).relativeString);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).scheme);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).resourceSpecifier);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).parameterString);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).relativePath);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,ImageUrlWithString(_head_images).path);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,_head_images);
        if ([_head_images hasPrefix:@"http"]) {
            return _head_images;
        }else{
            return ImageUrlWithString(_head_images).absoluteString;
        }
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"头像地址为空");
    return @"null";
}

-(NSString *)member_id{
    if (_member_id) {
        return _member_id;
    }else{
        return @"";
    }
}
//-(void)observernetworking:(NSNotification*)note
//{
//    if (!self.chatTool) { //如果登录 ,  创建链接
//                    PerformChatTool * chatTool = [[PerformChatTool alloc]init];
//                    chatTool.AcceptMessateDelegate = self;
//                    self.chatTool = chatTool;
//        
//    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,note.userInfo);
//}
//-(PersonalInfo * )personalInfo{
//    if(_personalInfo==nil){
//        _personalInfo = [[PersonalInfo alloc]initWithDict:nil];
//    }
//    
//    return _personalInfo;
//}

//-(void)setupNetworkStatus
//{
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkingChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
////    
//    
//    
//    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
//                break;
//            default:
//                break;
//        }
//    } ];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//}

/**
-(void)setupNetworkStatus
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
                userInfo.networkingStatus = NETERROR;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
                userInfo.networkingStatus = NETERROR;
                //            [self viewWhenNetWorkingError];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
                userInfo.networkingStatus = NETMOBILE;
                //            [self reloadWhenNecworkingReconnect];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
                userInfo.networkingStatus = NETWIFI;
                //            [self reloadWhenNecworkingReconnect];
                break;
            default:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
                break;
        }

    } ];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}
-(void)netWorkingChangeWithStatus:(AFNetworkReachabilityStatus)status
{
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
            self.networkingStatus = NETERROR;
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
            self.networkingStatus = NETERROR;
//            [self viewWhenNetWorkingError];
            
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
//            [self.viewWhenNetWorkingError removeFromSuperview];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
            self.networkingStatus = NETMOBILE;
            //            [self reloadWhenNecworkingReconnect];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
//            [self.viewWhenNetWorkingError removeFromSuperview];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
            self.networkingStatus = NETWIFI;
            //            [self reloadWhenNecworkingReconnect];
            break;
        default:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
            break;
    }
}

*/
-(NSUInteger)currentImgMode{
    NSUInteger currentImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentImgMode"] integerValue];
    return currentImgMode;

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)initialization{
    UserInfo * temp = [UserInfo read];
    if (![temp.member_id isEqualToString:@"loginout"] && temp.member_id.length>0 ) {
        userInfo = temp;
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"读取用户归档信息成功  且当前状态为登录状态")
    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未登录 , 请重新登录")
        
    }
//    if (temp.member_id>0) {
//        userInfo = temp;
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"读取用户归档信息成功  且当前状态为登录状态")
//
////        if (userInfo.isLogin) return;
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未登录 , 请重新登录")
//        
//
////        [viewModel initializationWithUser:self];
//    }
    
}

-(void)loginSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel]  loginWithUser:self success:^(ResponseStatus response) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.loginSuccessBlack)
        if (self.loginSuccessBlack) {
            self.loginSuccessBlack();
        }
        if (!self.chatTool) { //如果登录 ,  创建链接
//            PerformChatTool * chatTool = [[PerformChatTool alloc]init];
//            chatTool.AcceptMessateDelegate = self;
//            self.chatTool = chatTool;
        }

        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

#pragma about IM  
-(void)messageFromOthers:(ChatModel *)chatModel inChatTool:(PerformChatTool *)chatTool{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,chatModel.message);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessage" object:nil userInfo:@{@"chatModel":chatModel}];
    
}

-(void)registerSuccess:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] registerWithUser:self Success:^(ResponseObject *response) {
       //注册成功的回调
        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
        success(response);
    } failure:^(NSError *error) {
        //注册失败的回调
        failure(error);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];

}
-(void)gotMobileCodeWithType:(MobileCodeType)type Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    
    [[UserInfoViewModel shareViewModel] gotMobileCodeWithUser:self mobileCodeType:type Success:^(ResponseStatus response) {
        success (response);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];


}
-(void)addShopingCarWithGoods_id:(NSString *)goods_id goodsNum:(NSInteger)num sub_id:(NSInteger)sub_id now:(NSString *)now Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] addShopingCarWithUser:self goods_id:goods_id  goodsNum:num sub_id:sub_id now:now Success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    

}
-(void)gotShopingCarSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopingCarWithUser:self success:^(ResponseStatus response) {
        
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)deleteShopingCarWithGoodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;{
    [[UserInfoViewModel shareViewModel] deleteShopingCarWithUser:self goodsID:goodsID success:^(ResponseStatus response) {

        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];


}
/**判断店铺是否收藏*/
- (void)judgeShopIsCollectionWithShopID:(NSString *)shopID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] judgeShopIsCollectionWithUser:self shopID:shopID success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
/** 更改购物车商品数量 */
-(void) changeCountOfGoodsInShopingCarWithGoodsId:(NSUInteger)goodsId goodsNum:(NSUInteger)goodsNum success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] changeCountOfGoodsInShopingCarWithUser:self goodsId:goodsId goodsNum:goodsNum success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/**获取购物车中商品的个数*/
-  (void)gotShopCarNumberSuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopCarNumberWithUser:self Success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

/** 确认订单接口 , 商品id通过字符串的形式传递给goods_id 字段  多个goodsid就用 , 连接 */
-(void)confirmOrderWithGoodsId:(NSString*)goodsId addressID:(NSString*)addressID success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] confirmOrderWithUser:self goodsId:goodsId addressID:addressID success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 添加商品收藏 */

-(void)addGoodsFavoriteWithGoods_id:(NSString *)goods_id  Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] addGoodsFavoriteWithUser:self goods_id:goods_id  Success:^(ResponseObject *response) {
        
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 获取商品收藏 */
-(void)gotGoodsFavoriteSuccess:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotGoodsFavoriteWithUser:self success:^(ResponseObject* response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 删除商品收藏 这个方法传的参数是SVCGoods的goodsid  不是goods_id */
-(void)deleteGoodsFavoriteWithGoodsID:(NSString *)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] deleteGoodsFavoriteWithUser:self goodsID:goodsID success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
    }];

}
/**判断商品是否收藏*/
- (void)judgeGoodsIsCollectionWithGoodsID:(NSString *)goodsID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] judgeGoodsIsCollectionWithUser:self GoodsID:goodsID success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/** 首页点击进入获取优惠券 */
-(void)gotCouponsDataWithPageNum:(NSUInteger)pageNum price_id:(NSUInteger)price_id classify_id:(NSUInteger)classify_id  success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCouponsDataWithUser:self pageNum:pageNum price_id:price_id classify_id:classify_id success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];


}

/** 获取优惠券详情数据 */
-(void)gotCouponsDetailDataWithCouponsID:(NSUInteger)couponsID   success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCouponsDetailDataWithUser:self couponsID:couponsID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];




}

/** 领取优惠券 */
-(void)gotCouponsWithCouponsID:(NSString*)couponsID   success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCouponsWithUser:self couponsID:couponsID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];


}
/** 正确的 获取首页个体自产数据 */
-(void)gotIndividualDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotIndividualDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


/** 获取首页田园牧歌数据 */
-(void)gotCountrysideDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCountrysideDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 获取首页民族兄弟数据 */
-(void)gotNationalDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotNationalDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


/**咨询与反馈*/
- (void)gotAskAndFeedDataSuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotAskAndFeedWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**体验问题*/
- (void)gotFeedBackDataSuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotFeedBackDataWithUser:self Success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**提交体验问题*/
- (void)postFeedBackDataWithquestionType:(NSString *)questionType questionDesc:(NSString *)questionDesc Success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] postFeedBackDataWithUser:self questionType:questionType questionDesc:questionDesc Success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**投诉问题*/
- (void)gotComplaintDataSuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotComplaintDataWithUser:self Success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/*推送*/
-(void)registerPushNotificationID:(NSString*)deviceToken registerID:(NSString*) registerID Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] registerPushNotificationID:self  deviceToken:deviceToken registerID:registerID Success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
#pragma mark -- 厂家直销
- (void)gotFactorySellsuccess:(void (^)(ResponseObject *response))success failure:(void (^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] gotFactorySellWithUser:self success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 母婴馆
- (void)gotBabySuccess:(void (^)(ResponseObject *response))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotBabyWithUser:self success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 特许经营
- (void)gotFranchisesuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotFranchiseWithUser:self succss:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 超市
- (void)gotSuperMarketsuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotSuperMarketWithUser:self succss:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 超市分类
- (void)gotSuperMarketClassisysuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotSuperMarketClassisyWithUser:self success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)gotSuperMarketThreeLevelClassisyWithClassID:(NSUInteger)classID channel_id:(NSString *)channel_id success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotSuperMarketThreeLevelClassisyWithUser:self andClassID:classID channel_id:channel_id success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 电器城
- (void)gotHomeApplicancesuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotHomeAppliancesCenterWithUser:self succss:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma 店铺操作
-(void)addShopFavoriteWithShop_id:(NSString *)shop_id   Success:(void(^)(ResponseObject*))success failure:(void(^)(NSError*))failure{
    [[UserInfoViewModel shareViewModel] addShopFavoriteWithUser:self shop_id:shop_id Success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
-(void)gotShopFavoriteSuccess:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotShopFavoriteWithUser:self success:^(ResponseObject* response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)deleteShopFavoriteWithShop_id:(NSString *)shop_id success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] deleteShopFavoriteWithUser:self shop_id:shop_id success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        
    }];
}

#pragma 获取分类列表
//-(void)gotclassifySuccess:(void (^)(ResponseStatus))success failure:(void (^)(NSError *))failure
-(void)gotClassifySuccess:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotClassifyWithUser:self success:^(ResponseObject* response) {
       success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

#pragma 获取子分类列表
-(void)gotSubClassifyWithClassID:(NSUInteger)classID success:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{

    [[UserInfoViewModel shareViewModel] gotSubClassifyWithUser:self andClassID:classID success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 获取商品列表页面
- (void)gotListOfGoodsWithClassID:(NSInteger)classID page:(NSInteger)pageNumber sort:(NSInteger)sort sortOrder:(NSString *)sortOrder success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotListOfGoodsWithUser:self classID:classID pageNumber:pageNumber sort:sort sortOrder:sortOrder success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




//-(void)uploadPictureWithPicData:(NSData*)picData success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
//    [[UserInfoViewModel shareViewModel] uploadPictureWithUser:self picData:nil success:^(ResponseStatus response) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
//}


#pragma 获取商品信息
-(void)gotGoodsDetailDataWithGoodsID:(NSString *)goodsID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotGoodsDetailDataWithUser:self goodsID:goodsID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 获取商品评价
- (void)gotEvaluateOfGoodsWithgoodsID:(NSString *)goodsID evluation:(NSInteger)evluate pageNumber:(NSInteger)pageNumber success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotEvaluateOfGoodsWithUser:self goodsID:goodsID evluation:evluate page:pageNumber success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 获得商品详情
- (void)gotProdectDetailWithGoodID:(NSString *)goodsID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotProductDetailWithUser:self goodID:goodsID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




#pragma mark -- 获得看了又看

- (void)gotProductSeeAndSeeWithGoodid:(NSString *)goodID page:(NSInteger)page success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotProdectSeeAndSeeWithUser:self GoodID:goodID page:page success:^(ResponseObject *responseObjec) {
        success(responseObjec);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 添加商品足迹
- (void)addGoodsFootmarkWithmember_id:(NSInteger)member_id cat_id:(NSInteger)cat_id goods_id:(NSInteger)goods_id success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] addGoodsFootmarkWithUser:self member_id:self.member_id cat_id:cat_id goods_id:cat_id success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma 商品规格
- (void)gotGoodsSpecWithgoods_id:(NSString *)goodID succes:(void (^)(ResponseObject *))succes failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotGoodsSpecWithUser:self goods_id:goodID succes:^(ResponseObject *responseObject) {
        succes(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 店铺首页
-(void)gotShopDetailDataWithShopID:(NSString *)shopID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotShopDetailDataWithUser:self shopID:shopID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

#pragma mark --全部商品
- (void)gotStoreAllGoodsWithShopID:(NSString *)shopID sort:(NSInteger)sort sortOrder:(NSString *)sortOrder pageNumber:(NSInteger)pageNumber success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopAllGoodsWithUser:self storeID:shopID sort:sort sortOrder:sortOrder pageNumber:pageNumber success:^(ResponseObject *reponseObject) {
        success(reponseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 上新
- (void)gotShopShangXinWithStoreID:(NSString *)storeID sort:(NSInteger)sort sortOrder:(NSString *)sortOrder pageNumber:(NSInteger)pageNumber success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopShangXinWithUser:self storeID:storeID sort:sort sortOrder:sortOrder pageNumber:pageNumber success:^(ResponseObject *reponseObject) {
        success(reponseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 店铺的全部分类接口
- (void)gotStoreAllClassWithShopID:(NSInteger)shopID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopAllClassDataWithUser:self shopID:shopID success:^(ResponseObject *responseOnject) {
        success(responseOnject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**查询全部分类*/
- (void)gotShopGoodsDataWithClassID:(NSString *)classID sort:(NSInteger)sort sortOrder:(NSString *)sortOrder pageNumber:(NSInteger)pageNumber success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopGoodsDataWithUser:self classID:classID sort:sort sortOrder:sortOrder pageNumber:pageNumber success:^(ResponseObject *responseOnject) {
        success(responseOnject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 店铺故事
- (void)gotShopSotryDataWithShopID:(NSInteger)shopID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopStoryDataWithUser:self shopID:shopID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 店铺搜索
- (void)gotShopSearchDataWithShopID:(NSString *)shopID keyword:(NSString *)keyword page:(NSInteger)page sort:(NSInteger)sort sortOrder:(NSString*)sortOrdr success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopSearchDataWithUser:self shopID:shopID keyword:keyword page:page sort:(NSInteger)sort sortOrder:(NSString*)sortOrdr success:^(ResponseObject *responseObjec) {
        success(responseObjec);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -- 店铺资质
- (void)gotSHopAptitudeDataWithShopID:(NSInteger)shopID success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopAptiudeDataWithUwer:self shopID:shopID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)gotPersonalInfoSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{//获取个人信息,有点多余
    
    
    [[UserInfoViewModel shareViewModel] gotPersonalInfWithUser:self success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
//    [[UserInfoViewModel shareViewModel] gotPersonalInfWithUser:self success:^(id response) {
//        success(response);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,value)
    }
    if ([key isEqualToString:@"id"]) {
        self.ID=[value integerValue];
        LOG(@"_%@_%d_用户id - > %@",[self class] , __LINE__,value);
        return;
    }
    if (value) [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(void)save {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    BOOL   or=   [NSKeyedArchiver archiveRootObject:self toFile:path];

    LOG(@"_%@_%d_用户信息归档成功与否---->%d",[self class] , __LINE__,or)
}
+(instancetype )read{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    
    UserInfo * newUserinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return newUserinfo ;
}
+(void)deleteUserINfoResult:(void(^)(BOOL paramete))DeleteResult
{

    
    
    
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isSuccess = [fileManager removeItemAtPath:path error:nil];
//    DeleteResult(pa);
        if (isSuccess) {
            NSLog(@"delete success");
            DeleteResult(YES);
        }else{
            NSLog(@"delete fail");
            DeleteResult(NO);
        }
}

/** 退出登录 */
-(void)loginOutSuccess:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[GDStorgeManager share] deleteUserFileWithPath:@"" callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr ) {
        GDlog(@"删除xmpp照片缓存结果%@",resultStr)
        
    }];
    [[GDStorgeManager share] deleteFormContentWithUserName:nil  callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr) {
        GDlog(@"删除xmpp消息历史缓存结果%@",resultStr)
    }];
    /** 有网没网的情况下都清楚本地账户信息数据(服务器判断登录状态是通过token和member_id都符合的情况下) */
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSuccess = [fileManager removeItemAtPath:path error:nil];
    LOG(@"_%@_%d_删除个人归档成功与否 --- >  %d",[self class] , __LINE__,isSuccess);
//    self.member_id = 0 ;
    self.member_id = @"loginout" ;
    //    userInfo=nil;
    self.name=nil;
    self.level=-1 ;
    self.birthday = nil ;
    self.head_images=nil;
    

    /** 有网状态下删除服务器的token达到退出 */
    [[UserInfoViewModel shareViewModel]loginOutWithUser:self success:^(ResponseObject *responseObject) {
        if (responseObject.status>0) {

        }else{
        
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINOUTSUCCESS object:nil];
//        [[GDXmppStreamManager ShareXMPPManager].XmppStream disconnectAfterSending];
        [[GDXmppStreamManager ShareXMPPManager] xmppLoginout];
//        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deletedObjects];
//        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext  reset ];
//        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            
//            [self performDeleteMessageCache];
        });
        
//        [self loginOutResult:^(BOOL paramete) {
//            
//        }];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


//-(void)performDeleteMessageCache
//{
//    
//
//    
//    
//    
//    
//    [NSFetchedResultsController deleteCacheWithName:@"Recently"];
//    [self.contactFetchedresultsController performFetch:nil];
//    NSArray * arr  =  self.contactFetchedresultsController.fetchedObjects;
//    for (XMPPMessageArchiving_Contact_CoreDataObject *contact  in arr) {
//        [self clearMessageHistoryWithContact:contact];
//        
//        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:contact];
//    }
//    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
//    
//    
//}

//-(NSFetchedResultsController *)contactFetchedresultsController
//{
//    if (_contactFetchedresultsController == nil) {
//        //查询请求
//        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
//        //实体描述
//        
//        NSEntityDescription *entitys =  [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
//        
//        fetchrequest.entity = entitys;
//        
//#pragma mark 查询请求控制器需要一个排序
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mostRecentMessageTimestamp" ascending:YES];
//        fetchrequest.sortDescriptors = @[sort];
//        
//        //创建懒加载对象(查询请求控制器)
//        _contactFetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Recently"];
//        
////        _fetchedresultsController.delegate = self;
//    }
//    return _contactFetchedresultsController;
//}



-(void)clearMessageHistoryWithContact:(XMPPMessageArchiving_Contact_CoreDataObject*)contact
{
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
    //        [fetchrequest setFetchLimit:20];
    //从游离态中获取实体描述
    NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
    //设置实体描述
    fetchrequest.entity = entitys;
    
    
    //设置谓词(条件筛选)
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",contact.bareJid.bare];
    fetchrequest.predicate = pre;
    //
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    fetchrequest.sortDescriptors = @[sort];
    
    NSFetchedResultsController* messageFetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
    
    
    
    /////
    //执行查询控制器
    [NSFetchedResultsController deleteCacheWithName:@"Message"];
    
    /** 原来(始) */
    [messageFetchedresultsController performFetch:nil];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
    NSArray * messages = messageFetchedresultsController.fetchedObjects;
    for (XMPPMessageArchiving_Message_CoreDataObject * message in messages) {
        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:message];
    }
    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];


}



//-(NSFetchedResultsController *)messageFetchedresultsController
//{
//    if (_messageFetchedresultsController == nil) {
//        
//        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
//        //        [fetchrequest setFetchLimit:20];
//        //从游离态中获取实体描述
//        NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
//        //设置实体描述
//        fetchrequest.entity = entitys;
//        
//        
//        //设置谓词(条件筛选)
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",self.UserJid.bare];
//        fetchrequest.predicate = pre;
//        //
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
//        fetchrequest.sortDescriptors = @[sort];
//        
//        _messageFetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
//        
//        //设置代理
//        _messageFetchedresultsController.delegate = self;
//        /** 好友列表对象 */
//        //        [[GDXmppStreamManager ShareXMPPManager].XmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    return _messageFetchedresultsController;
//}


-(void)loginOutResult:(void(^)(BOOL paramete))loginOutResult
{
    [UserInfo deleteUserINfoResult:^(BOOL result) {
        if (result) {
            //    self.token = nil ;
            self.member_id =@"loginout" ;
            //    userInfo=nil;
            self.name=nil;
            self.level=-1 ;
            self.head_images=nil;
            
            [[GDXmppStreamManager ShareXMPPManager].XmppStream disconnectAfterSending];
            loginOutResult(YES);
        }else {
            loginOutResult(NO);
        }
    }];

    

}
+ (NSArray *)mj_allowedCodingPropertyNames{
    return @[@"name",@"member_id",@"education",@"ID",@"nickname",@"password",@"saltcode",@"true_name",@"id_type",@"id_number",@"email",@"level",@"growth",@"integral",@"validity_start",@"head_images",@"mobile",@"telephone",@"telephone_ext",@"country",@"province",@"city",@"area",@"address",@"birthday",@"interested",@"marital_status",@"industry",@"company",@"department",@"position",@"earning",@"create_at",@"update_at",@"registration_ip",@"last_login_ip",@"last_login_time",@"balance",@"freeze",@"balancepwd",@"verified",@"bank_card",@"key",@"isLogin",@"username"] ;
    
}

#pragma NSCoping
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self mj_encode:aCoder];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        [self mj_decode:aDecoder];
        
    }
    return self;
}

-(BOOL)isLogin{

    if (![userInfo.member_id  isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([userInfo.member_id isEqualToString:@"loginout"]) {
        [self initialization];
        return NO;
    }else{
        return YES;
    }
}
-(void)setShoppingCarData:(NSMutableArray *)shoppingCarData{
    _shoppingCarData = shoppingCarData;
    self.shopCarDataHasChange = YES;
//    if ([self.delegate respondsToSelector:@selector(reloadShoppingCarData)]) {
//        [self.delegate reloadShoppingCarData];
//    }

}

////////////////////////////////以下方法直接返回网络数据/////////////////////////////////////
-(void)gotProfileDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotProfileDataWithUser:self success:^(ResponseObject * responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)gotHomeDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotHomeDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
            if (!self.chatTool) { //如果登录 ,  创建链接
//                            PerformChatTool * chatTool = [[PerformChatTool alloc]init];
//                            chatTool.AcceptMessateDelegate = self;
//                            self.chatTool = chatTool;
                
            }
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)gotGuessLikeDataWithChannel_id:(NSString *)channel_id PageNum:(NSUInteger)pageNum success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    
    [[UserInfoViewModel shareViewModel] gotGuessLikeDataWithUser:self Channel_id:channel_id pageNum:pageNum success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
         failure(error);
    }];
//    [[UserInfoViewModel shareViewModel] gotGuessLikeDataWithUser:self success:^(ResponseObject *responseObject) {
//        
//    } failure:^(NSError *error) {
//       
//    }];

}


/** 上传头像 */
-(void)uploadPictureWithPicBase64:(NSString*)picBase64   targetType:(NSUInteger)type success:(void(^)(id response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] uploadPictureWithUser:self picBase64:picBase64  targetType:type  success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

#pragma 捞便宜
-(void)gotLaoCheapDataWithPageNum:(NSUInteger)pageNum success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotLaoCheapDataWithUser:self pageNum:(NSUInteger)pageNum  success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


#pragma 捞故事
-(void)gotLaoStoryDataWithPageNum:(NSUInteger)pageNum success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotLaoStoryDataWithUser:self pageNum:pageNum success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 全站搜索商品 */
-(void)searchGoodsInGlobleWithKeyWord:(NSString*)keyWord channel_id:(NSString *)channel_id order:(NSUInteger)order sortOrder:(NSString *)sortOrder pageNum:(NSUInteger)pageNum success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] searchGoodsInGlobleWithUser:self keyWord:keyWord order:order sortOrder:sortOrder pageNum:pageNum channel_id:channel_id success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 搜索页（热、历史） */
-(void)gotSearchPageDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotSearchPageDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];


}
/** 消息中心接口 */
-(void)gotMessageCenterDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotMessageCenterDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 提交订单后 , 查看订单商品列表 */
-(void)gotOrderGoodsDetail:(NSString*)goodsID addressID:(NSString*)addressID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotOrderGoodsDetailWithUser:self goodsID:goodsID addressID:addressID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 提交订单后 , 查看订单商品对应的优惠券 */
-(void)gotOrderCouponseListWithGoodsID:(NSString*)goodsID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotOrderCouponseListWithUser:self goodsID:goodsID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
/** 生成订单 */
-(void)creatOrderWithUserGoods_ID:(NSString*)goodsID payMent:(NSString*)payment shipingType:(NSString*)shipingType invoiceOrNot:(NSString*)invoice couponsIDs:(NSString*)couponsIDs LBCount:(NSString*)lbCount    addressID:(NSString*)addressID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] creatOrderWithUserInfo:self goods_ID:goodsID payMent:payment shipingType:shipingType invoiceOrNot:invoice couponsIDs:couponsIDs LBCount:lbCount  addressID:(NSString*)addressID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 获取订单详情 */
-(void)gotOrderDetailWithOrderID:(NSString*)orderID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotOrderDetailWithUser:self orderID:orderID success:^(ResponseObject *responseObject) {
         success(responseObject);
     } failure:^(NSError *error) {
         failure(error);
     }];
}/**取消订单*/
- (void)cancleorderID:(NSString *)orderID success:(void (^)(ResponseObject *responseObject))success failure:(void (^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] cancleOrderWithUser:self orderID:orderID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 获取地址列表 */

-(void)gotAddressSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotAddressWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 新建收货地址 */
-(void)creatNewAddressWithModel:(AMCellModel*)addressModel success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] creatNewAddressWithUser:self addressModel:addressModel success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 修改收货地址 */
-(void)editAddressWithAddressModel:(AMCellModel*)addressModel success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] editAddressWithUser:self addressModel:addressModel success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 删除收货地址 */
-(void)deleteAddressWithAddressModel:(AMCellModel*)addressModel success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{

    [[UserInfoViewModel shareViewModel] deleteAddressWithUser:self addressModel:addressModel success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 设置为默认地址 */
-(void)setDefaultAddressWithAddressModel:(AMCellModel*)addressModel success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] setDefaultAddressWithUser:self addressModel:addressModel success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 获取国家列表 */
-(void)gotCountryListSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCountryListWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 获取省份列表 */
-(void)gotProvinceListWithCountry_id:(NSString*)country_id success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotProvinceListWithUser:self country_id:country_id success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 获取城市列表 */
-(void)gotCityListWithProvince_id:(NSString*)province_id success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCityListWithUser:self province_id:province_id success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 获取国省市区的总接口(改) */
-(void)gotAreaListWithAreaType:(int)areaType areaID:(NSString*)areaID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotAreaListWithUser:self areaType:areaType areaID:areaID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 余额支付 */
-(void)payByBalanceWithOrderID:(NSString*)orderID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] payByBalanceWithUser:self orderID:orderID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 支付宝订单信息rsa加密 */
-(void)encryptAlipayOrderID:(NSString*)orderID success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] encryptAlipayOrderDataWithUserInfo:self orderID:orderID success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 验证支付宝支付结果 */
-(void)verifyAlipayResult:(NSString*)alipayResult success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] verifyAlipayResultWithUserInfo:self alipayResult:alipayResult success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/**微信统一下单接口*/
- (void)gotWeiXinUniformOrderWithorder_code:(NSString *)order_code Success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotWeiXinUniformOrderWithUser:self order_code:order_code Success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




/** 获取银联流水号tn */
-(void)gotUnionTnWithOrderInfo:(NSString*)orderInfo success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotUnionTnWithUserInfo:self orderInfo:orderInfo success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
/** 检查用户名或者手机号是否已经被注册 */
-(void)checkUserNameOrMobileWithUserName:(NSString*)userName mobile:(NSString*)mobile email:(NSString*)email mobilecode:(NSString*)mobilecode  success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] checkUserNameOrMobileWithUserInfo:self userName:userName mobile:mobile email:email mobilecode:mobilecode success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 找回密码时 验证用户名是否存在 , 检查用户名时有返回值的,返回手机或者邮箱 跟上个方法属于同一个接口 , 为了明了分开写了*/
-(void)checkUserNameOrMobileWithFindbackname:(NSString*)findbackname findbackmobile:(NSString*)findbackmobile findbackemail:(NSString*)findbackemail  success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] checkUserNameOrMobileWithUserInfo:self findbackname:findbackname findbackmobile:findbackmobile findbackemail:findbackemail success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 通过用户名或者手机找回密码 , 改邮箱找回时  , 判断用户是否绑定邮箱 跟上个方法属于同一个接口 , 为了明了分开写了*/
-(void)gotEmaileByUsernameOrMobile:(NSString*)content success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotEmaileWithUser:self byUsernameOrMobile:content success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];



}
/** 修改个人信息 */
-(void)editUserInfoWithNewUserInfo:(UserInfo*)newUserInfo success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] editUserInfo:self withNewUserInfo:newUserInfo success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 重置密码 */
-(void)resetPasswordWithAuthType:(NSString*)authType password:(NSString*)password success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] resetPasswordWithUserInfo:self withAuthType:authType password:password success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 设置图片质量模式 */
/**  0:waifai状态 1：非waifai状态*/
-(void)setupNetworkStates:(NSUInteger)satus success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] setupNetworkStatesWithUserInfo:self status:_status success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 获取当前账户余额 */
-(void)gotBanlanceWithUserInfoSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotBanlanceWithUserInfo:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 验证旧登录密码的正确性 */
-(void)checkOldLoginPasswordWithOldLoginPassword:(NSString*)oldLoginPassword success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] checkOldLoginPasswordWithUser:self oldLoginPassword:oldLoginPassword success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 执行修改登录密码的正确性 */
-(void)changeNewLoginPasswordWithNewLoginPassword:(NSString*)newLoginPassword success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] changeNewLoginPasswordWithUser:self newLoginPassword:newLoginPassword success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];


}
/** 验证旧支付密码的正确性 *///就不能合成一个接口吗 -_-!
-(void)checkOldPayPasswordWithOldPayPassword:(NSString*)oldPayPassword success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] checkOldPayPasswordWithUser:self oldPayPassword:oldPayPassword
                                                            success:^(ResponseObject *responseObject) {
                                                                success(responseObject);
                                                            } failure:^(NSError *error) {
                                                                failure(error);
                                                            }];
}
/**获取全部订单页面*/
- (void)gotMyAllOrderSuccess:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure{
    
}




/** 执行修改支付密码的正确性 */
-(void)changeNewPayPasswordWithNewPayPassword:(NSString*)newPayPassword success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] changeNewPayPasswordWithUser:self newPayPassword:newPayPassword success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}



/** 获取国家编码 */
-(void)gotCountryNumberWithSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotCountryNumberWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 修改绑定手机 */

-(void)changeBoundMobileWithBoundMobile:(NSString*)boundMobile success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] changeBoundMobileWithUser:self boundMobile:boundMobile success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 获取账户安全相关信息 */
-(void)gotAccountSafeSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotAccountSafeWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/** 通过邮箱找回密码 */
-(void)findPasswordBackByEmailWithEmail:(NSString*)email success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] findPasswordBackByEmailWithUser:self email:email success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 检查版本 */
-(void)checkVersionInfoSuccess:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] checkVersionSuccess:^(ResponseObject *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
       
    }];

}

/** 首次第三方登录时 验证手机号码 */
-(void)authorMobileAfterThirdPlayformWithMobile:(NSString*)mobile mobileCode:(NSString*)mobileCode accessToken:(NSString*)accessToken success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] authorMobileAfterThirdPlayformWithUser:self mobile:mobile mobileCode:mobileCode accessToken:accessToken success:^(ResponseObject *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

/** 第三方登录后,保存相关数据 source有三种 QQ sian weixin*/
-(void)saveThirdPlayromAccountInfomationWithOpenID:(NSString*)openID accessToken:(NSString*)accessToken source:(NSString*)source success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] saveThirdPlayromAccountInfomation:self openID:openID accessToken:accessToken source:source success:^(ResponseObject *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}


-(void)saveThirdPlayromAccountInfomationWithSnsAccount:(UMSocialAccountEntity *)snsAccount  origenRespons:(UMSocialResponseEntity *)origenRespons success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] saveThirdPlayromAccountInfomation:self  andSnsAccount:snsAccount origenRespons:origenRespons success:^(ResponseObject *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    

}
#pragma mark 注释: 腾讯云文件上传签名
-(void)gotTencentYunSuccess:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotTencentYunSign:self  Success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

#pragma mark 注释: 获取历史消息
-(void)gotHistoryMessageFrom:(NSString*)from to:(NSString*)to messageID:(NSString*)messageID Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotHistoryMessage:self  from:from to:to messageID:messageID Success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 支付宝支付结果处理 */
-(void)dealTheResultAfterAlipayWithPayType:(NSString*)payType payResult:(NSString*)payResult success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] dealTheResultAfterAlipayWithUser:self payType:payType payResult:payResult success:^(ResponseObject *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}
/** 清楚足迹 */
-(void)clearFootHistorySuccess:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    [[UserInfoViewModel shareViewModel] clearFootHistoryWith:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSString *)imName{
    return userInfo.name;
    
//    return @"wangyuanfei";
}

-(NSString *)token{
    if (_token==nil ) {
        _token = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
    }
    
    return  _token;
}
@end
