//
//  ZMqiangdaViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"

@interface ZMqiangdaViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UILabel *  se3TitleLb;
    BOOL isHidden;
    UITableView *tabv;
}

@property (nonatomic, strong) NSDictionary *m116dic;
@end
