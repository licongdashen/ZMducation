/*
 description : 我的构思
 create time : 20131026
 */

#import "ZMShitiSwipeViewController.h"
#import "ZMMdlShitiVCtrl.h"
#import "ZMMdlBbsVCtrl.h"

#import "ZMZuoYeViewController.h"

#define kTagCloseGousiBtn 20131123

@implementation ZMShitiSwipeViewController

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

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == kTagCloseGousiBtn) {
            //            [self.delegate ZMGousiSwipeViewDidClose:self];
            [self dismissViewControllerAnimated:YES completion:^{
                
                            
            }];
        }
    }
}

-(IBAction)closeClick:(id)sender
{

//    [self.delegate ZMShitiSwipeViewDidClose:self];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCloseGousiBtn];
    [alert show];
    [alert release];

}


-(void)loadView{
    [super loadView];
    
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
    [self.gousiBtn setTitle:@"构思图标" forState:UIControlStateNormal];
    [self.gousiBtn addTarget:self action:@selector(gousi) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gousiBtn];
    self.gousiBtn.hidden = YES;
    
    self.zuoyeBtn = [[UIButton alloc]init];
    self.zuoyeBtn.backgroundColor = [UIColor grayColor];
    [self.zuoyeBtn setTitle:@"作业" forState:UIControlStateNormal];
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
    [self.shijuanBtn setTitle:@"试卷" forState:UIControlStateNormal];
    [self.shijuanBtn addTarget:self action:@selector(shijuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shijuanBtn];
    self.shijuanBtn.hidden = YES;
    
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
    
    self.gousiBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y - 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.zuoyeBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y + 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.luntanBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.shijuanBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    
    self.panBtn.hidden = YES;
    
}

-(void)gousi
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    [[ZMAppDelegate App].userDict setValue:@"02" forKey:@"currentModuleId"];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M044" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(void)zuoye
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
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

}

-(void)shijuan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
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
    NSMutableDictionary* shitiUnitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    [shitiUnitDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    ZMMdlShitiVCtrl* viewController = [[ZMMdlShitiVCtrl alloc] init];
    [viewController setUnitDict:shitiUnitDict];
    
    [view addSubview:viewController.view];

    
    return view;
}

#pragma mark SwipeViewDelegate methods
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    
    _pageControl.currentPage = swipeView.currentPage;
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

    }else if ([@"M013" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if ([@"M014" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if([@"M008" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M025" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M026" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M031" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M032" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M043" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if ([@"M044" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    { //获取构思列表
        
        //NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSourceArr = [[NSMutableArray alloc]init];
        if ([dataSource count] > 0) {
            
                for (NSDictionary * item in dataSource) {
                    NSDictionary * _item = [[NSDictionary alloc]initWithObjectsAndKeys:
                                            [item valueForKey:@"designTitle"],@"unitTitle",
                                            [item valueForKey:@"designBrief"],@"unitBrief",
                                            [item valueForKey:@"articleType"],@"articleType",
                                            [item valueForKey:@"designId"],@"unitId",
                                            @"04",@"unitType",
                                            nil];
                    [dataSourceArr addObject:_item];
                }
                
                ZMGousiSwipeViewController * vc = [[ZMGousiSwipeViewController alloc] init];
//                [vc setDelegate:self];
                [vc setUnitArray:dataSourceArr];
                [self presentViewController:vc animated:YES completion:NULL];
                [vc release];
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }
    else if([@"M069" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
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
    
    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}






@end
