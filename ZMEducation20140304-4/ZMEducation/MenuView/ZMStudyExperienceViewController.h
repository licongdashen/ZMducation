//
//  ZMStudyExperienceViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseOnlineViewController.h"
#import "UIExpandingTextView.h"

#define kTagStudyExperienceCommitButton 5201

@interface ZMStudyExperienceViewController : ZMBaseOnlineViewController<UIAlertViewDelegate>{
    UIExpandingTextView* wordView;
    
    UIExpandingTextView* words_01View;
    UIExpandingTextView* words_02View;
    UIExpandingTextView* words_03View;
    
    UIExpandingTextView* experience_01View;
    UIExpandingTextView* experience_02View;
    UIExpandingTextView* experience_03View;
}

@property(nonatomic, retain) NSMutableDictionary* courseDict;
@property(nonatomic, assign) int type;//1历史积累 2当前积累

@end
