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

@interface ZMtoupiaoViewController : ZMBaseViewController<ZMHttpEngineDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scro;
    PageControl* _pageControl;
}

@property int number;

@property (nonatomic, strong) NSMutableArray *m113Arr;

@property (nonatomic, strong) NSDictionary *m112Dic;

@property (nonatomic, strong) NSMutableArray *m112tmepArr;

@end
