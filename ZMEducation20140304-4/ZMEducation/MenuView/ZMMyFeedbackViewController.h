//
//  ZMMyFeedbackViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-3.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "JHPopoverViewController.h"

@interface ZMMyFeedbackViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* courseArray;
    NSMutableArray* moduleArray;
    NSMutableArray* studentArray;
    NSMutableArray* feedbackArray;
    
    int selectCourseIndex;
    int selectModuleIndex;
    int selectStudentIndex;
    
    JHPopoverViewController* popoverViewController;
}

@end
