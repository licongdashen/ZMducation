//
//  ZMScreenControlViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"

@interface ZMScreenControlViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *screenControlTableView;
    
    NSMutableArray* unitHide00Array;
    NSMutableArray* unitHide01Array;
    NSMutableArray* unitHide02Array;
    NSMutableArray* unitHide03Array;
    NSMutableArray* unitHide04Array;
    NSMutableArray* unitHide05Array;
}

@end
