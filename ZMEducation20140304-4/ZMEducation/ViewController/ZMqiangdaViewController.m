//
//  ZMqiangdaViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMqiangdaViewController.h"

@implementation ZMqiangdaViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    
    self.view = view;
    self.number = 0;

    isHidden = YES;
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 150, 50)];
    lable.text = @"请选择抢答题目:";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:lable];
    
    UIButton* se3TitleBtn = [[UIButton alloc]initWithFrame:CGRectMake(lable.frame.origin.x + lable.frame.size.width + 50, 60, self.view.frame.size.width/2 - 50, 30)];
    [se3TitleBtn setBackgroundImage:[UIImage imageNamed:@"Work_Browse_Button_01"] forState:UIControlStateNormal];
    [se3TitleBtn addTarget:self action:@selector(se3sel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:se3TitleBtn];
    
    se3TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width/2 - 100, 30)];
    se3TitleLb.font = [UIFont boldSystemFontOfSize:20];
    [se3TitleBtn addSubview:se3TitleLb];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(se3TitleBtn.frame.origin.x + se3TitleBtn.frame.size.width + 30, 60, 40, 30)];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    [self loadSubView];
    
    tabv = [[UITableView alloc]initWithFrame:CGRectMake(lable.frame.origin.x + lable.frame.size.width + 50, se3TitleBtn.frame.origin.y + se3TitleBtn.frame.size.height, self.view.frame.size.width/2 - 50, 300)];
    tabv.delegate = self;
    tabv.dataSource = self;
    tabv.backgroundColor = [UIColor whiteColor];
    tabv.hidden = YES;
    [self.view addSubview:tabv];
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M116" forKey:@"method"];
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
    
    ZMtoupiaoViewController *vc = [[ZMtoupiaoViewController alloc]init];
    [self presentViewController:vc animated:YES completion:NULL];
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
//    ZMqiangdaViewController *vc = [[ZMqiangdaViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:NULL];
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

-(void)loadSubView
{
    scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
    scro.pagingEnabled = YES;
    scro.delegate = self;
    [self.view addSubview:scro];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    
    [self.view addSubview:_pageControl];

}

-(void)loadM115View
{
    for (UIView *view in [scro subviews]) {
        [view removeFromSuperview];
    }
    int y = 0;
    int i = 0;
    for (NSDictionary *dic in self.m115Arr) {
        
        UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(y, 0, scro.frame.size.width, scro.frame.size.height)];
        [scro addSubview:backView];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, scro.frame.size.width/2 - 80, 30)];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.text = [NSString stringWithFormat:@"抢答题目:        %@",dic[@"raceTitle"]];
        [backView addSubview:label];
        
        UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width + 20, 50, 60, 30)];
        if ([[NSString stringWithFormat:@"%@",dic[@"ifRace"]] isEqualToString:@"1"]) {
            [searchBtn setTitle:@"已抢答" forState:UIControlStateNormal];
            searchBtn.enabled = NO;
        }else {
            [searchBtn setTitle:@"抢答" forState:UIControlStateNormal];
            searchBtn.enabled = YES;
        }
        [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
        searchBtn.layer.borderWidth = 1;
        [searchBtn addTarget:self action:@selector(qiangda:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:searchBtn];

        UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 120, scro.frame.size.width - 100, 30)];
        label1.font = [UIFont boldSystemFontOfSize:20];
        label1.text = [NSString stringWithFormat:@"以抢答同学:        %@",dic[@"raceUsers"]];
        [backView addSubview:label1];

        UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 190, scro.frame.size.width - 100, 30)];
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.text = [NSString stringWithFormat:@"未抢答同学:        %@",dic[@"noRaceUsers"]];
        [backView addSubview:label2];
        
        y += self.view.frame.size.width;
        i++;
    }

}

-(void)qiangda:(UIButton *)send
{
    [send setTitle:@"已抢答" forState:UIControlStateNormal];
    send.enabled = NO;

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M114" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.m115Arr[self.number][@"raceId"] forKey:@"raceId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == scro) {
        CGFloat width = scro.frame.size.width;
        NSUInteger currentPage = floor((scro.contentOffset.x - width / 2) / width) + 1;
        _pageControl.currentPage = currentPage;
        self.number = currentPage;
//        [self loadM122];
//        [self loadM124];
//        [self loadM126];
//        [self loadM125a];
    }
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
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, tabv.frame.size.width, 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.m116dic[@"races"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

    cell.textLabel.text = self.m116dic[@"races"][indexPath.row][@"raceTitle"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    se3TitleLb.text = self.m116dic[@"races"][indexPath.row][@"raceTitle"];
    raceId = self.m116dic[@"races"][indexPath.row][@"raceId"];
    tabv.hidden = YES;
    isHidden = YES;
}

-(void)search:(UIButton *)send
{
    [self loadM115];
    tabv.hidden = YES;
}

-(void)loadM115
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M115" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:raceId forKey:@"raceId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)se3sel:(UIButton *)send
{
    if (isHidden == YES) {
        tabv.hidden = NO;
        isHidden = NO;
    }else {
        tabv.hidden = YES;
        isHidden = YES;
    }
}

-(void)loadM116SubView;
{
    se3TitleLb.text = self.m116dic[@"races"][0][@"raceTitle"];
    raceId = self.m116dic[@"races"][0][@"raceId"];
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M116" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.m116dic = responseDict;
        [self loadM116SubView];
        [tabv reloadData];
        NSLog(@"self.m116dic====%@",self.m116dic);
    }else if ([@"M115" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.m115Arr = responseDict[@"races"];
        NSLog(@"self.m115dic====%@",self.m115Arr);

        scro.contentSize = CGSizeMake(self.view.frame.size.width*[self.m115Arr count], self.view.frame.size.height - 200);
        _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
        _pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
        _pageControl.padding = 13.0f;
        _pageControl.orientation = PageControlOrientationLandscape;
        _pageControl.numberOfPages = [self.m115Arr count];
        
        [self loadM115View];
    }else if ([@"M114" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"抢答成功"];
        [self loadM115];
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
