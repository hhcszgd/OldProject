//
//  PBackgrountVC.m
//  b2c
//
//  Created by wangyuanfei on 3/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PBackgroundVC.h"
#import "PTableView.h"
#import "BaseCell.h"
@interface PBackgroundVC ()
@property(nonatomic,weak)UIImageView * corverImageView ;
@property(nonatomic,weak)UIImageView * moveOutImageView ;
@property(nonatomic,assign)CGPoint  targetPoint ;
@property(nonatomic,weak)UIImageView * iconView ;
@end

@implementation PBackgroundVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view.
    [self setupCorverView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupTableView
{
   
    CGRect frame  = CGRectMake(0, self.startY, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    PTableView * tableView =[[PTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView =tableView;
//    CGFloat tableViewTopViewW = self.view.bounds.size.width;
//    CGFloat tableViewTopViewH = screenH-200;
//    CGFloat tableViewTopViewY = -tableViewTopViewH;
//    CGFloat tableViewTopViewX = 0;
//    UIImageView * tableViewTopView = [[UIImageView alloc]initWithFrame:CGRectMake(tableViewTopViewX, tableViewTopViewY, tableViewTopViewW, tableViewTopViewH)];
//    tableViewTopView.backgroundColor=[UIColor redColor];
//    tableViewTopView.image=[UIImage imageNamed:@"mytmall_atmosphere_default"];
//    
//    [self.tableView addSubview:tableViewTopView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 49;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)setupCorverView
{
    UIImageView * corverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    self.corverImageView=corverImageView;
    [self.view addSubview:self.corverImageView];
    self.corverImageView.image= [UIImage imageNamed:@"mytmall_atmosphere_default"];
//    self.corverImageView.frame=  CGRectMake(0, -100, screenW, screenH);
    
    UIImageView * moveOutImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    self.moveOutImageView=moveOutImageView;
    [self.corverImageView addSubview:self.moveOutImageView];
    self.moveOutImageView.image= [UIImage imageNamed:@"mytmall_atmosphere_default"];
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.corverImageView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:self.iconView];
    [self tranform];
}
-(void)tranform
{

    
    [UIView animateWithDuration:0.1 animations:^{
//        self.iconView.center = self.targetPoint;
        self.moveOutImageView.center = CGPointMake(self.view.center.x, 1000);
        
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.corverImageView.alpha = 0;
        }completion:^(BOOL finished) {
//            self.iconView移动到相应的位置
        }];
    }];
}
-(CGPoint)targetPoint{
    return CGPointMake(self.view.center.x, 200);
}
-(UIImageView * )iconView{
    if(_iconView==nil){
         UIImageView * iconView =    [[UIImageView alloc]init];
        iconView.image=[UIImage imageNamed:@"mytmall_atmosphere_default"];
        iconView.bounds = CGRectMake(0, 0, 60, 60);
        iconView.center = CGPointMake(self.view.center.x, -200);
        [self.view addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}
@end




/*
// 2. 设置路径, 绘制贝塞尔曲线
UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:<#(CGPoint)#> radius:<#(CGFloat)#> startAngle:<#(CGFloat)#> endAngle:<#(CGFloat)#> clockwise:<#(BOOL)#>]
CGMutablePathRef path = CGPathCreateMutable();

CGPathMoveToPoint(path, NULL, 200, 200); // 起始点

CGPathAddCurveToPoint(path, NULL, 100, 300, 300, 500, 200, 600);

// CGPathAddCurveToPoint(path, NULL, 控制点1.x, 控制点1.y, 控制点2.x, 控制点2.y, 终点.x, 终点.y);

// 设置path属性

keyframeAnimation.path = path;

CGPathRelease(path);

#endif

// 设置其他属性

keyframeAnimation.duration = 4;

keyframeAnimation.beginTime = CACurrentMediaTime() + 1; // 设置延迟2秒执行, 不设置这个属性, 默认直接执行

*/

