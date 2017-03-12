#import "ZMBaseViewController.h"

@interface shitiBrowseVCtrl : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * shitiArr;
    NSMutableArray * shitiObjArr;
    NSString *nameStr;
    NSString *contentStr;
    BOOL shoucangHidden;
}

@property(nonatomic, retain) NSMutableDictionary* unitDict;
@property (nonatomic, strong) UIView *shoucangview;
@property (nonatomic, strong) NSDictionary *shiti;

@end
