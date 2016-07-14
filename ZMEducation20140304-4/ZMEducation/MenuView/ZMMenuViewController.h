//
//  ZMMenuViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-18.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

@class ZMMenuViewController;
@protocol ZMMenuViewCOntrollerDelegate <NSObject>

//-(void)menuViewDidGousi:(ZMMenuViewController*)viewController;
//-(void)menuViewDidDictionary:(ZMMenuViewController*)viewController;
//-(void)menuViewDidZiyuanku:(ZMMenuViewController*)viewController;
-(void)menuViewDidBbs:(ZMMenuViewController*)viewController;
-(void)menuViewDidClose:(ZMMenuViewController*)viewController;
-(void)menuViewDidLogout:(ZMMenuViewController*)viewController;
-(void)menuViewDidBrowseWorks:(ZMMenuViewController*)viewController;
-(void)menuViewDidBrowseShiti:(ZMMenuViewController*)viewController;
-(void)menuViewDidBrowseWrong:(ZMMenuViewController*)viewController;
-(void)menuViewDidBrowseMyFeedback:(ZMMenuViewController*)viewController;
-(void)menuViewDidTeacherEvaluate:(ZMMenuViewController*)viewController;
-(void)menuViewDidStudyAccumulation:(ZMMenuViewController*)viewController;
-(void)menuViewDidScreenControl:(ZMMenuViewController*)viewController;

@end

#import "ZMBaseViewController.h"

@interface ZMMenuViewController : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView* userTableView;
    NSMutableArray* userArray;
}

@property(nonatomic, assign) id<ZMMenuViewCOntrollerDelegate> menuDelegate;

@property(nonatomic, assign) BOOL screenControlOn;

@end
