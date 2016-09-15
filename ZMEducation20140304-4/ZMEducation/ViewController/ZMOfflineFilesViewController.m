//
//  ZMOfflineFilesViewController.m
//  ZMEducation
//
//  Created by wangdan on 15-2-7.
//  Copyright (c) 2015年 99Bill. All rights reserved.
//

#import "ZMOfflineFilesViewController.h"
#import "ZMHomeViewController.h"


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

    self.downArray = [[NSMutableArray alloc] initWithCapacity:10];

    self.currentDownloadArray = [[NSMutableArray alloc]initWithCapacity:20];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey:@"hasDownloadedDictArray1"]) {
        
        [userDefaults setValue:self.hasDownloadedDictArray forKey:@"hasDownloadedDictArray1"];
    }
    self.hasDownloadedDictArray = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"hasDownloadedDictArray1"]];
    
    NSLog(@"wori%@",self.hasDownloadedDictArray);
    
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
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
    ASINetworkQueue *que = [[ASINetworkQueue alloc] init];
    self.netWorkQueue = que;
    [que release];
    [self.netWorkQueue reset];
    [self.netWorkQueue setShowAccurateProgress:NO];

}

-(IBAction)deleteClick:(id)sender{
    
    UIButton* enterButton = (UIButton*)sender;
    int index = enterButton.tag;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    

    for (NSDictionary *dic in self.hasDownloadedDictArray) {
        if ([dic[@"course"] isEqualToString:_fileArray[index][@"course"]]) {
            [self deleteFileAtPath:[dic valueForKey:@"files"]];
            [self.hasDownloadedDictArray removeObject:dic];
            break;
        }
    }
    
    if ([_fileArray count]>0) {
        [userDefaults setValue:self.hasDownloadedDictArray forKey:@"hasDownloadedDictArray1"];
    }else{
        [userDefaults setObject:nil forKey:@"hasDownloadedDictArray1"];
    }
    NSLog(@"删除后的下载列表：%@",[userDefaults objectForKey:@"hasDownloadedDictArray1"]);
    
    [self showTip:@"删除成功！"];
 
    [fileView reloadData];
    [userDefaults synchronize];


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

-(IBAction)enterClick1:(id)sender{
    
    enterButton = (UIButton*)sender;
    index = enterButton.tag;
    
//    ZMOfflineSwipeViewController* swipeView = [[ZMOfflineSwipeViewController alloc] init];
//    swipeView.unitArray = _fileArray[index][@"filesinfo"];
//    //    [swipeView setUnitArray:[[_fileArray objectAtIndex:index] objectForKey:@"files"]];
//    [self.navigationController pushViewController:swipeView animated:YES];
//    [swipeView release];
    

    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M102" forKey:@"method"];
    [requestDict setValue:self.dic[@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:_fileArray[index][@"courseId"] forKey:@"courseId"];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

    [self showTip:@"下载中"];
    enterButton.userInteractionEnabled = NO;
    
}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if([@"M003" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M101" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        self.fileArray = responseDict[@"courses"];
        [fileView reloadData];
        
        NSLog(@"self.fileArray===%@",self.fileArray);

    }else if([@"M102" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        self.downArray = responseDict[@"units"];
        [self request1];
        NSLog(@"self.downArray===%@",self.downArray);

    }else if([@"M005" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSArray* _moduleArray = [responseDict valueForKey:@"modules"];
        //打印构思模块
        for (int i=0; i<[_moduleArray count]; i++) {
            NSLog(@"module:%@",[_moduleArray objectAtIndex:i]);
        }
        
        ZMHomeViewController* homeView = [[ZMHomeViewController alloc] init];
        [homeView setModuleArray:_moduleArray];
        
        [self.navigationController pushViewController:homeView animated:YES];
        [homeView release];
    }
    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}


-(void)request1
{
    if (self.currentDownloadLength > 0) {
        //NSLog(@"还有文件没有下载完成");
        return;
    }else{
        self.currentDownloadLength = [self.downArray count];
        
        //初始化Documents路径
        NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //初始化临时文件路径
        NSString *tempFolderPath = [docPath stringByAppendingPathComponent:@"temp"];
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //判断temp文件夹是否存在
        BOOL fileExists = [fileManager fileExistsAtPath:tempFolderPath];
        if (!fileExists) {//如果不存在则创建,因为下载时,不会自动创建文件夹
            [fileManager createDirectoryAtPath:tempFolderPath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
        
        //发送下载请求
        for (NSDictionary * pdfDict in self.downArray) {
            
            NSLog(@"pdf info : %@",pdfDict);
            
            
            NSString* unitURL = [[[pdfDict valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
            
            NSString * pdfID = [[unitURL componentsSeparatedByString:@"."] firstObject];
            //NSString *filePath = [userDocPath stringByAppendingPathComponent:unitURL];
            NSString *tempFilePath = [tempFolderPath stringByAppendingPathComponent:unitURL];
            
            
            //NSString *filePath = [[self.downloadArray objectAtIndex:index] objectForKey:@"URL"];
            NSLog(@"tempFilePath=%@",tempFilePath);
            //初始下载路径
            //NSURL *url = [NSURL URLWithString:filePath];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHttpRequestURL,[pdfDict valueForKey:@"unitURL"]]];
            //设置下载路径
            self.request = [[ASIHTTPRequest alloc] initWithURL:url];
            //设置ASIHTTPRequest代理
            self.request.delegate = self;
            //初始化保存ZIP文件路径
            NSString *savePath = [docPath stringByAppendingPathComponent:unitURL];
            //初始化临时文件路径
            NSString *tempPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/%@.temp",unitURL]];
            //设置文件保存路径
            [self.request setDownloadDestinationPath:savePath];
            //设置临时文件路径
            [self.request setTemporaryFileDownloadPath:tempPath];
            //设置进度条的代理,
            //            [request setDownloadProgressDelegate:progressView];
            //设置是是否支持断点下载
            [self.request setAllowResumeForFileDownloads:YES];
            //设置基本信息
            [self.request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:pdfID,@"pdfID",nil]];
            NSLog(@"UserInfo=%@",self.request.userInfo);
            //添加到ASINetworkQueue队列去下载
            [self.netWorkQueue addOperation:self.request];
            //收回request
            //                [self.request release];
            
            [self.netWorkQueue go];
            [self.currentDownloadArray addObject:savePath];
            
        }
        
        
    }
    
}

#pragma mark ASIHTTPRequestDelegate method
//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小，可以显示下载进度多少字节
-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    
    
    NSLog(@"contentlength=%f",request.contentLength/1024.0/1024.0);
    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]] floatValue];
    NSLog(@"tempConLen=%f",tempConLen);
    //如果没有保存,则持久化他的内容大小
    if (tempConLen == 0 ) {//如果没有保存,则持久化他的内容大小
        [userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]];
    }
}

-(void) requestFinished:(ASIHTTPRequest *)request{
    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
    
    self.currentDownloadLength--;
    
    NSLog(@"%@.pdf has been downloaded!",pdfID);
    NSLog(@"还有%d文件没有下载完成",self.currentDownloadLength);
    
    if (self.currentDownloadLength == 0) {
        //将当前选择的年级和课程加入userDefault中
        
        //currentDownloadLength = [fileArray count];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        self.hasDownloadedDictArray = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"hasDownloadedDictArray1"]];
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMdd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        NSDictionary * currentGradeAndCourse = [[NSDictionary alloc]initWithObjectsAndKeys:_fileArray[index][@"lastUpdateTime"],@"lastUpdateTime",self.dic[@"currentGradeId"],@"grade",
                                                _fileArray[index][@"course"],@"course",self.currentDownloadArray,@"files",self.downArray,@"filesinfo",_fileArray[index][@"courseId"],@"courseId",nil];
        for (NSDictionary *dic in self.hasDownloadedDictArray) {
            if ([dic[@"course"] isEqualToString:currentGradeAndCourse[@"course"]]) {
                [self.hasDownloadedDictArray removeObject:dic];
                break;
            }
        }
        
        [self.hasDownloadedDictArray addObject:currentGradeAndCourse];
        [userDefaults setValue:self.hasDownloadedDictArray forKey:@"hasDownloadedDictArray1"];
        
        NSLog(@"%@",[userDefaults objectForKey:@"hasDownloadedDictArray1"]);
        
        [self showTip:@"下载完成"];

        enterButton.userInteractionEnabled = YES;
        
        [fileView reloadData];

    }
    
}

-(void)enterClick:(UIButton *)sender
{
    
    UIButton* enterButton1 = (UIButton*)sender;
    index1 = enterButton1.tag;
    
    for (NSDictionary *dic in self.hasDownloadedDictArray) {
        if (self.dic[@"currentCourseId"] == dic[@"courseId"]) {
            if (self.dic[@"currentCourseId"] == _fileArray[index1][@"courseId"]) {
                NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                
                //NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
                [requestDict setValue:@"M005" forKey:@"method"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
                
                ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).isdownfinsh = YES;
            }
        }
    }
    
    
}

-(void)enterClick2:(UIButton *)sender
{
    
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
        
        UIButton* enterButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [enterButton3 setTag:index];
        [enterButton3 setFrame:CGRectMake(410, 20, 60, 20)];
        [enterButton3 addTarget:self action:@selector(enterClick2:)
               forControlEvents:UIControlEventTouchUpInside];
        [enterButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [enterButton3 setTitle:@"未下载" forState:UIControlStateNormal];
        [view addSubview:enterButton3];


        if ([self.hasDownloadedDictArray count] > 0) {
            for (NSDictionary *dic in self.hasDownloadedDictArray) {
                if (dic[@"courseId"] == fileDic[@"courseId"]) {
                    if (fileDic[@"lastUpdateTime"] > dic[@"lastUpdateTime"]) {
                        [enterButton3 setTitle:@"已更新" forState:UIControlStateNormal];
                    }else{
                        [enterButton3 setTitle:@"已下载" forState:UIControlStateNormal];

                    }
                }
            }
        }else {
            [enterButton3 setTitle:@"未下载" forState:UIControlStateNormal];

        }
        
        UIButton* enterButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [enterButton2 setTag:index];
        [enterButton2 setFrame:CGRectMake(510, 20, 80, 20)];
        [enterButton2 addTarget:self action:@selector(enterClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [enterButton2 setTitle:@"进入课程" forState:UIControlStateNormal];
        [enterButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:enterButton2];
        
        UIButton* enterButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [enterButton1 setTag:index];
        [enterButton1 setFrame:CGRectMake(630, 20, 60, 20)];

        [enterButton1 setTitle:@"下载" forState:UIControlStateNormal];
        [enterButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [enterButton1 addTarget:self action:@selector(enterClick1:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:enterButton1];
        
        if ([self.hasDownloadedDictArray count] > 0) {
            for (NSDictionary *dic in self.hasDownloadedDictArray) {
                if (dic[@"courseId"] == fileDic[@"courseId"]) {
                    if (fileDic[@"lastUpdateTime"] > dic[@"lastUpdateTime"]) {
                        enterButton1.userInteractionEnabled = YES;
                    }else{
                        enterButton1.userInteractionEnabled = NO;
                    }
                }
            }
        }else {
            enterButton1.userInteractionEnabled = YES;
            
        }

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
