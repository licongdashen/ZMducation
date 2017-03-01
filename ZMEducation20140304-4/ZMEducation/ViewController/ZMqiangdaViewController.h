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

#import "ZMShitiSwipeViewController.h"
#import "ZMGousiSwipeViewController.h"
#import "ZMMdlBbsVCtrl.h"
#import "ZMZuoYeViewController.h"
#import "ZMqiangdaViewController.h"
#import "ZMhezuoViewController.h"
#import "ZMtoupiaoViewController.h"
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

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;
@property (nonatomic, strong)UIButton *toupiaoBtn;
@property (nonatomic, strong)UIButton *qiangdaBtn;
@property (nonatomic, strong)UIButton *hezuoBtn;

@end
