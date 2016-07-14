//
//  ZMFeedbackDetailViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-26.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "FGalleryViewController.h"

#define kTagFeedbackCommitButton 5201

@interface ZMFeedbackDetailViewController : ZMBaseOnlineViewController<UITableViewDataSource,UITableViewDelegate,FGalleryViewControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
     NSMutableArray* _feedbackArray;
    
    NSMutableArray* photosArray;
    
    int reviewType;
    
    NSDictionary * feedbackDict_Gousi;
    NSMutableArray *gousiFeedBack_AdvicesTextView;
    NSMutableArray *gousiFeedBack_AppreciateTextView;
    UILabel *selfTotal;
    UILabel * otherTotal;
    int editMode; //自评他评编辑模式 0 自评不可编辑  1 他评不可编辑  用于reviewtype=2的点评表 20140119

}

@property(nonatomic, assign) int type;//1作者答题 2我的点评 3作业浏览
@property(nonatomic, retain) NSMutableDictionary* unitDict;

@end
