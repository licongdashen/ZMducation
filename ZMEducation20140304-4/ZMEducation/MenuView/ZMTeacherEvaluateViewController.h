//
//  ZMTeacherEvaluateViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "JHPopoverViewController.h"

#define kTagEvaluateCommitButton 5201

@interface ZMTeacherEvaluateViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSMutableArray* courseArray;
    NSMutableArray* studentArray;
    NSMutableArray* evaluateArray;
    
    int selectCourseIndex;
    int selectStudentIndex;
    
    JHPopoverViewController* popoverViewController;
    
    UISegmentedControl *prepareSegmentedControl;
    UISegmentedControl *activitySegmentedControl;
    UISegmentedControl *processSegmentedControl;
    UISegmentedControl *importanceSegmentedControl;
    UISegmentedControl *commonSegmentedControl;
}

@end
