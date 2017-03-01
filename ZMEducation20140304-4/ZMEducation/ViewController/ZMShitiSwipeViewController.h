/*
 description : 我的构思
 create time : 20131026
 */
#import "ZMBaseViewController.h"
#import "PageControl.h"
#import "SwipeView.h"
#import "ZMGousiSwipeViewController.h"

@class ZMShitiSwipeViewController;
@protocol ZMShitiSwipeViewControllerDelegate <NSObject>

-(void)ZMShitiSwipeViewDidClose:(ZMShitiSwipeViewController *)viewController;

@end

@interface ZMShitiSwipeViewController : ZMBaseViewController<SwipeViewDataSource,SwipeViewDelegate,UINavigationControllerDelegate>{
    PageControl* _pageControl;
   
}

@property(nonatomic, retain) NSMutableArray* unitArray;  //题目数组
@property(nonatomic, retain) SwipeView* swipeView;

@property(nonatomic, assign) id<ZMShitiSwipeViewControllerDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;

@property (nonatomic, strong)UIButton *toupiaoBtn;
@property (nonatomic, strong)UIButton *qiangdaBtn;
@property (nonatomic, strong)UIButton *hezuoBtn;

@end
