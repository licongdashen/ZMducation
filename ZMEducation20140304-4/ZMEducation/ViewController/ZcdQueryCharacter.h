#import "JSONKit.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ZMAppDelegate.h"
#import "ZMConfig.h"
#import "ZMHttpEngine.h"
#import "JHPopoverViewController.h"


@interface ZcdQueryCharacter : UIView<ZMHttpEngineDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * txfieldArr;
    
    NSMutableArray * datasourceBushou;
    NSMutableArray * dataSourceArr;
    
    JHPopoverViewController * popoverViewController;
    
    int bishouSelectIndex;
    
    int characterSelectIndex;
    
    int httpId ;
    
    UITextField * bushouTF;
    NSMutableArray * showArr;
    
    
    UIScrollView * sv_top;
    UIScrollView * sv_bottom;
    
    NSDictionary * type_dict;

}

@end