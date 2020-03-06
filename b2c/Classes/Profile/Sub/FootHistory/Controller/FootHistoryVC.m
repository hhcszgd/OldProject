//
//  FootHistoryVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "FootHistoryVC.h"
#import "ReusableViewHeader.h"
#import "FHistoryModel.h"
#import "FHistoryCell.h"
@interface FootHistoryVC ()//<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//@property (nonatomic, strong) UICollectionView *col;
//@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
///**数据源方法*/
//@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,weak)UIButton * clearButton ;
@end

@implementation FootHistoryVC
//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [[NSMutableArray alloc] init];
//        
//    }
//    return _dataArray;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarSubview];
    self.originURL = self.keyParamete[@"paramete"];
    
//    [self configmentNav];
    
    
    
    /**如果没有数据就不会加载col*/
//    if (self.dataArray.count == 0 ) {
#pragma mark 缺少没有数据时候的页面
//    }else{
//        [self configmentCol];
//    }
    // Do any additional setup after loading the view.
}

-(void)setupNavigationBarSubview
{
    UIButton * clearButton = [[UIButton alloc]init];
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearButton setTitleColor:SubTextColor forState:UIControlStateNormal];
    self.clearButton = clearButton;
   
    [clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationBarRightActionViews = @[clearButton];
    
}
-(void)clearButtonClick:(UIButton*)clearButton
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //调接口,完了刷新界面
        [[UserInfo shareUserInfo] clearFootHistorySuccess:^(ResponseObject *responseObject) {
            if (responseObject.status>0) {
                [self.webview reload];
            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"操作失败");
            }
        } failure:^(NSError *error) {
            AlertInVC(@"清除失败,请重试");
        }];
//        [self.webView  reload];
        
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //do nothing
    }];
    [alertVC  addAction:confirm];
    [alertVC addAction:cancle];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//- (void)configmentNav{
//    //控制器标题
//    self.title = @"足迹";
//    //编辑按钮
//    UILabel *clean = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    [clean configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"清空"];
//    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clean:)];
//    [clean addGestureRecognizer:cleanTap];
//    [clean setUserInteractionEnabled:YES];
//    self.navigationBarRightActionViews = @[clean];
//    
//}
//- (void)clean:(UITapGestureRecognizer *)cleanTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"清空")
//}
//
//
//- (void)configmentCol{
//    _layout = [[UICollectionViewFlowLayout alloc] init];
//    _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) collectionViewLayout:_layout];
//    _col.backgroundColor = BackgroundGray;
//    [self.view addSubview:_col];
//    _col.backgroundColor = [UIColor lightGrayColor];
//    _col.delegate = self;
//    _col.dataSource = self;
//    [_col registerClass:[FHistoryCell class] forCellWithReuseIdentifier:@"FHistoryCell"];
//   
//    [_col registerClass:[ReusableViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader"];
//    [_col setShowsVerticalScrollIndicator:NO];
//    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 10;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    FHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FHistoryCell" forIndexPath:indexPath];
//    cell.footHistoryModel = [[FHistoryModel alloc] init];
//    return cell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 2;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(5, 0, 5, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CGSizeMake(screenW, 100);
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableView = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        ReusableViewHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader" forIndexPath:indexPath];
//        header.title = [NSString stringWithFormat:@"%ld",indexPath.section];
//        reusableView = header;
//    }else{
//        
//    }
//    return  reusableView;
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(screenW, 40);
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
