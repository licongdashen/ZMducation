//
//  ZMqiangdaViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"
#import "PageControl.h"

@interface ZMqiangdaViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UILabel *  se3TitleLb;
    BOOL isHidden;
    UITableView *tabv;
    
    NSString *raceId;
    
    UIScrollView *scro;
    PageControl* _pageControl;

}

@property (nonatomic, strong) NSDictionary *m116dic;
@property (nonatomic, strong) NSMutableArray *m115Arr;
@property int number;

@end
