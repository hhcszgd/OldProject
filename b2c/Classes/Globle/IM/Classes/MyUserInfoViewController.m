//
//  MyUserInfoViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-14.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "MyUserInfoViewController.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "HttpUpFile.h"
#import "SVProgressHUD.h"
#import "AsynImageView.h"
#import "WebViewController.h"
#import "EditUserInfoViewController.h"
#import "Config.h"

@interface MyUserInfoViewController ()

@end

@implementation MyUserInfoViewController

- (void)viewDidLoad {
    title = @"基本资料";
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
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    }
    table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    table.scrollEnabled = NO;
    [self.view addSubview:table];
}
- (void)viewWillAppear:(BOOL)animated {
    [table reloadData];
    [super viewWillAppear:animated];
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 44;
}
//生成行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    UserData *userData = [UserDataManage getSelfUser];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        cell.accessoryType = UITableViewCellAccessoryNone;
        headView = [[UIImageView alloc] initWithFrame:CGRectMake(mainRect.size.width - 100, 5, 80, 70)];
        headView.layer.borderWidth = 1;
        headView.layer.borderColor = [Tool colorWithHexString:@"CCCCCC"].CGColor;
        headView.layer.cornerRadius = 4;
        headView.userInteractionEnabled = YES;
        [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
        NSString *imgageName = [NSString stringWithFormat:@"%@%@", userData.userId, @"Avatar.png"];
        UIImage *headImage = [[UIImage alloc] initWithContentsOfFile:[Tool getImagePath:imgageName]];
        if (headImage == nil) {
            headView.image = [UIImage imageNamed:@"DefaultHead"];
        } else {
            headView.image = headImage;
        }
        [cell.contentView addSubview:headView];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"昵称";
        cell.detailTextLabel.text = userData.nickname;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"签名";
        cell.detailTextLabel.text = userData.idiograph;
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"修改密码";
    }
    return cell;
}
//行点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        EditUserInfoViewController *evc = [[EditUserInfoViewController alloc] init];
        evc.infoType = 0;
        [self.navigationController pushViewController:evc animated:YES];
    } else if (indexPath.row == 2) {
        EditUserInfoViewController *evc = [[EditUserInfoViewController alloc] init];
        evc.infoType = 1;
        [self.navigationController pushViewController:evc animated:YES];
    } else if (indexPath.row == 3) {
        WebViewController *wvc = [[WebViewController alloc] init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [wvc initData:@"修改密码" url:[NSString stringWithFormat:@"%@/ClientPage/modifypsw_phone.html?sessionId=%@&userId=%@&loginId=%@", [Config getProjectPath], [userDefault objectForKey:@"sessionId"], [userDefault objectForKey:@"userId"], [userDefault objectForKey:@"loginId"]]];
        [self.navigationController pushViewController:wvc animated:YES];
    }
}
//头像点击
- (void)headClick:(UITapGestureRecognizer *)tap {
    if (IS_GTE_IOS8) {
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"选择头像上传方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //检查是否可以使用相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self openSheet:UIImagePickerControllerSourceTypeCamera];
            }];
            [alertController addAction:cameraAction];
        }
        
        //从相册选择
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openSheet:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        [alertController addAction:photoAction];
        
        //取消按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
        [alertController addAction:cancelAction];
        
        //针对ipad的设置
        UIPopoverPresentationController *ppc = alertController.popoverPresentationController;
        ppc.sourceView = headView;
        ppc.sourceRect = headView.bounds;
        
        [self presentViewController:alertController animated:YES completion:nil];
    //iOS8以前系统版本继续使用UIActionSheet
    } else {
        if (!sheet) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            } else {
                sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            }
            sheet.tag = 255;
        }
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //选择头像选取方式
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    return;
            }
        } else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        [self openSheet:sourceType];
    }
}
- (void)openSheet:(UIImagePickerControllerSourceType)sourceType {
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
//上传头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UserData *userData = [UserDataManage getSelfUser];
    NSString *imgageName = [NSString stringWithFormat:@"%@%@", userData.userId, @"TempAvatar.png"];
    NSString *fullPath = [Tool getImagePath:imgageName];
    [self saveImage:image withName:fullPath];
    [self uploadImgFile:fullPath image:image];
}
#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
//上传图片
- (void)uploadImgFile:(NSString*)imgFullPath image:(UIImage *)image {
    HttpUpFile *http = [[HttpUpFile alloc] init];
    [SVProgressHUD showWithStatus:@"正在上传......"];
    NSString *url = [NSString stringWithFormat:@"%@/service/FileUpload", [Config getProjectPath]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [http request:url param:param filePath:imgFullPath delegate:self usingBlock:^(NSData *data) {
        [SVProgressHUD dismiss];
        if (data != nil) {
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
            //删除临时头像
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if([fileManager fileExistsAtPath:imgFullPath]){
                [fileManager removeItemAtPath:imgFullPath error:nil];
            }
            //上传失败
            if (isFail) {
                [SVProgressHUD showAlert:nil msg:[NSString stringWithFormat:@"上传图片失败请重试"]];
                return;
            }
            //保存头像
            UserData *userData = [UserDataManage getSelfUser];
            NSString *imgageName = [NSString stringWithFormat:@"%@%@", userData.userId, @"Avatar.png"];
            NSString *fullPath = [Tool getImagePath:imgageName];
            [self saveImage:image withName:fullPath];
            headView.image = image;
        } else {
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if([fileManager fileExistsAtPath:imgFullPath]){
                [fileManager removeItemAtPath:imgFullPath error:nil];
            }
            [SVProgressHUD showAlert:nil msg:@"上传图片失败请重试"];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
