//
//  TousuVC.m
//  b2c
//
//  Created by WY on 16/11/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "TousuVC.h"

@interface TousuVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIButton * refreshBtn ;
@end

@implementation TousuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBarSubview];
    ActionBaseView * iconImageView = [[ActionBaseView alloc]init];
//    [iconImageView addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
//    self.iconImageView = iconImageView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavigationBarSubview
{
    UIButton * refreshBtn = [[UIButton alloc]init];
//    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setImage:[UIImage imageNamed:@"refreshiocn"] forState:UIControlStateNormal];
    [refreshBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [refreshBtn setTitleColor:SubTextColor forState:UIControlStateNormal];
    self.refreshBtn = refreshBtn;
    
    [refreshBtn addTarget:self action:@selector(refreshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationBarRightActionViews = @[refreshBtn];
    
}
-(void)refreshBtnClick:(UIButton *)sender
{
    [self.webview reload];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma 投诉时上传图片

-(void)uploadimg
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改头像")
    
    UIAlertController * alertVC  =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionCamora = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出系统相册
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        //设置照片来源
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            
            pickVC.sourceType =  UIImagePickerControllerSourceTypeCamera;
            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }else{
            AlertInVC(@"摄像头不可用");
        }
        pickVC.allowsEditing=YES;
    }];
    UIAlertAction * actionAlbum = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出系统相册
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        
        //设置照片来源
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickVC.delegate = self;
        pickVC.allowsEditing=YES;
        [self presentViewController:pickVC animated:YES completion:nil];
    }];
    UIAlertAction * actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionCamora];
    [alertVC addAction:actionAlbum];
    [alertVC addAction:actionCancle];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *photo = info[UIImagePickerControllerEditedImage];//UIImagePickerControllerEditedImage;//
    
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,photo)
//    self.iconImageView.img=photo;
    [self uploadPicktreWithImage:photo];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)uploadPicktreWithImage:(UIImage *)image
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imgData = UIImageJPEGRepresentation(image, 0.1);
//        [self setuserIconToIMSeverWithimgData:imgData];
        NSString * imgBase64 =  [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [[UserInfo shareUserInfo] uploadPictureWithPicBase64:imgBase64   targetType:2  success:^(ResponseObject*  response) {
            //图片上传成功 , 调js
            [self.webview evaluateJavaScript:[NSString stringWithFormat:@"saveimgs(%@)",response.data] completionHandler:nil];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    });
    
}
@end
