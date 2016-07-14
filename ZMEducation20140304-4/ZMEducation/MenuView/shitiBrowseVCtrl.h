#import "ZMBaseViewController.h"

@interface shitiBrowseVCtrl : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * shitiArr;
    NSMutableArray * shitiObjArr;
}

@property(nonatomic, retain) NSMutableDictionary* unitDict;

@end