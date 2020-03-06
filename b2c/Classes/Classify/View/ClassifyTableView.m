//
//  ClassifyTableView.m
//  b2c
//
//  Created by 0 on 16/4/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "ClassifyTableView.h"
#import "ClassifyFirstLevelModel.h"
#import "ClassifyTwoThreelevelModel.h"
#import "MJExtension.h"
#import "COneLevelCell.h"
@interface ClassifyTableView()
/**一级分类的数组*/
@property (nonatomic, strong) NSMutableArray *catelogyList;
@property (nonatomic, weak) ClassifyFirstLevelModel *selectCateModel;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/**取消选中的indexPath*/
@property (nonatomic, strong) NSIndexPath *beforeIndexPath;
@property (nonatomic, weak) ClassifyTwoThreelevelModel *defuletModel;

@end

@implementation ClassifyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        LOG(@"%@,%d,%@",[self class], __LINE__,@"2")
        __weak typeof(self) Myself = self;
        // 去除分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 取消滚动条
        self.showsVerticalScrollIndicator = NO;
        // 允许反弹
        self.bounces = YES;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[COneLevelCell class] forCellReuseIdentifier:@"COneLevelCell"];
        //判断某个文件是否存在
        [[UserInfo shareUserInfo] gotClassifySuccess:^(ResponseObject *response) {
            NSDictionary *oneLevelDic = response.data[0];
            ClassifyFirstLevelModel *firstlevelModel = [ClassifyFirstLevelModel mj_objectWithKeyValues:oneLevelDic];
            ClassifyTwoThreelevelModel *twoThreeModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
            Myself.defuletModel = twoThreeModel;
            
            
            [Myself.catelogyList addObjectsFromArray:firstlevelModel.classone];
            for (NSInteger i = 0; i < firstlevelModel.classone.count; i++) {
                ClassifyFirstLevelModel *model = firstlevelModel.classone[i];
                model.isSelected = NO;
            }
            
            [self reloadData];
            //第一个被选中
            
            if (self.catelogyList.count == 0) {
                
            }else{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                _selectCateModel = Myself.catelogyList[0];
//                [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                [self tableView:self didSelectRowAtIndexPath:indexPath];
                
                
            }
        } failure:^(NSError *error) {
            LOG(@"%@,%d,%@",[self class], __LINE__,error)
        }];

    }
    return self;
}

- (NSMutableArray *)catelogyList {
    if (_catelogyList == nil) {
        _catelogyList = [NSMutableArray array];
    }
    
    return _catelogyList;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.catelogyList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55 * SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    COneLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COneLevelCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    // 设置cell内容
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    cell.firsLevelModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark 取消选中后做什么
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    model.isSelected = NO;
    COneLevelCell *cell = (COneLevelCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.firsLevelModel = model;
    LOG(@"%@,%d,%ld",[self class], __LINE__,indexPath.row)
    
}



#pragma mark 点击cell会怎么样
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (![_beforeIndexPath isEqual:_selectedIndexPath]) {
    //        if (_selectedIndexPath.length != 0) {
    //            NSIndexPath *index = [NSIndexPath indexPathForItem:_selectedIndexPath.row inSection:_selectedIndexPath.section];
    //            _beforeIndexPath = index;
    //            [self tableView:tableView didDeselectRowAtIndexPath:_beforeIndexPath];
    //            [tableView reloadRowsAtIndexPaths:@[_beforeIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    //        }
    //    }
    // 保存所选cell位置
    //    _selectedIndexPath = indexPath;
    
    // 滚到顶端
    //    LOG(@"%@,%d,%@",[self class], __LINE__,@"4")
    //    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    LOG(@"%@,%d,%ld",[self class], __LINE__,indexPath.row)
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    model.isSelected = YES;
    
    
    COneLevelCell *cell = (COneLevelCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.firsLevelModel = model;
    
    __weak typeof(self) Myself = self;
    //避免重复刷新
    if ([Myself.selectCateModel.ID isEqualToString:model.ID] == NO) {
        Myself.selectCateModel = model;
        [[UserInfo shareUserInfo] gotSubClassifyWithClassID:[_selectCateModel.ID integerValue] success:^(ResponseObject *response) {
            ClassifyTwoThreelevelModel *twoThreeModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"categary" object:nil userInfo:@{@"classifyModel":twoThreeModel}];
        } failure:^(NSError *error) {
            LOG(@"%@,%d,%@",[self class], __LINE__,error)
        }];
        
    }
    //    [tableView reloadData];
    
    
    
    
}



@end
