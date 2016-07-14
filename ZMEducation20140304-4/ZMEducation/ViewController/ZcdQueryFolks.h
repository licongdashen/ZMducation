#import "JSONKit.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ZMAppDelegate.h"
#import "ZMConfig.h"
#import "ZMHttpEngine.h"
#import "JHPopoverViewController.h"

@interface ZcdQueryFolks : UIView<ZMHttpEngineDelegate,UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray * txfieldArr;
    NSMutableArray * dataSourceArr;
    NSMutableArray * categorySourceArr;
    NSMutableArray * showArr;
    
    int httpId;
    UIScrollView * sv_top;
    UIScrollView * sv_bottom;
    int cagetorySelectIndex;
    
    JHPopoverViewController * popoverViewController;
    
    UIButton* categorySelectBut;
    
    NSDictionary * type_dict;
    
}
@end