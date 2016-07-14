//
//  ZMZuoYeViewController.h
//  ZMEducation
//
//  Created by Queen on 16/5/31.
//  Copyright © 2016年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMShitiSwipeViewController.h"
#import "ZMGousiSwipeViewController.h"
#import "ZMMdlBbsVCtrl.h"
#import "PageControl.h"

@interface ZMZuoYeViewController : ZMBaseViewController<ZMHttpEngineDelegate>
{
    PageControl* _pageControl;
}
@property(nonatomic, strong) NSMutableArray* unitArray;  //题目数组
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;

@end
