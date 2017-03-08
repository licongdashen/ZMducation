//
//  ZMpengyouquanViewController.h
//  ZMEducation
//
//  Created by Queen on 2017/3/7.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "JHPopoverViewController.h"
#import "ZMBaseOnlineViewController.h"

@interface ZMpengyouquanViewController : ZMBaseOnlineViewController<ZMHttpEngineDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{
NSMutableArray* courseArray;
NSMutableArray* moduleArray;
NSMutableArray* moduleArray1;
NSMutableArray* studentArray;
NSMutableArray* workArray;

int selectCourseIndex;
int selectModuleIndex;
int selectStudentIndex;

JHPopoverViewController* popoverViewController;
}
@end
