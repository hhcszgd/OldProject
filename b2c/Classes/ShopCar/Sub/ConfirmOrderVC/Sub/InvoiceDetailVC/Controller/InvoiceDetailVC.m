//
//  InvoiceDetailVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "InvoiceDetailVC.h"

@interface InvoiceDetailVC ()
//@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)   UIButton * invoice  ;
@property(nonatomic,weak)   UIButton * noInvoice  ;
@end

@implementation InvoiceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupsubviews];
    
    // Do any additional setup after loading the view.
}
-(void)setupsubviews
{

    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.startY+2, self.view.bounds.size.width,60)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text=@"    发票内容";
    
    [self.view addSubview:titleLabel];
    
    UIView * midContainer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, self.view.bounds.size.width, 88)];
    midContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midContainer];
    CGFloat margin = 10 ;
    UIButton * noInvoice = [[UIButton alloc]initWithFrame:CGRectMake(margin, 0,  midContainer.bounds.size.height/2, midContainer.bounds.size.height/2)];
    noInvoice.selected=YES;
    self.noInvoice = noInvoice;
    
    [noInvoice setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
    [noInvoice setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
    [midContainer addSubview:noInvoice];
    [self.noInvoice addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    noInvoice.adjustsImageWhenHighlighted = NO;
   
    UILabel *  noInvoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noInvoice.frame), 0, midContainer.bounds.size.width -CGRectGetMaxX(noInvoice.frame) , midContainer.bounds.size.height/2)];
    noInvoiceLabel.text = @"不开发票";
    [midContainer addSubview:noInvoiceLabel];
    
    
    
    
    
    
    
    UIButton * invoice = [[UIButton alloc]initWithFrame:CGRectMake(margin, midContainer.bounds.size.height/2,  midContainer.bounds.size.height/2, midContainer.bounds.size.height/2)];
    [midContainer addSubview:invoice];
    self.invoice = invoice ;
    invoice.adjustsImageWhenHighlighted=NO;
    [invoice setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
    [invoice setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
    
    [self.invoice addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *  invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(invoice.frame), midContainer.bounds.size.height/2, midContainer.bounds.size.width -CGRectGetMaxX(invoice.frame) , midContainer.bounds.size.height/2)];
    invoiceLabel.text = @"明细";
    [midContainer addSubview:invoiceLabel];
    
    
    
    CGFloat confirmButtonW =  self.view.bounds.size.width - 40;
    CGFloat confirmButtonH = 44 ;
    CGFloat confirmButtonX = 20 ;
    CGFloat confirmButtonY = self.view.bounds.size.height - 20 - confirmButtonH ;
    
    
    UIButton * confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(confirmButtonX, confirmButtonY, confirmButtonW, confirmButtonH)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.backgroundColor = THEMECOLOR;
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)chooseOption:(UIButton*)sender
{
    if (sender == self.noInvoice && self.noInvoice.selected==NO) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点上");
        self.noInvoice.selected = YES;
        self.invoice.selected = NO;
    }else if(sender == self.invoice && self.invoice.selected ==NO ){
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点下");
        self.noInvoice.selected = NO;
        self.invoice.selected = YES;
    }
}
-(void)confirmClick:(UIButton*)sender
{
    BOOL temp  = NO ;
    if (self.noInvoice.selected) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"不开发票");
        temp =NO ;
    }else if (self.invoice.selected){
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"开发票");
        temp = YES;
    }
    if ([self.InvoiceDetailDelegate respondsToSelector:@selector(setInvoiceOrNot:)]) {
        [self.InvoiceDetailDelegate setInvoiceOrNot:temp];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
