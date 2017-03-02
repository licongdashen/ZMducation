//
//  ZMhezuoViewController.h
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
@interface ZMhezuoViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    PageControl* _pageControl;
    UISegmentedControl *segment;
    
    UIView *backview1;
    UIView *backview2;
    UIView *backview3;
    UIView *backview4;

    UILabel *titeleLb1;
    UILabel *subtitleLb1;
    
    UITextView *contentTv;
    
    UITextView * contentTv1;
    
    UIButton *refishBtn;
    
    UIButton *commmitBtn;
    
    UILabel *se2TitleLb;
    
    UITableView *se2Tabv;
    
    UIButton *se2SelBtn;
    
    UIButton *toupiaoBtn;
    
    UIView *tuView;
    
    UITableView *se3Tabv;
    
    UITableView *se3slTabv;
    
    UILabel *se3TitleLb;
    
    UIButton *se3TitleBtn;
    
    BOOL isHidden;
    
    NSString *m126id;
    
    NSInteger secion1;
    NSInteger row1;
    NSString *contentStr;
}

@property (nonatomic, strong) NSMutableArray *hezuoArr;
@property (nonatomic, strong) UIScrollView *scro;
@property int number;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSDictionary *M124dic;
@property (nonatomic, strong) NSMutableArray *M124tempArr;
@property (nonatomic, strong) NSMutableArray *M126Arr;
@property (nonatomic, strong) NSDictionary *M125dic;
@property (nonatomic, strong) NSMutableArray *M125tempArr;
@property (nonatomic, strong) NSDictionary *M125Adic;
@property (nonatomic, strong) NSMutableArray *M125AtempArr;
@property (nonatomic, strong) NSMutableArray *wengaoArr;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;
@property (nonatomic, strong)UIButton *toupiaoBtn;
@property (nonatomic, strong)UIButton *qiangdaBtn;
@property (nonatomic, strong)UIButton *hezuoBtn;
@property (nonatomic, strong) UIView *shoucangview;
@property (nonatomic, strong)     NSString *nameStr;

@end
