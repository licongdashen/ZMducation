//
//  ZMBaseOnlineViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-20.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//
#import "ZMMenuViewController.h"
#import "ZMBaseViewController.h"

enum ControllType {
    
    liarary      = 0,
    dictionary   = 1,
    examination  = 2,
    shitiyincang = 3
};
@interface ZMBaseOnlineViewController : ZMBaseViewController {

    NSInteger Gousi044_Type; // add 20131025
    
    NSInteger Shiti_Type;
    
    BOOL M066 ; // 用于区别于屏幕控制, 0 :
    enum ControllType   CT;
    ZMMenuViewController * zmvc;

}

-(void)screenLocked;

@end
