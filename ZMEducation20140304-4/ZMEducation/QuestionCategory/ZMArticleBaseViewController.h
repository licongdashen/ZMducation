//
//  ZMArticleBaseViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "UIExpandingTextView.h"

#define kTagShareButton 3102

#define kTagWorkCommitButton 5200
#define kTagFeedbackCommitButton 5201

#define kTagArticleTitleView 1100
#define kTagArticleDraftView 1101

#define kTagArticleComment01View 1300
#define kTagArticleComment02View 1301
#define kTagArticleComment03View 1302

@interface ZMArticleBaseViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIExpandingTextViewDelegate,UITextFieldDelegate>{
    UIScrollView* theScrollView;
    UIView* articleView;
    
    NSMutableArray* _feedbackArray;
    
    int _cellCount;
    
    NSMutableDictionary* articleDict;
    NSDictionary * gousiDict;
    NSDictionary * feedbackDict_Gousi;
    
    NSMutableArray * gousiFeedBack_AdvicesTextView;
    NSMutableArray * gousiFeedBack_AppreciateTextView;
    NSInteger reviewType; // 点评模板类型
    
    int editMode; //自评他评编辑模式 0 自评不可编辑  1 他评不可编辑  用于reviewtype=2的点评表 20140119
    
    UILabel *selfTotal;
    UILabel * otherTotal;
}

@property(nonatomic, assign) int type;//1作者答题 2我的点评 3作业浏览
@property(nonatomic, retain) NSMutableDictionary* unitDict;

@property BOOL issuccess;

-(void)addDraftView;
-(void)addContentView;
-(void)addCommentView;

-(void)submitWork;

@end
