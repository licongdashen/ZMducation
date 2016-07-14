#import "ZMBaseViewController.h"

@interface ZMMdlShitiVCtrl : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * shitiArr;
    NSMutableArray * shitiObjArr;
}

@property(nonatomic, retain) NSMutableDictionary* unitDict;

@end