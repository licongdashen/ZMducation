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
#import "ASINetworkQueue.h"

@interface ZMOfflineFilesViewController : ZMBaseOnlineViewController<JTListViewDataSource,JTListViewDelegate,UINavigationControllerDelegate,ReaderViewControllerDelegate,ASIHTTPRequestDelegate>{
    
    JTListView* fileView;
    UINavigationController *pdfNavigationController;
    int index;
    int index1;
    UIButton* enterButton;
}

@property(nonatomic, retain) NSMutableArray* fileArray;



@property(nonatomic, retain) NSArray * downloadArray;

@property(nonatomic, retain) NSDictionary *dic;

@property(nonatomic, strong) NSMutableArray* downArray;

@property(nonatomic, retain) ASINetworkQueue* netWorkQueue;
@property(nonatomic, retain) ASIHTTPRequest *request;
@property int currentDownloadLength;
@property(nonatomic, retain) NSMutableArray* currentDownloadArray;

@property(nonatomic, retain) NSMutableArray * hasDownloadedDictArray;
@end
