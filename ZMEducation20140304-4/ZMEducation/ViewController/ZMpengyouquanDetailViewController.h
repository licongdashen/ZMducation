//
//  ZMpengyouquanDetailViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/3/8.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"

@interface ZMpengyouquanDetailViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *dic;

@end
