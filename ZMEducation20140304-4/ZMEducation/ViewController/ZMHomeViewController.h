//
//  ZMHomeViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "GMGridView.h"
#import "ZMBaseOnlineViewController.h"

@interface ZMHomeViewController : ZMBaseOnlineViewController<GMGridViewDataSource>{
    GMGridView* moduleView;
}

@property(nonatomic, retain) NSArray* moduleArray;

@end
