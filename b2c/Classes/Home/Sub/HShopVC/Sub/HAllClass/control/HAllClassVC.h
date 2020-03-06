//
//  HAllClassVC.h
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreBaseVC.h"
#import "HShopSearchField.h"

@interface HAllClassVC : HStoreBaseVC<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**搜索框*/
@property (nonatomic, strong) HShopSearchField *searchField;

@end
