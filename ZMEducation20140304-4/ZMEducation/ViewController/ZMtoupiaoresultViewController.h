//
//  ZMtoupiaoresultViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/3/10.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"

@interface ZMtoupiaoresultViewController : ZMBaseViewController<UITableViewDelegate,UITableViewDataSource,ZMHttpEngineDelegate>
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableDictionary *dic1;

@end
