/*
 description : 我的构思
 create time : 20131026
 */
#import "ZMBaseViewController.h"
#import "PageControl.h"
#import "SwipeView.h"
#import "ZMShitiSwipeViewController.h"

@class ZMGousiSwipeViewController;
@protocol ZMGousiSwipeViewControllerDelegate <NSObject>

-(void)ZMGousiSwipeViewDidClose:(ZMGousiSwipeViewController *)viewController;

@end

@interface ZMGousiSwipeViewController : ZMBaseViewController<SwipeViewDataSource,SwipeViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    PageControl* _pageControl;
    //UINavigationController *pdfNavigationController;
 
}

@property(nonatomic, retain) NSMutableArray* unitArray;  //题目数组
@property(nonatomic, retain) SwipeView* swipeView;
@property(nonatomic, retain) UIPopoverController* popoverController;
@property(nonatomic, assign) id<ZMGousiSwipeViewControllerDelegate> delegate;
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;
@end
