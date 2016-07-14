/*
 description : 试题浏览
 create time : 20131026
 */

#import "ZMShitiBrowseViewController.h"
#import "shitiBrowseVCtrl.h"



@implementation ZMShitiBrowseViewController

@synthesize unitArray = _unitArray;
@synthesize swipeView = _swipeView;

-(void)dealloc{
    [_swipeView setDataSource:nil];
    [_swipeView setDelegate:nil];
    [_swipeView release];
    [_pageControl release];
    [_unitArray release];
    
    [super dealloc];
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
    view.tag = 2;
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* shitiUnitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [shitiUnitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    [shitiUnitDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    shitiBrowseVCtrl* viewController = [[shitiBrowseVCtrl alloc] init];
    [viewController setUnitDict:shitiUnitDict];
    
    [view addSubview:viewController.view];
    //[viewController release];

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
        
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}






@end
