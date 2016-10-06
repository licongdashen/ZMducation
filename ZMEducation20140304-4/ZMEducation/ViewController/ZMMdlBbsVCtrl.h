//#import <UIKit/UIKit.h>
#import "ZMBaseViewController.h"
#import "JHPopoverViewController.h"
#import "UIExpandingTextView.h"

@interface ZMMdlBbsVCtrl : ZMBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UIExpandingTextView  * TV_Draft_Content ;
    
    UIScrollView * forumTitleScrollView;
    
    
    //datasource
    //NSMutableArray * Course_Arr;
    NSMutableArray * Forum_Arr_User;
    NSMutableArray * Forum_Arr_Course;

    NSMutableArray * Bbs_Arr;
    
    UIPopoverController * popoverViewController;
    
    //int selectCourseIndex;
    int selectForumIndex;
    int selectForumIndex2;
    //BOOL isGetForumByCourse;
    

}
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIButton *panBtn;
@property (nonatomic, strong)UIButton *gousiBtn;
@property (nonatomic, strong)UIButton *luntanBtn;
@property (nonatomic, strong)UIButton *shijuanBtn;
@property (nonatomic, strong)UIButton *zuoyeBtn;
@end