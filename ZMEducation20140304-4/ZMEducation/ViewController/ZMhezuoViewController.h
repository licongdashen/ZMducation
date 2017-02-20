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

@interface ZMhezuoViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
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
    
}
@property (nonatomic, strong) NSMutableArray *hezuoArr;
@property (nonatomic, strong) UIScrollView *scro;
@property int number;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UIView *backView;


@end
