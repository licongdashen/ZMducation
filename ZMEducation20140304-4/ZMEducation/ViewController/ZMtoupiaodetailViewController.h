//
//  ZMtoupiaodetailViewController.h
//  ZMEducation
//
//  Created by 李聪 on 2017/2/28.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"

@interface ZMtoupiaodetailViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *voteId;
@end
