//
//  ZMStudyAccumulationViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "JHPopoverViewController.h"

@interface ZMStudyAccumulationViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* studyAccumulationArray;
    
    NSMutableArray* courseArray;
    NSMutableArray* studentArray;
    
    int selectCourseIndex;
    int selectStudentIndex;
    
    JHPopoverViewController* popoverViewController;
}

@end
