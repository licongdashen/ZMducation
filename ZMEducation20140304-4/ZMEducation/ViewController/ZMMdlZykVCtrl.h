//#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"
#import "JHPopoverViewController.h"

//@protocol ZMMdlZykVCtrlDelegate <NSObject>
//
//-(void)ZMMdlZykCloseBtnClick:(UIButton*)sender;
//
//@end
@class ZMMdlZykVCtrl;
@protocol ZMMdlZykVCtrlDelegate <NSObject>
-(void)zykViewDidClose:(ZMMdlZykVCtrl*)viewController;
@end

@interface ZMMdlZykVCtrl : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate>{

    //datasource
    NSMutableArray * categoryArr;
    NSMutableArray * firstClassArr;
    NSMutableArray * subClassArr;
    NSMutableArray * resArr;
    NSDictionary * type_dict;
    
    JHPopoverViewController * popoverViewController;
    
    int selectCategoryIndex;
    int selectFirstClassIndex;
    int selectSubClassIndex;
    int selectResIndex;
    
    int httpId; //1234
    
    UIScrollView * sv_top;
    UIScrollView * sv_bottom;
}

@property(nonatomic,assign) id<ZMMdlZykVCtrlDelegate>delegate;

@end