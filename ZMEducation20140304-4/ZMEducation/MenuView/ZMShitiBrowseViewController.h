/*
 description : 试题浏览
 create time : 20131026
 */
#import "ZMBaseViewController.h"
#import "ZMBaseOnlineViewController.h"
#import "PageControl.h"
#import "SwipeView.h"

@interface ZMShitiBrowseViewController : ZMBaseOnlineViewController<SwipeViewDataSource,SwipeViewDelegate,UINavigationControllerDelegate>{
    PageControl* _pageControl;
}

@property(nonatomic, retain) NSArray* unitArray;  //题目数组
@property(nonatomic, retain) SwipeView* swipeView;


@end

