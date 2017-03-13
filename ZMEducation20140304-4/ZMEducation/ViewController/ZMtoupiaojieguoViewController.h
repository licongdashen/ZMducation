//
//  ZMtoupiaojieguoViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/3/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"

@interface ZMtoupiaojieguoViewController : ZMBaseViewController<UITableViewDelegate,UITableViewDataSource,ZMHttpEngineDelegate>

@property (nonatomic, strong) NSMutableDictionary *dic1;

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSString *str;

@end
