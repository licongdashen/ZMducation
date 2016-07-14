//
//  ZMCourseViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-29.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "JTListView.h"

@interface ZMCourseViewController : ZMBaseViewController<JTListViewDataSource,JTListViewDelegate>{
    NSMutableArray* courseArray;
    NSMutableArray* classArray;
    NSMutableArray* moduleArray;
    
    JTListView* gradeView;
    JTListView* classView;
    JTListView* courseView;
    
    int selectGrade;
    int selectClass;
    int selectCourse;
}

@property(nonatomic, retain) NSArray* gradeArray;

@end
