//
//  ZMWriteGuideViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleBaseViewController.h"
#import "UIExpandingTextView.h"

@interface ZMWriteGuideViewController : ZMArticleBaseViewController{
    UIExpandingTextView* topicView;
    UIExpandingTextView* formView;
    UIExpandingTextView* targetView;
    UIExpandingTextView* readerView;
    UIExpandingTextView* wordView;
}

//@property(nonatomic, retain) NSMutableDictionary* unitDict;

@end
