//
//  AddGroupViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "AddGroupViewController.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "WSCallerBlock.h"
#import "SVProgressHUD.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "MyNotificationCenter.h"
#import "Config.h"

@interface AddGroupViewController ()

@end

@implementation AddGroupViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    title = @"添加群";
    isShowBackButton = YES;
    //全屏大小
    mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    [super viewDidLoad];
    //群名称文字
    [self.view addSubview:[self createLabel:@"群名称" :CGRectMake(20, 20, mainRect.size.width - 40, 20)]];
    //群名称
    [self createField];
    [self.view addSubview:groupNameField];
    
    //群类型文字
    [self.view addSubview:[self createLabel:@"群类型" :CGRectMake(20, 100, mainRect.size.width - 40, 20)]];
    //已选中的群类型
    groupTypeLabel = [self createLabel:@"" :CGRectMake(20, 120, mainRect.size.width - 40, 44)];
    groupTypeLabel.backgroundColor = [UIColor whiteColor];
    groupTypeLabel.textAlignment = NSTextAlignmentCenter;
    groupTypeLabel.textColor = [Tool colorWithHexString:@"666666"];
    groupTypeLabel.layer.opacity = 0.7;
    groupTypeLabel.layer.borderColor = [Tool colorWithHexString:@"CCCCCC"].CGColor;
    groupTypeLabel.layer.borderWidth = 1;
    groupTypeLabel.font = [UIFont systemFontOfSize:14];
    groupTypeLabel.userInteractionEnabled = YES;
    [groupTypeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker:)]];
    [self.view addSubview:groupTypeLabel];
    
    //群简介文字
    [self.view addSubview:[self createLabel:@"群简介" :CGRectMake(20, 180, mainRect.size.width - 40, 20)]];
    //群简介
    [self createView];
    [self.view addSubview:noteView];
    
    UIButton *completeButton = [self headeButton:@"完成" image:nil];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(completeOnCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:completeButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //视图点击事件
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)]];
    
    
    //查询群类型
    [self queryGroupType];
    //群类型选择器
    groupTypePicker = [[UIPickerView alloc] init];
    groupTypePicker.frame = CGRectMake(0, mainRect.size.height - groupTypePicker.frame.size.height - navigationBarHeight - statusBarHeight, mainRect.size.width, groupTypePicker.frame.size.height);
    groupTypePicker.backgroundColor = [UIColor whiteColor];
    groupTypePicker.dataSource = self;
    groupTypePicker.delegate = self;
    groupTypePicker.hidden = YES;
    groupTypePicker.layer.opacity = 0.7;
    [groupTypePicker reloadAllComponents];
    [self.view addSubview:groupTypePicker];
    
    //默认类型
    NSMutableDictionary *defaultOne = [[NSMutableDictionary alloc] init];
    [defaultOne setObject:@"默认" forKey:@"name"];
    [defaultOne setObject:@"0" forKey:@"parentId"];
    [defaultOne setObject:@"1001" forKey:@"id"];
    groupTypes = [[NSMutableArray alloc] init];
    [groupTypes addObject:defaultOne];
    groupTypeLabel.text = @"默认";
    [groupTypePicker selectRow:0 inComponent:0 animated:NO];
}
//创建label
- (UILabel *)createLabel:(NSString *)text :(CGRect)rect {
    UILabel *labelOne = [[UILabel alloc] initWithFrame:rect];
    labelOne.text = text;
    labelOne.textColor = [UIColor whiteColor];
    labelOne.font = [UIFont systemFontOfSize:12];
    labelOne.backgroundColor = [UIColor clearColor];
    return labelOne;
}
//创建field
- (void)createField {
    groupNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, mainRect.size.width - 40, 44)];
    groupNameField.textColor = [Tool colorWithHexString:@"#666666"];
    groupNameField.font = [UIFont systemFontOfSize:14];
    groupNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    groupNameField.delegate = self;
    groupNameField.textAlignment = NSTextAlignmentCenter;
    groupNameField.backgroundColor = [UIColor whiteColor];
    groupNameField.layer.opacity = 0.7;
    groupNameField.returnKeyType = UIReturnKeyNext;
    groupNameField.layer.borderWidth = 1;
    groupNameField.layer.borderColor = [Tool colorWithHexString:@"CCCCCC"].CGColor;
}
//创建view
- (void)createView{
    noteView = [[UITextView alloc] initWithFrame:CGRectMake(20, 200, mainRect.size.width - 40, 90)];
    noteView.textColor = [Tool colorWithHexString:@"#666666"];
    noteView.font = [UIFont systemFontOfSize:14];
    noteView.delegate = self;
    noteView.backgroundColor = [UIColor whiteColor];
    noteView.layer.opacity = 0.7;
    noteView.layer.borderWidth = 1;
    noteView.layer.borderColor = [Tool colorWithHexString:@"CCCCCC"].CGColor;
}
//输入框获取焦点事件
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self hidePicker:nil];
    return YES;
}
//键盘上的回车事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [noteView becomeFirstResponder];
    return YES;
}
//输入框获取焦点事件
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self hidePicker:nil];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}
//关闭事件
- (void)viewClick:(id)sender {
    [self hidePicker:nil];
    [self.view endEditing:YES];
}
//显示选择器
- (void)showPicker:(id)sender {
    [self.view endEditing:YES];
    groupTypePicker.hidden = NO;
}
//隐藏选择器
- (void)hidePicker:(id)sender {
    groupTypePicker.hidden = YES;
}
//查询群类型
- (void)queryGroupType {
    WSCallerBlock *queryBlock = [[WSCallerBlock alloc] init];
    [queryBlock call:[NSString stringWithFormat:@"%@?function=getGroupCatalog&sessionId=%@&json=true", [Config getPath], [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]] delegate:self usingBlock:^(NSData *data) {
        if (data) {
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dataStr = [dataStr substringFromIndex:[dataStr rangeOfString:@"="].location + 1];
            dataStr = [dataStr substringToIndex:[dataStr rangeOfString:@";"].location];
            NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:NULL];
            NSDictionary *cimJSON = [dataJSON objectForKey:@"cim"];
            NSDictionary *resultJSON = [cimJSON objectForKey:@"result"];
            if (![resultJSON objectForKey:@"code"] || ![cimJSON objectForKey:@"catalogs"]) {
                return;
            }
            NSString *codeStr = [resultJSON objectForKey:@"code"];
            int code = codeStr.intValue;
            if (code != 0) {
                return;
            }
            groupTypes = [cimJSON objectForKey:@"catalogs"];
            [groupTypePicker reloadAllComponents];
            if ([groupTypes count] > 0) {
                NSDictionary *itemOne = [groupTypes objectAtIndex:0];
                groupTypeLabel.text = [itemOne objectForKey:@"name"];
                [groupTypePicker selectRow:0 inComponent:0 animated:NO];
            }
        }
    }];
}
//组数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [groupTypes count];
}
//行显示文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *itemOne = [groupTypes objectAtIndex:row];
    return [itemOne objectForKey:@"name"];
}
//行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDictionary *itemOne = [groupTypes objectAtIndex:row];
    groupTypeLabel.text = [itemOne objectForKey:@"name"];
}
//完成按钮
- (void)completeOnCheckButton:(id)sender {
    [self viewClick:nil];
    //获取群相关信息
    NSString *groupName = [groupNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    int rowId = [groupTypePicker selectedRowInComponent:0];
    NSString *groupNote = noteView.text;
    if ([groupName length] == 0) {
        [SVProgressHUD showAlert:nil msg:@"群名称不能空"];
        return;
    }
    if ([groupTypes count] <= rowId) {
        [SVProgressHUD showAlert:nil msg:@"请选择一个群类型"];
        return;
    }
    NSDictionary *groupTypeOne = [groupTypes objectAtIndex:rowId];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"setGroup" forKey:@"function"];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:@"add" forKey:@"op"];
    [param setObject:groupName forKey:@"name"];
    [param setObject:[groupTypeOne objectForKey:@"name"] forKey:@"catalog"];
    if ([[groupNote stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
        [param setObject:groupNote forKey:@"notes"];
    }
    WSCallerBlock *addGroupHttp = [[WSCallerBlock alloc] init];
    [addGroupHttp callPost:[Config getPath] params:param delegate:self usingBlock:^(NSData *data) {
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSRegularExpression *xmlRegex = [NSRegularExpression regularExpressionWithPattern:@"<result code=[\"|']([\\d]*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *arrayRange = [xmlRegex matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
        BOOL isFail = YES;
        for (NSTextCheckingResult *match in arrayRange) {
            NSString *code = [dataStr substringWithRange:[match rangeAtIndex:1]];
            if (code.intValue == 0) {
                isFail = NO;
            }
        }

        if (isFail) {
            [SVProgressHUD showAlert:nil msg:@"创建失败"];
            return;
        }
        NSString *groupId = nil;
        NSRegularExpression *xmlRegex2 = [NSRegularExpression regularExpressionWithPattern:@"id=[\"|']([\\d]*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *arrayRange2 = [xmlRegex2 matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
        for (NSTextCheckingResult *match in arrayRange2) {
            groupId = [dataStr substringWithRange:[match rangeAtIndex:1]];
            if (!groupId) {
                return;
            }
        }
        GroupStruct *groupOne = [[GroupStruct alloc] init];
        groupOne.groupId = groupId;
        groupOne.groupName = groupName;
        groupOne.notes = groupNote;
        groupOne.isRecvMessage = YES;
        groupOne.myTypeInGroup = @"1";
        [SVProgressHUD showAlert:nil msg:@"创建成功"];
        [self back:nil];
        //通知刷新页面
        [MyNotificationCenter postNotification:SystemEventDynamicAddGroup setParam:groupOne];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
