//
//  ZMCourseViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-29.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "JTListView.h"
#import "ASINetworkQueue.h"

@interface ZMCourseViewController : ZMBaseViewController<JTListViewDataSource,JTListViewDelegate,ASIHTTPRequestDelegate>{
    NSMutableArray* courseArray;
    NSMutableArray* classArray;
    NSMutableArray* moduleArray;
    
    NSMutableArray * hasDownloadedDictArray;
    
    JTListView* gradeView;
    JTListView* classView;
    JTListView* courseView;
    
    int selectGrade;
    int selectClass;
    int selectCourse;
    
    int currentDownloadLength;
    
    NSMutableArray* currentDownloadArray;
    
    NSString * grade;
    NSString * course;
    NSString * sort;
    NSString *courseSort;
    
    ;
}

@property(nonatomic, retain) NSArray* gradeArray;
@property(nonatomic, retain) ASINetworkQueue* netWorkQueue;
@property(nonatomic, retain) ASIHTTPRequest *request;

@end
