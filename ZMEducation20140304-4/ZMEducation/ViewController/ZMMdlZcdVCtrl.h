//#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"
#import "ZMMdlZykVCtrl.h"
#import "JHPopoverViewController.h"


@class ZMMdlZcdVCtrl;
@protocol ZMMdlZcdVCtrlDelegate <NSObject>
-(void)zcdViewDidClose:(ZMMdlZcdVCtrl*)viewController;
@end

@interface ZMMdlZcdVCtrl : ZMBaseViewController<ZMMdlZykVCtrlDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * type_Arr;
    NSMutableArray * history_Arr;
    JHPopoverViewController * popoverViewController;
    int typeSelectIndex;
    

}

@property(nonatomic, assign) id<ZMMdlZcdVCtrlDelegate> zcdDelegate;

@end