//
//  ImageQualityVC.m
//  b2c
//
//  Created by wangyuanfei on 16/6/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ImageQualityVC.h"
#import "IQRowView.h"

//#import "CustomDetailCell.h"

@interface ImageQualityVC ()
@property(nonatomic,strong)NSMutableArray * arrM ;
@end

@implementation ImageQualityVC

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    IQRowView * brainpowerMode = [[IQRowView alloc]initWithFrame:CGRectMake(0, self.startY+10, self.view.bounds.size.width, 48)];
    brainpowerMode.tipsStr = @"智能模式";
    [self.view addSubview:brainpowerMode];
    [self.arrM addObject:brainpowerMode];
    brainpowerMode.isSelect=YES;
    [brainpowerMode addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    IQRowView * hightQualityMode = [[IQRowView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(brainpowerMode.frame), self.view.bounds.size.width, 48)];
    hightQualityMode.tipsStr = @"高质量(适合wifi环境)";
    [self.view addSubview:hightQualityMode];
    [self.arrM addObject:hightQualityMode];
    hightQualityMode.isSelect = NO;
    [hightQualityMode addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    IQRowView * lowQualityMode = [[IQRowView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hightQualityMode.frame), self.view.bounds.size.width, 48)];
    lowQualityMode.tipsStr = @"普通(适合3G或者2G环境)";
    [self.view addSubview:lowQualityMode];
    [self.arrM addObject:lowQualityMode];
    lowQualityMode.isSelect = NO ;
     [lowQualityMode addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = [UIFont systemFontOfSize:13];
    tipsLabel.textColor = SubTextColor;
    tipsLabel.numberOfLines = 0 ;
    NSString * tempStr =  @"图片质量会影响到页面刷新速度。请根据自己的网络状况，选择适合自己的图片质量。" ;
    CGSize strSize = [tempStr sizeWithFont:tipsLabel.font MaxSize:CGSizeMake(self.view.bounds.size.width-10*2, CGFLOAT_MAX)];
    [self.view addSubview:tipsLabel];
    tipsLabel.text =tempStr;
    tipsLabel.frame = CGRectMake(10, CGRectGetMaxY(lowQualityMode.frame)+10, strSize.width, strSize.height);
    
    NSInteger currentImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentImgMode"] integerValue];
    [self click:self.arrM[currentImgMode]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)click:(IQRowView*)sender
{
    for (int i = 0 ; i < self.arrM.count ; i++  ) {
        IQRowView*sub = self.arrM[i];
        if (sub==sender) {
            sub.isSelect = YES;
            if (i==0) {
//                [UserInfo shareUserInfo].currentImgMode = 0;
                if (NetWorkingStatus==NETMOBILE) {
                    [[UserInfo shareUserInfo] setupNetworkStates:1 success:^(ResponseObject *responseObject) {
                        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                    } failure:^(NSError *error) {
                        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                    }];
                }else if (NetWorkingStatus == NETWIFI){
                
                    [[UserInfo shareUserInfo] setupNetworkStates:0 success:^(ResponseObject *responseObject) {
                        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                    } failure:^(NSError *error) {
                        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                    }];
                }
            }else if (i==1){
//                [UserInfo shareUserInfo].currentImgMode = 1;
                [[UserInfo shareUserInfo] setupNetworkStates:0 success:^(ResponseObject *responseObject) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                } failure:^(NSError *error) {
                   LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                }];
            }else if (i==2){
//                [UserInfo shareUserInfo].currentImgMode = 2;
                [[UserInfo shareUserInfo] setupNetworkStates:1 success:^(ResponseObject *responseObject) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                } failure:^(NSError *error) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                }];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:@(i) forKey:@"currentImgMode"];
        }else{
            sub.isSelect = NO ;
        }
    }
}


- (NSArray *)getAllProperties
{
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList([UIPageControl class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithUTF8String: propertyName]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    
    UIPageControl * p = [[UIPageControl alloc]init];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,p);
    return propertiesArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSMutableArray *)arrM{
    if (!_arrM) {
        _arrM = [NSMutableArray arrayWithCapacity:3];
    }
    return _arrM;
}
@end
