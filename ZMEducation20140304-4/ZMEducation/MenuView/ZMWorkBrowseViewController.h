//
//  ZMWorkBrowseViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-30.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//


#import "ZMBaseOnlineViewController.h"
#import "JHPopoverViewController.h"

@interface ZMWorkBrowseViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* courseArray;
    NSMutableArray* moduleArray;
    NSMutableArray* moduleArray1;
    NSMutableArray* studentArray;
    NSMutableArray* workArray;

    int selectCourseIndex;
    int selectModuleIndex;
    int selectStudentIndex;
    
    JHPopoverViewController* popoverViewController;
}

@end
