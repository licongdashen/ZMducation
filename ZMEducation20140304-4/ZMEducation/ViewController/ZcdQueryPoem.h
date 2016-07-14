#import "JSONKit.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ZMAppDelegate.h"
#import "ZMConfig.h"
#import "ZMHttpEngine.h"

@interface ZcdQueryPoem : UIView<ZMHttpEngineDelegate,UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray * txfieldArr;
    
    NSMutableArray * dataSourceArr;
    NSMutableArray * showArr;
    
    int httpId;
    UIScrollView * sv_top;
    UIScrollView * sv_bottom;
    
    NSDictionary * type_dict;
}
@end