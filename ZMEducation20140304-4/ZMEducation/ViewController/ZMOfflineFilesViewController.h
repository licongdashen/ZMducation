//
//  ZMOfflineFilesViewController.h
//  ZMEducation
//
//  Created by wangdan on 15-2-7.
//  Copyright (c) 2015年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "JTListView.h"
#import "ReaderViewController.h"

@interface ZMOfflineFilesViewController : ZMBaseOnlineViewController<JTListViewDataSource,JTListViewDelegate,UINavigationControllerDelegate,ReaderViewControllerDelegate>{
    
    JTListView* fileView;
    UINavigationController *pdfNavigationController;

    
}

@property(nonatomic, retain) NSMutableArray* fileArray;



@property(nonatomic, retain) NSArray * downloadArray;

@property(nonatomic, retain) NSDictionary *dic;

@end
