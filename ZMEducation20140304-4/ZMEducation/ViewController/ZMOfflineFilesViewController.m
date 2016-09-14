//
//  ZMOfflineFilesViewController.m
//  ZMEducation
//
//  Created by wangdan on 15-2-7.
//  Copyright (c) 2015年 99Bill. All rights reserved.
//

#import "ZMOfflineFilesViewController.h"


//#import "ZMOffLineSixModelViewController.h"

//#import "ZMOfflineSwipeViewController.h"

@implementation ZMOfflineFilesViewController

@synthesize fileArray = _fileArray;

-(void)dealloc{
    
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    
    CGRect bgFrame = CGRectMake(0, 0, 1024, 768);
    UIImage* bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_bg" ofType:@"png"]];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:bgFrame];
    [bgView setImage:bgImage];
    [self.view insertSubview:bgView atIndex:0];
    [bgView release];
    
    CGRect bg_files_frame = CGRectMake(83, 180, 858, 490);
    UIImage* bg_files = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_offlineFiles" ofType:@"png"]];
    UIImageView* bg_files_view = [[UIImageView alloc] initWithFrame:bg_files_frame];
    [bg_files_view setImage:bg_files];
    [self.view addSubview:bg_files_view ];
    [bg_files_view release];
    
    UIImage* gradeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"grade" ofType:@"png"]];
    UIImageView* gradeView = [[UIImageView alloc] initWithFrame:CGRectMake(163, 245, 38, 17)];
    [gradeView setImage:gradeImage];
    [self.view addSubview:gradeView];
    [gradeView release];
    
    UIImage* courseImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cursorText" ofType:@"png"]];
    UIImageView* courseView = [[UIImageView alloc] initWithFrame:CGRectMake(385, 245, 38, 17)];
    [courseView setImage:courseImage];
    [self.view addSubview:courseView];
    [courseView release];

    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];

//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    for (NSDictionary *dic in _fileArray) {
//        NSString *str = dic[@"courseSort"];
//        [arr addObject:str];
//    }
//    
//    
//    NSArray *_sortedArray= [arr sortedArrayUsingSelector:@selector(compare:)];
//    
//    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
//    for (NSString *str in _sortedArray) {
//        
//        for (NSDictionary *dic in _fileArray) {
//            if ([str isEqualToString:dic[@"courseSort"]]) {
//                [arr1 addObject:dic];
//            }
//        }
//    }
//    
//    _fileArray = arr1;

    fileView = [[JTListView alloc] initWithFrame:CGRectMake(120 ,280,800,350)
                                           layout:JTListViewLayoutTopToBottom];
    [fileView setDataSource:self];
    [fileView setDelegate:self];
    //[gradeView setScrollEnabled:NO];
    [fileView setGapBetweenItems:10.0f];
    [fileView reloadData];

    [self.view addSubview:fileView];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M101" forKey:@"method"];
    [requestDict setValue:self.dic[@"currentGradeId"] forKey:@"gradeId"];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* deviceTokenStr = [userDefaults valueForKey:kDeviceTokenStringKEY];
    //NSString * deviceTokenStr = @"1c0765d62f18470033bfc107d2a49dca922c52d44c0cf52cef9c5ca78a6c9b98";
    [requestDict setValue:deviceTokenStr forKey:@"deviceToken"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(IBAction)deleteClick:(id)sender{
    
    UIButton* enterButton = (UIButton*)sender;
    int index = enterButton.tag;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"downloadInfo"]];
    
    for (NSDictionary *dic in arr) {
        if ([dic[@"course"] isEqualToString:[_fileArray objectAtIndex:index][@"course"]]) {
            [arr removeObject:dic];
            break;
        }
        
    }
    
    [userDefaults setValue:arr forKey:@"downloadInfo"];
    [userDefaults synchronize];

    //filename
    [self deleteFileAtPath:[[_fileArray objectAtIndex:index ] valueForKey:@"files"]];
    [_fileArray removeObjectAtIndex:index];
    if ([_fileArray count]>0) {
        [userDefaults setObject:_fileArray forKey:@"hasDownloadedDictArray"];
    }else{
        [userDefaults setObject:nil forKey:@"hasDownloadedDictArray"];
    }
    NSLog(@"删除后的下载列表：%@",[userDefaults objectForKey:@"hasDownloadedDictArray"]);
    
    [self showTip:@"删除成功！"];
 
    [fileView reloadData];

}

- (BOOL)deleteFileAtPath:(NSArray *)files {
    
    BOOL res = true;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *str in files) {
        str = [[str componentsSeparatedByString:@"."] firstObject];
        [array addObject:str];
    }
    
    for (NSString * file in array) {
        
        NSError *error;
        
        
        if ([fileManager removeItemAtPath:file error:&error] != YES){
            
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
            res = false;
        }
    }
    
    return res;
    
    
    
    
}

//-(IBAction)enterClick:(id)sender{
//    
//    UIButton* enterButton = (UIButton*)sender;
//    int index = enterButton.tag;
//    
//    ZMOffLineSixModelViewController* swipeView = [[ZMOffLineSixModelViewController alloc] init];
//    swipeView.infoDic = _fileArray[index];
////    [swipeView setUnitArray:[[_fileArray objectAtIndex:index] objectForKey:@"files"]];
//    [self.navigationController pushViewController:swipeView animated:YES];
//    [swipeView release];
//    
//    
//}

//-(IBAction)enterClick1:(id)sender{
//    
//    UIButton* enterButton = (UIButton*)sender;
//    int index = enterButton.tag;
//    
//    ZMOfflineSwipeViewController* swipeView = [[ZMOfflineSwipeViewController alloc] init];
//    swipeView.unitArray = _fileArray[index][@"filesinfo"];
//    //    [swipeView setUnitArray:[[_fileArray objectAtIndex:index] objectForKey:@"files"]];
//    [self.navigationController pushViewController:swipeView animated:YES];
//    [swipeView release];
//    
//    
//}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if([@"M003" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M101" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        self.fileArray = responseDict[@"courses"];
        [fileView reloadData];

    }
    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}


#pragma mark - JTListViewDataSource
- (NSUInteger)numberOfItemsInListView:(JTListView *)listView{
    if (listView == fileView) {
        return [_fileArray count];
    }
    return 0;
}

- (UIView *)listView:(JTListView *)listView viewForItemAtIndex:(NSUInteger)index{
    UIView *view = [listView dequeueReusableView];
    for(UIView* subView in [view subviews]){
        [subView removeFromSuperview];
    }
    
    if (!view) {
        view = [[[UIView alloc] init] autorelease];
    }
    
    if (listView == fileView) {
        
        NSDictionary* fileDic = [_fileArray objectAtIndex:index];
        
//        UILabel * grade = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
//        grade.text = [fileDic valueForKey:@"grade"];
//        grade.textAlignment = UITextAlignmentCenter;
//        grade.backgroundColor = [UIColor clearColor];
//        [view addSubview:grade];
        
        UILabel * file = [[UILabel alloc]initWithFrame:CGRectMake(190, 0, 450, 50)];
        file.text = [NSString stringWithFormat:@"第%@单元:%@",[fileDic valueForKey:@"sort"],[fileDic valueForKey:@"course"]];
        file.backgroundColor = [UIColor clearColor];
        [view addSubview:file];
        
        UIImageView * border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 783, 2)];
        border.image = [UIImage imageNamed:@"border.png"];
        [view addSubview:border];
        
        UIButton* enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [enterButton setTag:index];
        [enterButton setFrame:CGRectMake(630, 20, 60, 20)];
        [enterButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"icon_model" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [enterButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"icon_model" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [enterButton addTarget:self action:@selector(enterClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:enterButton];
        
        UIButton* enterButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [enterButton1 setTag:index];
        [enterButton1 setFrame:CGRectMake(530, 20, 60, 20)];
        [enterButton1 setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"icon_line" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [enterButton1 setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"icon_line" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [enterButton1 addTarget:self action:@selector(enterClick1:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:enterButton1];
        
        UIButton* deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setTag:index];
        [deleteButton setFrame:CGRectMake(730, 20, 41, 20)];
        [deleteButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"deleteBtn" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"deleteBtn" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteButton];
        
        
        
    }
    
    
    return view;
}


#pragma mark - JTListViewDelegate
- (void)listView:(JTListView *)listView willDisplayView:(UIView *)view forItemAtIndex:(NSUInteger)index{
}

- (CGFloat)listView:(JTListView *)listView widthForItemAtIndex:(NSUInteger)index{
    return 214;
}

- (CGFloat)listView:(JTListView *)listView heightForItemAtIndex:(NSUInteger)index{
    return 50;
}



#pragma mark ReaderViewControllerDelegate
-(void)didEndReaderViewController:(ReaderViewController*)viewController{
    
}

-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
        
    [viewController dismissViewControllerAnimated:YES completion:NULL];
}



@end
