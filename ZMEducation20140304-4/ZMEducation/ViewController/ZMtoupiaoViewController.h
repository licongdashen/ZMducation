//
//  ZMtoupiaoViewController.h
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

@interface ZMtoupiaoViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scro;
    PageControl* _pageControl;
    UIButton *searchBtn;
}

@property int number;

@property (nonatomic, strong) NSMutableArray *m113Arr;

@property (nonatomic, strong) NSDictionary *m112Dic;

@property (nonatomic, strong) NSMutableArray *m112tmepArr;

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
