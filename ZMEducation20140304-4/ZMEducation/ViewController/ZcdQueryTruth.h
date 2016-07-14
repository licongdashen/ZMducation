#import "JSONKit.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ZMAppDelegate.h"
#import "ZMConfig.h"
#import "ZMHttpEngine.h"
#import "JHPopoverViewController.h"
#import "ZMBaseViewController.h"

@interface ZcdQueryTruth : UIView<ZMHttpEngineDelegate,UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray * txfieldArr;
    NSMutableArray * btnArr;
    
    //datasource
    
    NSMutableArray * firstClassArr;
    NSMutableArray * subClassArr;
    NSMutableArray * resArr;
   
    JHPopoverViewController * popoverViewController;
    

    int selectFirstClassIndex;
    int selectSubClassIndex;
    int selectResIndex;
    
    int httpId; //1234
    
    UIScrollView * sv_top;
    UIScrollView * sv_bottom;
    
    NSMutableArray * showArr;
    
    UIButton* firstClassSelectBut;
    UIButton* subClassSelectBut;
    
    NSDictionary * type_dict;
}
@end