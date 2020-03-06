//
//  AskAndFeedbackVC.m
//  b2c
//
//  Created by wangyuanfei on 7/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AskAndFeedbackVC.h"
#import "AskAndfeedTopView.h"
#import "ATasteView.h"
#import "ALogeView.h"
@interface AskAndFeedbackVC ()<AskAndfeedTopViewDelegate, ALogeViewDelegate,ATasteViewDelegate>
/**左边的按钮*/
@property (nonatomic, strong) AskAndfeedTopView *topView;

/**体验问题主界面*/
@property (nonatomic, strong) ATasteView *tasteView;
/**投诉*/
@property (nonatomic, strong) ALogeView *logeView;

@property (nonatomic, copy) NSString *phone;


@end

@implementation AskAndFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@, %d ,%@",[self class],__LINE__,UUID);
    self.naviTitle = @"意见与反馈";
    [self setTopView];
    [self requestData];
    
    
}
/**请求数据*/
- (void)requestData{
    [[UserInfo shareUserInfo] gotFeedBackDataSuccess:^(ResponseObject *responseObject) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);
        self.tasteView.dataArr = responseObject.data;
        
    } failure:^(NSError *error) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,error);
        
    }];
    [[UserInfo shareUserInfo] gotComplaintDataSuccess:^(ResponseObject *responseObject) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);
        self.logeView.logePhone.text = responseObject.data;
        self.phone = responseObject.data;
    } failure:^(NSError *error) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,error);

    }];
    
    
}


/**设置切换按钮*/
- (void)setTopView{
    self.topView.backgroundColor = [UIColor whiteColor];
}
- (AskAndfeedTopView *)topView{
    if (_topView == nil) {
        _topView = [[AskAndfeedTopView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, 40 * SCALE)];
        _topView.delegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}
/**topView的代理方法*/
- (void)askAndfeedTopView:(id)object{
    if (object == self.topView.leftTitleLabel) {
        self.tasteView.hidden = NO;
        self.logeView.hidden = YES;
    }
    if (object == self.topView.rightTitleLabel) {
        [self.tasteView.textView resignFirstResponder];
        self.tasteView.hidden = YES;
        self.logeView.hidden = NO;
    }

}
- (ATasteView *)tasteView{
    if (_tasteView == nil) {
        _tasteView = [[ATasteView alloc] initWithFrame:CGRectMake(0, self.startY + 40 * SCALE, screenW, screenH - self.startY - 40 * SCALE)];
        [self.view addSubview:_tasteView];
        _tasteView.delegate = self;
    }
    return _tasteView;
}

- (ALogeView *)logeView{
    if (_logeView == nil) {
        _logeView = [[ALogeView alloc] initWithFrame:CGRectMake(0, self.startY + 40 * SCALE, screenW, screenH - self.startY - 40 * SCALE)];
        _logeView.delegate = self;
        [self.view addSubview:_logeView];
        
    }
    return _logeView;
}
/**拨打客服电话*/
- (void)logePhoneToTarget:(NSString *)phoneNumber{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (void)back{
    [self navigationBack];
}

-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
