//
//  ZMtoupiaoViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMtoupiaoViewController.h"
#import "ZMtoupiaoTableViewCell.h"
#import "ZMtoupiaodetailViewController.h"

@implementation ZMtoupiaoViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.m112tmepArr = [[NSMutableArray alloc]init];
    self.view = view;
    self.number = 0;
    
   
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M113" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

    [self addObserver:self forKeyPath:@"number" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if ([keyPath isEqual:@"number"]) {
        NSLog(@"PageView课程被改变了");
        NSString *str1 = [NSString stringWithFormat:@"%@",[change objectForKey:@"new"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",[change objectForKey:@"old"]];

        if (![str1 isEqualToString:str2]) {
            [self loadM112];
        }
        NSLog(@"PageView新课程是:%@ 老课程是:%@", [change objectForKey:@"new"],[change objectForKey:@"old"]);
    }
}
-(void)loadSubView
{
    scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scro.pagingEnabled = YES;
    scro.delegate = self;
    scro.contentSize = CGSizeMake(self.view.frame.size.width*[self.m113Arr count], self.view.frame.size.height);
    [self.view addSubview:scro];

    int y = 0;
    int i = 0;
    for (NSDictionary *dic in self.m113Arr) {
        
        UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(y, 0, scro.frame.size.width, scro.frame.size.height)];
        [scro addSubview:backView];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, scro.frame.size.width/2 - 80, 30)];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.text = [NSString stringWithFormat:@"%@",dic[@"voteTitle"]];
        [backView addSubview:label];

        UITableView* se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, backView.frame.size.width, backView.frame.size.height - 200)];
        se4Tabv.delegate = self;
        se4Tabv.dataSource = self;
        se4Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        se4Tabv.tag = 100000 + i;
        [backView addSubview:se4Tabv];

        y += self.view.frame.size.width;
        i++;
    }
    
    searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height - 150, 60 ,30)];
    searchBtn.center = CGPointMake(self.view.center.x, searchBtn.center.y);
    [searchBtn setTitle:@"投票" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    searchBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(650, self.view.frame.size.height - 150, 120 ,30)];
    [searchBtn1 setTitle:@"查看投票结果" forState:UIControlStateNormal];
    [searchBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn1.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn1.layer.borderWidth = 1;
    searchBtn1.hidden = YES;
    [searchBtn1 addTarget:self action:@selector(commit1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn1];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
    _pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
    _pageControl.padding = 13.0f;
    _pageControl.orientation = PageControlOrientationLandscape;
    _pageControl.numberOfPages = [self.m113Arr count];
    [self.view addSubview:_pageControl];

    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];

    
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
    ZMqiangdaViewController *vc = [[ZMqiangdaViewController alloc]init];
    [self presentViewController:vc animated:YES completion:NULL];
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

-(void)commit1:(UIButton *)send
{
    ZMtoupiaodetailViewController *vc = [[ZMtoupiaodetailViewController alloc]init];
    vc.voteId = self.m113Arr[self.number][@"voteId"];
    [self presentViewController:vc animated:YES completion:NULL];
}

-(void)commit:(UIButton *)send
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M111" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.m113Arr[self.number][@"voteId"] forKey:@"voteId"];
    [requestDict setValue:self.m112tmepArr forKey:@"voteContent"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)loadM112
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M112" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.m113Arr[self.number][@"voteId"] forKey:@"voteId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, scro.frame.size.width, 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.m112Dic[@"groupNames"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    ZMtoupiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[ZMtoupiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    }
    
    cell.se3SelBtn.tag = 4444444 + self.number*100 + indexPath.row;
    [cell.se3SelBtn addTarget:self action:@selector(se4Sel:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[NSString stringWithFormat:@"%@",self.m112tmepArr[indexPath.row][@"flag"]] isEqualToString:@"1"]) {
        [cell.se3SelBtn setSelected:YES];
    }else{
        [cell.se3SelBtn setSelected:NO];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.m112Dic[@"groupNames"][indexPath.row][@"optionName"]];
    return cell;
}

-(void)se4Sel:(UIButton *)send
{
    if ([[NSString stringWithFormat:@"%@",self.m112Dic[@"ifVote"]] isEqualToString:@"1"]) {
        return;
    }
    int tag = send.tag;
    NSLog(@"hhhhhhh%d",tag);
    
    
    int count = tag - 4444444 - self.number*100;
    
    NSMutableDictionary *dic = self.m112tmepArr[count];
    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]) {
        [dic setValue:@"0" forKey:@"flag"];
    }else {
        [dic setValue:@"1" forKey:@"flag"];
    }
    
    UITableView *tabv = [self.view viewWithTag: 100000 + self.number];
    [tabv reloadData];
    
    NSLog(@"nnnnnnn%@",self.m112tmepArr);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == scro) {
        CGFloat width = scro.frame.size.width;
        NSUInteger currentPage = floor((scro.contentOffset.x - width / 2) / width) + 1;
        _pageControl.currentPage = currentPage;
        self.number = currentPage;
    }
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M113" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];

        self.m113Arr = responseDict[@"votes"];
        [self loadSubView];
        [self loadM112];
        NSLog(@"self.m113Arr====%@",self.m113Arr);
        
        searchBtn1.hidden = NO;

    }else if (([@"M112" isEqualToString:method] && [@"00" isEqualToString:responseCode]) ){
        [self hideIndicator];

        self.m112Dic = responseDict;
        NSLog(@"self.m112Dic====%@",self.m112Dic);
        UITableView *tabv = [self.view viewWithTag: 100000 + self.number];
        [tabv reloadData];
        
        
        if ([[NSString stringWithFormat:@"%@",self.m112Dic[@"ifVote"]] isEqualToString:@"1"]) {
            [searchBtn setTitle:@"已投票" forState:UIControlStateNormal];
            searchBtn.enabled = NO;
        }else{
            [searchBtn setTitle:@"投票" forState:UIControlStateNormal];
            searchBtn.enabled = YES;
        }
        
        [self.m112tmepArr removeAllObjects];
        
        NSMutableArray *arr = self.m112Dic[@"groupNames"];
        for (NSMutableDictionary *dic in arr) {
            NSString *groupId = dic[@"optionId"];
            NSString *ifSelect = dic[@"ifSelect"];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag", nil];
            [self.m112tmepArr addObject:mDic];
        }
        
        NSLog(@"self.m112tmepArr===%@",self.m112tmepArr);
    }else if (([@"M111" isEqualToString:method] && [@"00" isEqualToString:responseCode])){
        [self hideIndicator];
        [self showTip:@"投票成功"];
//        [self performSelector:@selector(next) withObject:self afterDelay:2];

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

}

-(void)next
{
    ZMtoupiaodetailViewController *vc = [[ZMtoupiaodetailViewController alloc]init];
    vc.voteId = self.m113Arr[self.number][@"voteId"];
    [self presentViewController:vc animated:YES completion:NULL];

}

-(void)closeClick
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:100];
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == 100) {
            //            [self.delegate ZMGousiSwipeViewDidClose:self];
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }
    }
}

@end
