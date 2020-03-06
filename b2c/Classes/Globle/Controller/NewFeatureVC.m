//
//  NewFeatureVC.m
//  b2c
//
//  Created by wangyuanfei on 6/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "NewFeatureVC.h"

@interface NewFeatureVC ()<UICollectionViewDelegate , UICollectionViewDataSource,NewFeatureDelegate>
@property(nonatomic,weak)UICollectionView * collectView ;
@property(nonatomic,strong)NSMutableArray * images ;
@end

@implementation NewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setcollectView];
    // Do any additional setup after loading the view.
}
-(void)setcollectView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing=0;
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    UICollectionView * collectView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectView.alwaysBounceHorizontal=NO ;
    collectView.alwaysBounceVertical = NO ;
    collectView.showsHorizontalScrollIndicator=NO;
    collectView.backgroundColor = [UIColor whiteColor];
    collectView.pagingEnabled=YES;
    [collectView registerClass:[NewFeatureCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectView = collectView;
    [self.view addSubview:collectView];
    collectView.dataSource = self;
    collectView.delegate = self;
}
-(NSMutableArray * )images{
    if(_images==nil){
        _images = [[NSMutableArray alloc]initWithObjects:@"newfeature1",@"newfeature2",@"newfeature3", nil];
    }
    return _images;
}
#pragma collectionViewdelegate/datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewFeatureCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = randomColor;
    cell.backImageName = self.images[indexPath.item];
    cell.showStartButton = indexPath.item==self.images.count-1 ? NO : YES;
    cell.NewFeatureCellDelegate = self ;
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//   
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)performStart:(NewFeatureCollectionCell*)cell{
    if ([self.NewFeatureVCDelegate respondsToSelector:@selector(finishedShowNewFeature:)]) {
        [self.NewFeatureVCDelegate finishedShowNewFeature:self];
    }
}


-(void)dealloc{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"销毁新特性");
}

@end



@interface NewFeatureCollectionCell ()
@property(nonatomic,weak)UIImageView * backImageView;
@property(nonatomic,weak)UIButton * startButton ;
@end

@implementation NewFeatureCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView * backImageView = [[UIImageView alloc]init];
        backImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backImageView  = backImageView ;
        [self.contentView addSubview:backImageView];
        
        UIButton * startButton = [[UIButton alloc]init];
        [startButton setTitle:@"开启直接捞" forState:UIControlStateNormal];
        startButton.titleLabel.font = [UIFont systemFontOfSize:14*SCALE];
        [startButton setTitleColor:[UIColor colorWithHexString:@"3fa7e0"] forState:UIControlStateNormal];
        
        self.startButton = startButton;
        [startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:startButton];
        startButton.layer.cornerRadius = 5;
        startButton.layer.masksToBounds = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
    self.startButton.bounds = CGRectMake(0, 0, 100*SCALE, 40*SCALE);
    self.startButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - self.startButton.bounds.size.height/2  - 44*SCALE);
    self.startButton.layer.cornerRadius = self.startButton.bounds.size.height/2 ;
    self.startButton.layer.borderColor = [UIColor colorWithHexString:@"3fa7e0"].CGColor;
    self.startButton.layer.borderWidth = 1 ;
    self.startButton.layer.masksToBounds = YES;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.backImageView);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,_startButton);
}
-(void)startButtonClick:(UIButton*)sender
{
    if ([self.NewFeatureCellDelegate respondsToSelector:@selector(performStart:)]) {
        [self.NewFeatureCellDelegate performStart:self];
    }
}

-(void)setBackImageName:(NSString *)backImageName{
    _backImageName = backImageName.copy;
    self.backImageView.image = [UIImage imageNamed:_backImageName];
}

-(void)setShowStartButton:(BOOL)showStartButton{
    _showStartButton = showStartButton;
    self.startButton.hidden = _showStartButton;
}
@end



