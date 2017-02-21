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
}

@property (nonatomic, strong) NSMutableArray *hezuoArr;
@property (nonatomic, strong) UIScrollView *scro;
@property int number;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSDictionary *M124dic;
@property (nonatomic, strong) NSMutableArray *M124tempArr;

@end
