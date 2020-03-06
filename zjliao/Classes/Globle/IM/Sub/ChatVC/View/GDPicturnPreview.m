//
//  GDPicturnPreview.m
//  b2c
//
//  Created by WY on 17/2/15.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "GDPicturnPreview.h"
#import "GDPicturnPreviewCell.h"
@interface GDPicturnPreview ()<UICollectionViewDelegate , UICollectionViewDataSource,GDPicturnPreviewCellDelegate>

@property(nonatomic,weak)UICollectionView * collectionView ;
@property(nonatomic,assign)NSInteger  currentIndex ;

@end

@implementation GDPicturnPreview


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tap)];
//        [self  addGestureRecognizer:tap];
        //imgFileView.userInteractionEnabled = YES ;

    }
    return self;
}
-(void)setupCollectinView
{
    if (!self.collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        UICollectionView * collectionView = [[UICollectionView alloc ] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        collectionView.bounces = NO ;
 
        layout.minimumLineSpacing = 0 ;
        collectionView.pagingEnabled = YES ;
        collectionView.frame = self.bounds;
        layout.minimumInteritemSpacing = 0 ;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self ;
        self.collectionView = collectionView ;
        [self addSubview:collectionView];
        [collectionView registerClass:[GDPicturnPreviewCell class] forCellWithReuseIdentifier:@"item"];
        
    }
}
- (void)willMoveToWindow:(UIWindow *)newWindow{
     NSLog(@"_%d_移动到window%@",__LINE__,newWindow);
    if (newWindow) {
//        [self setupCollectinView ];
    }
}
-(NSArray<UIImage *> *)images{
    if(_images==nil){
//        NSString * path = [NSString stringWithFormat:@"Library/Caches/xmppPhoto/kefu"];
        NSMutableArray * temp  = [NSMutableArray array];
//        NSString *resourceCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:self.filesPath];
         NSLog(@"_%d_%@",__LINE__,self.filePath);
        NSString * folderPath =  [self.filePath stringByReplacingOccurrencesOfString:[self.filePath lastPathComponent] withString:@""];;

        if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath ]) {//取资源
           NSArray * itemsPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
            for (NSString * itemPath in itemsPaths) {

//                NSLog(@"_%d_%@",__LINE__,itemPath);
                if ([itemPath containsString:@"jpeg"] || [itemPath containsString:@"jpg"] || [itemPath containsString:@"JPEG"] || [itemPath containsString:@"JPG"]||[itemPath containsString:@"png"]||[itemPath containsString:@"PNG"]) {
//                    NSString * perfixPath = folderPath;
//                    if ([self.filesPath hasSuffix:@"/"]) {
//                        
//                    }else{
//                        perfixPath = [perfixPath stringByAppendingString:@"/"];
//                    }
                    NSString * fullPath = [folderPath  stringByAppendingString:itemPath];
                    UIImage * img = [UIImage imageWithContentsOfFile:fullPath];

                    if (img && [itemPath  isEqualToString:self.filePath.lastPathComponent]) {//数据库重写了以后才能做图片浏览器 , (显示发送失败了的消息)
                        [temp addObject:img];
                    }
                    
                }
            }
            _images = temp.copy;
        }else{
             NSLog(@"_%d_链接地址不存在:%@",__LINE__,folderPath);
        }

    }
    if (_images.count==0) {
        [self  removeFromSuperview];
        return nil ;
    }
    return _images;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//     NSLog(@"_%d_%@",__LINE__,self.images);
}

#pragma mark 注释: collectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.images.count   ;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GDPicturnPreviewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    if (!cell) {
        cell = [[GDPicturnPreviewCell alloc] init];
    }
    NSInteger index = indexPath.item;
    UIImage * img = self.images[index];
    cell.img  = img ;
    cell.delegate = self ;
    
    return  cell ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.item;
    UIImage * img = self.images[index];
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    GDPicturnPreviewCell * realCell = ( GDPicturnPreviewCell *) cell ;
}
+(void)show{
    

}
-(void)showInView:(UIView*)view {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    self.frame = CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
    [self setupCollectinView];
    [window addSubview:self];
    


}
-(void)oneTapOnView:(GDPicturnPreviewCell*)view
{

    [UIView animateWithDuration:0.5 animations:^{
        //当前cell的img
    } completion:^(BOOL finished) {
        [self  removeFromSuperview];
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
     NSLog(@"_%d_%@",__LINE__,@"销毁");
}
@end
