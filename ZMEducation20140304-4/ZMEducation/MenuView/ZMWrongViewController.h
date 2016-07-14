//
//  ZMWrongViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-1.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "JHPopoverViewController.h"

@interface ZMWrongViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSMutableArray* wrongArray;
    
    NSMutableArray* courseArray;
    NSMutableArray* studentArray;
    
    int selectCourseIndex;
    int selectStudentIndex;
    
    JHPopoverViewController* popoverViewController;
}

@end
