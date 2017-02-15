/*
 description : 我的构思
 create time : 20131026
 */

#import "ZMGousiSwipeViewController.h"

#import "ZMWriteGuideViewController.h"
#import "FGalleryViewController.h"
#import "ZMCheckItemViewController.h"
#import "ZMArticleViewController.h"
#import "ZMArticleView01Controller.h"
#import "ZMArticleView02Controller.h"
#import "ZMArticleView03Controller.h"
#import "ZMArticleView04Controller.h"
#import "ZMArticleView05Controller.h"
#import "ZMArticleView06Controller.h"
#import "ZMArticleView07Controller.h"

//模板 add 20131003
#import "ZMMdlCmpVCtrl.h"
#import "ZMMdlExplainVCtrl.h"
#import "ZMMdlTopicVCtrl.h"
#import "ZMMdlSliderVCtrl.h"
#import "ZMMdlStoryVCtrl.h"
#import "ZMMdlTravelVCtrl.h"
#import "ZMMdlConceptionVCtrl.h"
#import "ZMMdlBbsVCtrl.h"
#import "ZMZuoYeViewController.h"

#import "ZMtoupiaoViewController.h"
#import "ZMqiangdaViewController.h"
#import "ZMhezuoViewController.h"

#define kTagCloseGousiBtn 20131123

@implementation ZMGousiSwipeViewController
@synthesize popoverController;
@synthesize unitArray = _unitArray;
@synthesize swipeView = _swipeView;
@synthesize delegate;
-(void)dealloc{
    [_swipeView setDataSource:nil];
    [_swipeView setDelegate:nil];
    [_swipeView release];
    [_pageControl release];
    [_unitArray release];

    [super dealloc];
}

-(IBAction)closeClick:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCloseGousiBtn];
    [alert show];
    [alert release];
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == kTagCloseGousiBtn) {
//            [self.delegate ZMGousiSwipeViewDidClose:self];
            [self dismissViewControllerAnimated:YES completion:^{
                
                NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                [userDict setObject:@"1" forKey:@"articleMode"];
                
            }];
        }
    }
}

/*#pragma mark delegate
-(void)delegateCloseClick:(UIButton*)sender{
    [self.delegate ZMGousiSwipeViewDidClose:self];
    
}*/

-(void)loadView{
    [super loadView];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [userDict setObject:@"0" forKey:@"articleMode"];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    
    _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f)];
    [_swipeView setDataSource:self];
    [_swipeView setDelegate:self];
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    [self.view addSubview:_swipeView];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
	_pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
	_pageControl.padding = 13.0f;
	_pageControl.orientation = PageControlOrientationLandscape;
	_pageControl.numberOfPages = _swipeView.numberOfPages;
    [self.view addSubview:_pageControl];
   
    {
        UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [closeBut addTarget:self
                     action:@selector(closeClick:)
           forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeBut];
    }
  
    self.panBtn = [[UIButton alloc]initWithFrame:CGRectMake(948, 500, 50, 50)];
    self.panBtn.backgroundColor = [UIColor grayColor];
    self.panBtn.layer.cornerRadius = 8;
    self.panBtn.layer.masksToBounds = YES;
    self.panBtn.alpha = 0.9;
    [self.panBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.panBtn];
    
    self.gousiBtn = [[UIButton alloc]init];
    self.gousiBtn.backgroundColor = [UIColor grayColor];
    [self.gousiBtn setTitle:@"构思图表" forState:UIControlStateNormal];
    [self.gousiBtn addTarget:self action:@selector(gousi) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gousiBtn];
    self.gousiBtn.hidden = YES;
    
    self.zuoyeBtn = [[UIButton alloc]init];
    self.zuoyeBtn.backgroundColor = [UIColor grayColor];
    [self.zuoyeBtn setTitle:@"我的文稿" forState:UIControlStateNormal];
    [self.zuoyeBtn addTarget:self action:@selector(zuoye) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zuoyeBtn];
    self.zuoyeBtn.hidden = YES;
    
    self.luntanBtn = [[UIButton alloc]init];
    self.luntanBtn.backgroundColor = [UIColor grayColor];
    [self.luntanBtn setTitle:@"论坛" forState:UIControlStateNormal];
    [self.luntanBtn addTarget:self action:@selector(luntan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.luntanBtn];
    self.luntanBtn.hidden = YES;
    
    self.shijuanBtn = [[UIButton alloc]init];
    self.shijuanBtn.backgroundColor = [UIColor grayColor];
    [self.shijuanBtn setTitle:@"习题" forState:UIControlStateNormal];
    [self.shijuanBtn addTarget:self action:@selector(shijuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shijuanBtn];
    self.shijuanBtn.hidden = YES;
    
    self.toupiaoBtn = [[UIButton alloc]init];
    self.toupiaoBtn.backgroundColor = [UIColor grayColor];
    [self.toupiaoBtn setTitle:@"投票" forState:UIControlStateNormal];
    [self.toupiaoBtn addTarget:self action:@selector(toupiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toupiaoBtn];
    self.toupiaoBtn.hidden = YES;
    
    self.qiangdaBtn = [[UIButton alloc]init];
    self.qiangdaBtn.backgroundColor = [UIColor grayColor];
    [self.qiangdaBtn setTitle:@"抢答" forState:UIControlStateNormal];
    [self.qiangdaBtn addTarget:self action:@selector(qiangda) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qiangdaBtn];
    self.qiangdaBtn.hidden = YES;
    
    self.hezuoBtn = [[UIButton alloc]init];
    self.hezuoBtn.backgroundColor = [UIColor grayColor];
    [self.hezuoBtn setTitle:@"合作" forState:UIControlStateNormal];
    [self.hezuoBtn addTarget:self action:@selector(hezuo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hezuoBtn];
    self.hezuoBtn.hidden = YES;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.panBtn addGestureRecognizer:self.panGestureRecognizer];
    
    UITapGestureRecognizer *TAP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:TAP];
}

-(void)tap
{
    self.gousiBtn.hidden = NO;
    self.zuoyeBtn.hidden = NO;
    self.luntanBtn.hidden = NO;
    self.shijuanBtn.hidden = NO;
    self.toupiaoBtn.hidden = NO;
    self.qiangdaBtn.hidden = NO;
    self.hezuoBtn.hidden = NO;
    
    self.gousiBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y - 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.zuoyeBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y + 200, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.luntanBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.shijuanBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.toupiaoBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y + 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.qiangdaBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y + 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.hezuoBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y + 200, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);

    self.panBtn.hidden = YES;

}

-(void)gousi
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden  = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;
    self.panBtn.hidden = NO;

}

-(void)zuoye
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden  = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M069" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)luntan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden  = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;
    
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];

    NSString * courseID = [userDict valueForKey:@"currentCourseId"];

    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    [requestDict setValue:@"M051" forKey:@"method"];
    [requestDict setValue:courseID forKey:@"courseId"];
    
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

//    ZMMdlBbsVCtrl * bbsViewCtrl = [[ZMMdlBbsVCtrl alloc]init];
//    [self presentViewController:bbsViewCtrl animated:YES completion:NULL];

}

-(void)shijuan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden  = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M061" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)toupiao
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;

}

-(void)qiangda
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;
}

-(void)hezuo
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    ZMhezuoViewController *vc = [[ZMhezuoViewController alloc]init];
    [self presentViewController:vc animated:YES completion:NULL];
    
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    self.toupiaoBtn.hidden = YES;
    self.qiangdaBtn.hidden = YES;
    self.hezuoBtn.hidden = YES;

    self.panBtn.hidden = NO;
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];

}

#pragma mark SwipeViewDataSource methods
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return [_unitArray count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if (view == nil){
        view = [[[UIView alloc] initWithFrame:[swipeView bounds]] autorelease];
        
    }else{
        for(UIView* subVivew in [view subviews]){
            [subVivew removeFromSuperview];
        }
    }
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* articleUnitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [articleUnitDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [articleUnitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    [articleUnitDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    
    NSString* articleType = [unitDict valueForKey:@"articleType"];//模板id

    //NSLog(@"articleType : %@",articleType);
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role] ||
        (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
        
        
        if ([@"01" isEqualToString:articleType]) {
            ZMArticleViewController* viewController = [[ZMArticleViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"02" isEqualToString:articleType]){
            ZMArticleView01Controller* viewController = [[ZMArticleView01Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"03" isEqualToString:articleType]){
            ZMArticleView02Controller* viewController = [[ZMArticleView02Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"04" isEqualToString:articleType]){
            ZMArticleView03Controller* viewController = [[ZMArticleView03Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"05" isEqualToString:articleType]){
            ZMArticleView04Controller* viewController = [[ZMArticleView04Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"06" isEqualToString:articleType]){
            ZMArticleView05Controller* viewController = [[ZMArticleView05Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"07" isEqualToString:articleType]){
            ZMArticleView06Controller* viewController = [[ZMArticleView06Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"08" isEqualToString:articleType]){
            ZMArticleView07Controller* viewController = [[ZMArticleView07Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"09" isEqualToString:articleType]){
            ZMWriteGuideViewController* viewController = [[ZMWriteGuideViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([@"00" isEqualToString:articleType]){
            
            ZMCheckItemViewController* viewController = [[ZMCheckItemViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            //[viewController release];
            [view addSubview:viewController.view];
        }else if([articleType intValue] == 11){//7个模板 11－17分别对应7个模板
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCmpVCtrl * viewController = [[ZMMdlCmpVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        else if([articleType intValue] == 12){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlExplainVCtrl * viewController = [[ZMMdlExplainVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        else if([articleType intValue]== 13){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTopicVCtrl * viewController = [[ZMMdlTopicVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        else if([articleType intValue] == 14){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlSliderVCtrl * viewController = [[ZMMdlSliderVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [view addSubview:viewController.view];
            //[viewController release];
        }
        else if([articleType intValue] == 15){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlStoryVCtrl * viewController = [[ZMMdlStoryVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        else if([articleType intValue] == 16){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTravelVCtrl * viewController = [[ZMMdlTravelVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        else if([articleType intValue] == 17){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlConceptionVCtrl * viewController = [[ZMMdlConceptionVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            //[viewController release];
            [view addSubview:viewController.view];
        }
        
    }
    
    [articleUnitDict release];

    return view;
}

#pragma mark SwipeViewDelegate methods
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    
    _pageControl.currentPage = swipeView.currentPage;
    
    /*NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M013" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            
            NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
            [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            [requestDict setValue:@"03" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
    }*/
}




#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M012" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([@"M006" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
   
    }else if([@"M030" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        /*NSMutableDictionary * articleDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [articleDict setValue:[responseDict valueForKey:@"articleCellNumber"] forKey:@"articleCellNumber"];
        [articleDict setValue:[responseDict valueForKey:@"articleType"] forKey:@"articleType"];
        [articleDict setValue:[responseDict valueForKey:@"title"] forKey:@"title"];
        [articleDict setValue:[responseDict valueForKey:@"articleDraft"] forKey:@"articleDraft"];
        [articleDict setValue:[responseDict valueForKey:@"articleContents"] forKey:@"articleContents"];
        [articleDict setValue:[responseDict valueForKey:@"articleComment"] forKey:@"articleComment"];*/
    }else if ([@"M013" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if ([@"M014" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if([@"M008" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M025" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M026" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M031" isEqualToString:method] && [@"00" isEqualToString:responseCode]){

    }else if([@"M032" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M043" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }else if ([@"M061" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
                ZMShitiSwipeViewController * vc = [[ZMShitiSwipeViewController alloc] init];
//                [vc setDelegate:self];
                [vc setUnitArray:dataSource];
                [self presentViewController:vc animated:YES completion:NULL];
                        
        }else{
            
            [self showTip:@"没有内容！"];
            
        }

    }else if([@"M069" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            ZMZuoYeViewController * vc = [[ZMZuoYeViewController alloc] init];
            //                [vc setDelegate:self];
            vc.unitArray = dataSource;
            [self presentViewController:vc animated:YES completion:NULL];
            
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
    }else if ([@"M051" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
        if ([arr count] > 0) {
            ZMMdlBbsVCtrl * bbsViewCtrl = [[ZMMdlBbsVCtrl alloc]init];
            [self presentViewController:bbsViewCtrl animated:YES completion:NULL];
        }else{
            
            [self showTip:@"没有内容！"];
            
        }

    }
}



@end
