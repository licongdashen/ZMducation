//
//  ZMhezuoViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMhezuoViewController.h"
#import "ZMhezuoTableViewCell.h"
#import "ZMhezuo1TableViewCell.h"
@implementation ZMhezuoViewController
-(void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"youyou" object:nil];
}

-(void)notifa
{
    UITableView *tabv = [self.view viewWithTag: 3333333 + self.number];
    [tabv reloadData];
    NSLog(@"nnnnnnn%@",self.M125AtempArr);

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.M124tempArr = [[NSMutableArray alloc]init];
    self.M125tempArr = [[NSMutableArray alloc]init];
    self.M125AtempArr = [[NSMutableArray alloc]init];
    self.wengaoArr = [[NSMutableArray alloc]init];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    
    self.view = view;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notifa) name:@"youyou" object:nil];
    
    isHidden = YES;
    
    self.number = 0;
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M121" forKey:@"method"];
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

    [self loadM124];
    [self loadM126];
    [self loadM125a];
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

-(void)loadSubViews
{
    self.scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scro.contentSize = CGSizeMake(self.view.frame.size.width*[self.hezuoArr count], self.view.frame.size.height);
    self.scro.pagingEnabled = YES;
    self.scro.delegate = self;
    [self.view addSubview:self.scro];

    int y = 0;
    int i = 0;
    for (NSDictionary *dic in self.hezuoArr) {
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(y, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.backView.tag = 999 + i;
        [self.scro addSubview:self.backView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 50)];
        lable.text = dic[@"forumTitle"];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont boldSystemFontOfSize:25];
        [self.backView addSubview:lable];
        
        NSArray *arr = @[@"合作内容填写",@"合作小组浏览",@"合作分项浏览",@"合作文稿生成"];
        segment = [[UISegmentedControl alloc]initWithItems:arr];
        segment.frame = CGRectMake(50, 120, 500, 40);
        segment.selectedSegmentIndex = 0;
        segment.tag = 9999 + i;
        [self.backView addSubview:segment];
        [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        backview1 = [[UIView alloc]initWithFrame:CGRectMake(50, 170, self.view.frame.size.width - 100, self.view.frame.size.height - 170)];
        backview1.hidden = NO;
        backview1.tag = 99999 + i;
        [self.backView addSubview:backview1];
        
        backview2 = [[UIView alloc]initWithFrame:CGRectMake(50, 170, self.view.frame.size.width - 100, self.view.frame.size.height - 170)];
        backview2.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        backview2.hidden = YES;
        backview2.tag = 999999 + i;
        [self.backView addSubview:backview2];
        
        backview3 = [[UIView alloc]initWithFrame:CGRectMake(50, 170, self.view.frame.size.width - 100, self.view.frame.size.height - 170)];
        backview3.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        backview3.hidden = YES;
        backview3.tag = 9999999 + i;
        [self.backView addSubview:backview3];
        
        backview4 = [[UIView alloc]initWithFrame:CGRectMake(50, 170, self.view.frame.size.width - 100, self.view.frame.size.height - 170)];
        backview4.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        backview4.hidden = YES;
        backview4.tag = 99999999 + i;
        [self.backView addSubview:backview4];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        titleLb.text = @"主题:";
        titleLb.font = [UIFont boldSystemFontOfSize:20];
        [backview1 addSubview:titleLb];
        
        titeleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, backview1.frame.size.width - 60, 30)];
        titeleLb1.font = [UIFont boldSystemFontOfSize:20];
        titeleLb1.tag = -999 + i;
        [backview1 addSubview:titeleLb1];
        
        UILabel *subtitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 50, 30)];
        subtitleLb.text = @"分项:";
        subtitleLb.font = [UIFont boldSystemFontOfSize:20];
        [backview1 addSubview:subtitleLb];
        
        subtitleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, backview1.frame.size.width - 60, 30)];
        subtitleLb1.font = [UIFont boldSystemFontOfSize:20];
        subtitleLb1.tag = -9999 + i;
        [backview1 addSubview:subtitleLb1];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 50, 30)];
        contentLb.text = @"内容";
        contentLb.font = [UIFont boldSystemFontOfSize:20];
        [backview1 addSubview:contentLb];
        
        refishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 170, 40, 30)];
        [refishBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [refishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [refishBtn addTarget:self action:@selector(refish) forControlEvents:UIControlEventTouchUpInside];
        refishBtn.layer.borderColor = [UIColor blackColor].CGColor;
        refishBtn.layer.borderWidth = 1;
        [backview1 addSubview:refishBtn];
        
        contentTv = [[UITextView alloc]initWithFrame:CGRectMake(60, 120, backview1.frame.size.width - 60, 150)];
        contentTv.layer.borderColor = [UIColor blackColor].CGColor;
        contentTv.layer.borderWidth = 1;
        contentTv.tag = -99999 + i;
        [backview1 addSubview:contentTv];
        
        contentTv1 = [[UITextView alloc]initWithFrame:CGRectMake(60, 300, backview1.frame.size.width - 60, 150)];
        contentTv1.layer.borderColor = [UIColor blackColor].CGColor;
        contentTv1.layer.borderWidth = 1;
        contentTv1.tag = -999999 + i;
        contentTv1.hidden = YES;
        [backview1 addSubview:contentTv1];

        commmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(backview1.frame.size.width - 60 - 60, 500, 60, 30)];
        [commmitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commmitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        commmitBtn.layer.borderColor = [UIColor blackColor].CGColor;
        commmitBtn.layer.borderWidth = 1;
        [commmitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        [backview1 addSubview:commmitBtn];
        
        se2TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 30)];
        se2TitleLb.font = [UIFont boldSystemFontOfSize:20];
        se2TitleLb.tag = -9999999 + i;
        se2TitleLb.textAlignment = NSTextAlignmentCenter;
        [backview2 addSubview:se2TitleLb];

        se2Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, backview2.frame.size.width, backview2.frame.size.height - 210)];
        se2Tabv.delegate = self;
        se2Tabv.dataSource = self;
        se2Tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
        se2Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        se2Tabv.tag = -99999999 + i;
        [backview2 addSubview:se2Tabv];
        
        toupiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(650, se2Tabv.frame.origin.y + se2Tabv.frame.size.height + 20, 60, 30)];
        toupiaoBtn.tag = 22222 + i;
        [toupiaoBtn setTitle:@"投票" forState:UIControlStateNormal];
        [toupiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        toupiaoBtn.layer.borderColor = [UIColor blackColor].CGColor;
        toupiaoBtn.layer.borderWidth = 1;
        [toupiaoBtn addTarget:self action:@selector(toupiao) forControlEvents:UIControlEventTouchUpInside];
        [backview2 addSubview:toupiaoBtn];
        
        se3Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, backview3.frame.size.width, backview3.frame.size.height - 100)];
        se3Tabv.delegate = self;
        se3Tabv.dataSource = self;
        se3Tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
        se3Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        se3Tabv.tag = 111111 + i;
        [backview3 addSubview:se3Tabv];
        
        se3TitleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, backview3.frame.size.width/2 - 50, 30)];
        [se3TitleBtn setBackgroundImage:[UIImage imageNamed:@"Work_Browse_Button_01"] forState:UIControlStateNormal];
        se3TitleBtn.tag = 333333 + i;
        [se3TitleBtn addTarget:self action:@selector(se3sel:) forControlEvents:UIControlEventTouchUpInside];
        [backview3 addSubview:se3TitleBtn];

        se3TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, backview3.frame.size.width/2 - 100, 30)];
        se3TitleLb.font = [UIFont boldSystemFontOfSize:20];
        se3TitleLb.tag = 222222 + i;
        [se3TitleBtn addSubview:se3TitleLb];
        
        se3slTabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, backview3.frame.size.width/2 - 50, 300)];
        se3slTabv.delegate = self;
        se3slTabv.dataSource = self;
        se3slTabv.backgroundColor = [UIColor whiteColor];
        se3slTabv.tag = 444444 + i;
        se3slTabv.hidden = YES;
        [backview3 addSubview:se3slTabv];

        UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(backview3.frame.size.width/2, 20, 40, 30)];
        [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
        searchBtn.layer.borderWidth = 1;
        searchBtn.tag = 555555 + i;
        [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [backview3 addSubview:searchBtn];

        UILabel *se3titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backview3.frame.size.width, 20)];
        se3titleLb1.font = [UIFont boldSystemFontOfSize:20];
        se3titleLb1.tag = 666666 + i;
        se3titleLb1.textAlignment = NSTextAlignmentCenter;
        [backview3 addSubview:se3titleLb1];
        
        UIButton* toupiaoBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(650, se3Tabv.frame.origin.y + se3Tabv.frame.size.height + 20, 60, 30)];
        toupiaoBtn1.tag = 888888 + i;
        [toupiaoBtn1 setTitle:@"投票" forState:UIControlStateNormal];
        [toupiaoBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        toupiaoBtn1.layer.borderColor = [UIColor blackColor].CGColor;
        toupiaoBtn1.layer.borderWidth = 1;
        toupiaoBtn1.hidden = YES;
        [toupiaoBtn1 addTarget:self action:@selector(toupiao1) forControlEvents:UIControlEventTouchUpInside];
        [backview3 addSubview:toupiaoBtn1];

        UITableView* se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, backview4.frame.size.width, backview4.frame.size.height - 300)];
        se4Tabv.delegate = self;
        se4Tabv.dataSource = self;
        se4Tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
        se4Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        se4Tabv.tag = 3333333 + i;
        [backview4 addSubview:se4Tabv];
        
        
        UILabel *se4titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backview4.frame.size.width, 20)];
        se4titleLb1.font = [UIFont boldSystemFontOfSize:20];
        se4titleLb1.tag = 2222222 + i;
        se4titleLb1.textAlignment = NSTextAlignmentCenter;
        [backview4 addSubview:se4titleLb1];

        UIButton* wengaoBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(650, se4Tabv.frame.origin.y + se4Tabv.frame.size.height + 20, 140, 30)];
        wengaoBtn1.tag = 5555555 + i;
        [wengaoBtn1 setTitle:@"生成我的文稿" forState:UIControlStateNormal];
        [wengaoBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        wengaoBtn1.layer.borderColor = [UIColor blackColor].CGColor;
        wengaoBtn1.layer.borderWidth = 1;
        wengaoBtn1.hidden = YES;
        [wengaoBtn1 addTarget:self action:@selector(wengao) forControlEvents:UIControlEventTouchUpInside];
        [backview4 addSubview:wengaoBtn1];
        
        UITableView* se4Tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, se4Tabv.frame.origin.y + se4Tabv.frame.size.height + 10, 650, 200)];
        se4Tabv1.delegate = self;
        se4Tabv1.dataSource = self;
        se4Tabv1.separatorStyle = UITableViewCellSeparatorStyleNone;
        se4Tabv1.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        se4Tabv1.tag = 8888888 + i;
        [backview4 addSubview:se4Tabv1];

        y += self.view.frame.size.width;
        i++;
    }
    
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
    _pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
    _pageControl.padding = 13.0f;
    _pageControl.orientation = PageControlOrientationLandscape;
    _pageControl.numberOfPages = [self.hezuoArr count];
    [self.view addSubview:_pageControl];
    
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
    [self.toupiaoBtn addTarget:self action:@selector(toupiao11) forControlEvents:UIControlEventTouchUpInside];
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

    
    self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 210)];
    self.shoucangview.center = self.view.center;
    self.shoucangview.hidden = YES;
    [self.view addSubview:self.shoucangview];
    
    NSArray *arr = @[@"好词语",@"好句子",@"好段落",@"好开头",@"好结尾",@"好题目",@"好文章",];
    int yx = 0;
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, yx, 60, 30)];
        btn.tag = -7777777 + i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.shoucangview addSubview:btn];
        yx += 30;
    }

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

-(void)toupiao11
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
    
//    ZMhezuoViewController *vc = [[ZMhezuoViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:NULL];
    
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

-(void)wengao
{
    [self.wengaoArr removeAllObjects];
    
    for (int i = 0; i < [self.M125AtempArr count]; i++) {
        NSMutableArray *arr = self.M125AtempArr[i];
        for (NSMutableDictionary *dicc in arr) {
            if ([dicc[@"flag"] isEqualToString:@"1"]) {
                [self.wengaoArr addObject:dicc[@"forumContent"]];
            }
        }
    }
    
    UITableView *tabv = [self.view viewWithTag:8888888 + self.number];
    [tabv reloadData];
    NSLog(@"self.wengaoArr====%@",self.wengaoArr);
    
}

-(void)toupiao
{
    
    UIButton *btn = [self.view viewWithTag:22222 + self.number];
    [btn setTitle:@"已投票" forState:UIControlStateNormal];
    btn.enabled = NO;
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M127" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[NSString stringWithFormat:@"%@",self.M124dic[@"coType"]] forKey:@"type"];
    [requestDict setValue:self.M124tempArr forKey:@"voteContent"];
    [requestDict setValue:self.M124dic[@"forumId"] forKey:@"forumId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)toupiao1
{
    UIButton *btn = [self.view viewWithTag:888888 + self.number];
    [btn setTitle:@"已投票" forState:UIControlStateNormal];
    btn.enabled = NO;
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M127" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[NSString stringWithFormat:@"%@",self.M125dic[@"coType"]] forKey:@"type"];
    [requestDict setValue:self.M125tempArr forKey:@"voteContent"];
    [requestDict setValue:self.M125dic[@"forumId"] forKey:@"forumId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 40)];
    backView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    if (seg.selectedSegmentIndex == 1) {
        return 80;
    }else if (seg.selectedSegmentIndex == 2){
        if (tableView.tag == 111111 + self.number) {
            
            return 280;
        }

        return 40;
    }else if (seg.selectedSegmentIndex == 3){
    
        if (tableView.tag == 3333333 + self.number) {
            return 100;
        }else if (tableView.tag == 8888888 + self.number){
            return 40;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 1)];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 40)];
    backView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    if (seg.selectedSegmentIndex == 1) {
        return 40;

    }else if (seg.selectedSegmentIndex == 2){
        
       
    }else if (seg.selectedSegmentIndex == 3){
    
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 40)];
    backView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    if (seg.selectedSegmentIndex == 1) {
        
        se2SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        [se2SelBtn addTarget:self action:@selector(se2Sel:) forControlEvents:UIControlEventTouchUpInside];
        se2SelBtn.tag = 11111 + self.number*100 + section;
        [se2SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
        [se2SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
        [backView addSubview:se2SelBtn];
        if ([[NSString stringWithFormat:@"%@",self.M124tempArr[section][@"flag"]] isEqualToString:@"1"]) {
            [se2SelBtn setSelected:YES];
        }else{
            [se2SelBtn setSelected:NO];
        }
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 120, 40)];
        nameLb.font = [UIFont systemFontOfSize:16];
        nameLb.text = [NSString stringWithFormat:@"%@:",self.M124dic[@"groupNames"][section][@"groupName"]];
        [backView addSubview:nameLb];
        
        UILabel *countLb = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 100, 40)];
        countLb.font = [UIFont systemFontOfSize:16];
        countLb.text = [NSString stringWithFormat:@"%@票",self.M124dic[@"groupNames"][section][@"voteCount"]];
        [backView addSubview:countLb];
        
    }else if (seg.selectedSegmentIndex == 2){
        if (tableView.tag == 111111 + self.number) {
            
           
        }
    }else if (seg.selectedSegmentIndex == 3){
    
        if (tableView.tag == 3333333 + self.number) {
            UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
            nameLb.font = [UIFont systemFontOfSize:16];
            nameLb.text = [NSString stringWithFormat:@"%@",self.M125Adic[@"forumSubTitles"][section][@"forumSubTitle"]];
            [backView addSubview:nameLb];

        }else if (tableView.tag == 8888888 + self.number){
        }
        
    }
    return backView;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    
    if (seg.selectedSegmentIndex == 1) {
        return [self.M124dic[@"groupNames"] count];
    }else if (seg.selectedSegmentIndex == 2){
    
        return 1;
    }else if (seg.selectedSegmentIndex == 3){
    
        if (tableView.tag == 3333333 + self.number) {
            return [self.M125Adic[@"forumSubTitles"] count];

        }else if (tableView.tag == 8888888 + self.number){
            return 1;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];

    if (seg.selectedSegmentIndex == 1) {
        return [self.M124dic[@"groupNames"][section][@"forumContents"]count];
    }else if (seg.selectedSegmentIndex == 2){
        if (tableView.tag == 111111 + self.number) {
         
            return [self.M125dic[@"forumSubTitles"][0][@"forumContents"] count];
        }

        return [self.M126Arr count];
    }else if (seg.selectedSegmentIndex == 3){
        if (tableView.tag == 3333333 + self.number) {
            return [self.M125Adic[@"forumSubTitles"][section][@"forumContents"] count];
        }else if (tableView.tag == 8888888 + self.number){
            return [self.wengaoArr count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];

    if (seg.selectedSegmentIndex == 1) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
            
            UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, backview2.frame.size.width - 80, 20)];
            nameLb.font = [UIFont systemFontOfSize:16];
            nameLb.tag = 55555;
            [cell.contentView addSubview:nameLb];
            
            UITextView *contentTv2 = [[UITextView alloc]initWithFrame:CGRectMake(100, 20, backview2.frame.size.width - 130, 60)];
            contentTv2.editable = NO;
            contentTv2.tag = 66666;
            contentTv2.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:contentTv2];
        }
        UILabel *nameLb = [cell.contentView viewWithTag:55555];
        nameLb.text = [NSString stringWithFormat:@"%@(%@):",self.M124dic[@"groupNames"][indexPath.section][@"forumContents"][indexPath.row][@"author"],self.M124dic[@"groupNames"][indexPath.section][@"forumContents"][indexPath.row][@"forumSubTitle"]];
        
        UITextView *contentTv2 = [cell.contentView viewWithTag:66666];
        contentTv2.text = self.M124dic[@"groupNames"][indexPath.section][@"forumContents"][indexPath.row][@"forumContent"];
        
        return cell;
    }else if (seg.selectedSegmentIndex == 2) {
        
        if (tableView.tag == 111111 + self.number) {
            static NSString *CellIdentifier = @"Cell2";
            
            ZMhezuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[[ZMhezuoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];

//                UIButton* se3SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
//                se3SelBtn.tag = 777777;
//                [se3SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
//                [se3SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
//                [cell.contentView addSubview:se3SelBtn];
                
                UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 160, 40)];
                nameLb.font = [UIFont systemFontOfSize:16];
                nameLb.tag = 55557;
                [cell.contentView addSubview:nameLb];
                
                UITextView *contentTv2 = [[UITextView alloc]initWithFrame:CGRectMake(100, 20, backview2.frame.size.width - 130, 60)];
                contentTv2.editable = NO;
                contentTv2.tag = 66667;
                contentTv2.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:contentTv2];


            }
            cell.shoucangBtn.tag = 55555555 + self.number*100 + indexPath.row;
            [cell.shoucangBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];

            cell.se3SelBtn.tag = 4444444 + self.number*100 + indexPath.row;
            [cell.se3SelBtn addTarget:self action:@selector(se4Sel:) forControlEvents:UIControlEventTouchUpInside];
            if ([[NSString stringWithFormat:@"%@",self.M125tempArr[indexPath.row][@"flag"]] isEqualToString:@"1"]) {
                [cell.se3SelBtn setSelected:YES];
            }else{
                [cell.se3SelBtn setSelected:NO];
            }
            
            UILabel *nameLb = [cell.contentView viewWithTag:55557];
            nameLb.text = [NSString stringWithFormat:@"%@(%@):",self.M125dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"author"],self.M125dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"groupName"]];
            
            UITextView *contentTv2 = [cell.contentView viewWithTag:66667];
            contentTv2.text = [NSString stringWithFormat:@"%@",self.M125dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"forumContent"]];

            return cell;

        }else{
            static NSString *CellIdentifier = @"Cell1";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            cell.textLabel.text = self.M126Arr[indexPath.row][@"optionName"];
            return cell;
        }
    }else if (seg.selectedSegmentIndex == 3) {
        
        if (tableView.tag == 3333333 + self.number) {
            static NSString *CellIdentifier = @"Cell3";
            
            ZMhezuo1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[[ZMhezuo1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
                
            }
            cell.hezuoarr = self.M125AtempArr[indexPath.section];
            cell.hezuodic = self.M125AtempArr[indexPath.section][indexPath.row];
            cell.hezuo1dic = self.M125Adic[@"forumSubTitles"][indexPath.section][@"forumContents"][indexPath.row];
            
            return cell;

        }else if (tableView.tag == 8888888 + self.number){
            static NSString *CellIdentifier = @"Cell4";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
            }
            cell.textLabel.text = self.wengaoArr[indexPath.row];
            return cell;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    
    if (seg.selectedSegmentIndex == 1) {
    }else if (seg.selectedSegmentIndex == 2) {
        
        UILabel *lable = [self.view viewWithTag:222222 + self.number];
        lable.text = self.M126Arr[indexPath.row][@"optionName"];
        
        UITableView *tabv = [self.view viewWithTag:444444 + self.number];
        tabv.hidden = YES;
        isHidden = YES;
        
        m126id = self.M126Arr[indexPath.row][@"optionId"];
    }
    
}

-(void)se2Sel:(UIButton *)send
{
    int tag = send.tag;
    NSLog(@"hhhhhhh%d",tag);

//    UIButton* shareBtn = (UIButton*)send;
//    [shareBtn setSelected:!shareBtn.selected];
    
    int count = tag - 11111 - self.number*100;
    
    NSMutableDictionary *dic = self.M124tempArr[count];
    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]) {
        [dic setValue:@"0" forKey:@"flag"];
    }else {
        [dic setValue:@"1" forKey:@"flag"];
    }
    
    UITableView *tabv = [self.view viewWithTag: -99999999 + self.number];
    [tabv reloadData];
    
    NSLog(@"vvvvvvv%@",self.M124tempArr);
}

-(void)action:(UIButton *)sender
{
    self.shoucangview.hidden = YES;
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M131" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.nameStr forKey:@"collectTitile"];
    [requestDict setValue:contentStr forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag + 1 + 7777777] forKey:@"typeId"];
    [requestDict setValue:@"3" forKey:@"sourceId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)shoucang:(UIButton *)sender
{
    int tag = sender.tag;
    int count = tag - 55555555 - self.number*100;

    UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
    self.shoucangview.hidden = NO;
//    self.shoucangview.center = CGPointMake(self.view.center.x, self.scro.contentOffset.y + self.scro.frame.size.height/2);
    
    UILabel *lable = [self.view viewWithTag:222222 + self.number];
    self.nameStr = [NSString stringWithFormat:@"%@(%@)",lable.text,[NSString stringWithFormat:@"主题:%@",self.M125dic[@"forumSubTitles"][0][@"forumSubTitle"]]];
    contentStr = self.M125dic[@"forumSubTitles"][0][@"forumContents"][count][@"forumContent"];
}

-(void)se4Sel:(UIButton *)send
{
    int tag = send.tag;
    NSLog(@"hhhhhhh%d",tag);

    
    int count = tag - 4444444 - self.number*100;
    
    NSMutableDictionary *dic = self.M125tempArr[count];
    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]) {
        [dic setValue:@"0" forKey:@"flag"];
    }else {
        [dic setValue:@"1" forKey:@"flag"];
    }
    
    UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
    [tabv reloadData];

    NSLog(@"nnnnnnn%@",self.M125tempArr);

}

-(void)se3sel:(UIButton *)send
{
    int tag = send.tag;

    UITableView *tabv = [self.view viewWithTag:444444 + self.number];
    
    if (isHidden == YES) {
        tabv.hidden = NO;
        isHidden = NO;
    }else {
        tabv.hidden = YES;
        isHidden = YES;
    }
}

-(void)search:(UIButton *)send
{
    [self loadM125];
    UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
    tabv.hidden = NO;
}

-(void)loadM124View
{
    UILabel *label = [self.view viewWithTag:-9999999 + self.number];
    label.text = self.M124dic[@"forumTitle"];
    
    UIButton *btn = [self.view viewWithTag:22222 + self.number];
    if ([[NSString stringWithFormat:@"%@",self.M124dic[@"ifVote"]] isEqualToString:@"1"]) {
        [btn setTitle:@"投票" forState:UIControlStateNormal];
        btn.enabled = YES;
    }else {
        [btn setTitle:@"已投票" forState:UIControlStateNormal];
        btn.enabled = NO;
    }
}

-(void)refish
{
    [self loadM122];
}

-(void)commit
{
    UITextView *tv = [self.view viewWithTag: -99999 + self.number];
    UITextView *tv1 = [self.view viewWithTag:-999999 + self.number];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M123" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.dic[@"forumId"] forKey:@"forumId"];
    [requestDict setValue:self.dic[@"forumSubId"] forKey:@"forumSubId"];
    if ([[NSString stringWithFormat:@"%@",self.dic[@"forumType"]] isEqualToString:@"1"]) {
        [requestDict setValue:tv1.text forKey:@"forumContent"];
    }else {
        [requestDict setValue:tv.text forKey:@"forumContent"];
    }
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
    tv1.text = @"";
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSLog(@"vvvvvv%ld",Seg.tag - 9999);
    NSLog(@"wocao%ld",Seg.selectedSegmentIndex);
    
    if (Seg.selectedSegmentIndex == 0) {
        
        UIView *backview = [self.scro viewWithTag:Seg.tag - 9999 + 999];
        UIView *back1 = [backview viewWithTag:Seg.tag - 9999 + 99999];
        back1.hidden = NO;
        
        UIView *back2 = [backview viewWithTag:Seg.tag - 9999 + 999999];
        back2.hidden = YES;
        
        UIView *back3 = [backview viewWithTag:Seg.tag - 9999 + 9999999];
        back3.hidden = YES;
        
        UIView *back4 = [backview viewWithTag:Seg.tag - 9999 + 99999999];
        back4.hidden = YES;
        
    }else if (Seg.selectedSegmentIndex == 1) {
        UIView *backview = [self.scro viewWithTag:Seg.tag - 9999 + 999];

        UIView *back1 = [backview viewWithTag:Seg.tag - 9999 + 99999];
        back1.hidden = YES;
        
        UIView *back2 = [backview viewWithTag:Seg.tag - 9999 + 999999];
        back2.hidden = NO;
        
        UIView *back3 = [backview viewWithTag:Seg.tag - 9999 + 9999999];
        back3.hidden = YES;
        
        UIView *back4 = [backview viewWithTag:Seg.tag - 9999 + 99999999];
        back4.hidden = YES;
        UITableView *tabv = [self.view viewWithTag: -99999999 + self.number];
        [tabv reloadData];
        [self loadM124View];
    }else if (Seg.selectedSegmentIndex == 2) {
        UIView *backview = [self.scro viewWithTag:Seg.tag - 9999 + 999];

        UIView *back1 = [backview viewWithTag:Seg.tag - 9999 + 99999];
        back1.hidden = YES;
        
        UIView *back2 = [backview viewWithTag:Seg.tag - 9999 + 999999];
        back2.hidden = YES;
        
        UIView *back3 = [backview viewWithTag:Seg.tag - 9999 + 9999999];
        back3.hidden = NO;
        
        UIView *back4 = [backview viewWithTag:Seg.tag - 9999 + 99999999];
        back4.hidden = YES;
        
        UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
        [tabv reloadData];
        UITableView *tabv1 = [self.view viewWithTag: 444444 + self.number];
        [tabv1 reloadData];
        [self loadM126SubView];
        [self loadM125SubView];

    }else if (Seg.selectedSegmentIndex == 3) {
        UIView *backview = [self.scro viewWithTag:Seg.tag - 9999 + 999];

        UIView *back1 = [backview viewWithTag:Seg.tag - 9999 + 99999];
        back1.hidden = YES;
        
        UIView *back2 = [backview viewWithTag:Seg.tag - 9999 + 999999];
        back2.hidden = YES;
        
        UIView *back3 = [backview viewWithTag:Seg.tag - 9999 + 9999999];
        back3.hidden = YES;
        
        UIView *back4 = [backview viewWithTag:Seg.tag - 9999 + 99999999];
        back4.hidden = NO;
        
        [self loadM125a];

    }
}

-(void)loadM122
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M122" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.hezuoArr[self.number][@"forumId"] forKey:@"forumId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)loadM124
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M124" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.hezuoArr[self.number][@"forumId"] forKey:@"forumId"];
    
    [self showIndicator];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)loadM125a
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M125" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.hezuoArr[self.number][@"forumId"] forKey:@"forumId"];
    
    [self showIndicator];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    httpEngine.m125 = @"0";

    [httpEngine release];
    [requestDict release];

}

-(void)loadM125
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M125" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.hezuoArr[self.number][@"forumId"] forKey:@"forumId"];
    [requestDict setValue:m126id forKey:@"optionId"];

    [self showIndicator];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    httpEngine.m125 = @"1";

    [httpEngine release];
    [requestDict release];

}

-(void)loadM126
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M126" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.hezuoArr[self.number][@"forumId"] forKey:@"forumId"];
    
    [self showIndicator];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)loadM126SubView
{
    UILabel *lable = [self.view viewWithTag:222222 + self.number];
    lable.text = self.M126Arr[0][@"optionName"];
    m126id = self.M126Arr[0][@"optionId"];
}

-(void)loadM125ASubView
{
    UILabel *label = [self.view viewWithTag:2222222 + self.number];
    label.text = [NSString stringWithFormat:@"主题:%@",self.M125Adic[@"forumTitle"]];
}

-(void)loadM125SubView
{
    UILabel *label = [self.view viewWithTag:666666 + self.number];
    label.text = self.M125dic[@"forumSubTitles"][0][@"forumSubTitle"] ?[NSString stringWithFormat:@"主题:%@",self.M125dic[@"forumSubTitles"][0][@"forumSubTitle"]] : @"";
    
    UIButton *btn = [self.view viewWithTag:888888 + self.number];

    if ([[NSString stringWithFormat:@"%@",self.M125dic[@"forumSubTitles"][0][@"ifVote"]] isEqualToString:@"1"]) {
        [btn setTitle:@"投票" forState:UIControlStateNormal];
        btn.enabled = YES;
    }else {
        [btn setTitle:@"已投票" forState:UIControlStateNormal];
        btn.enabled = NO;
    }

}

-(void)loaddataSubView
{
    UILabel *label = [self.view viewWithTag:-999 + self.number];
    label.text = self.dic[@"forumTitle"];
    
    UILabel *label1 = [self.view viewWithTag:-9999 + self.number];
    label1.text = self.dic[@"forumSubTitle"];
    
    UITextView *tv = [self.view viewWithTag: -99999 + self.number];
    tv.text = self.dic[@"forumContent"];

    UITextView *tv1 = [self.view viewWithTag:-999999 + self.number];
    
    if ([[NSString stringWithFormat:@"%@",self.dic[@"forumType"]] isEqualToString:@"1"]) {
        tv.editable = NO;
        tv1.hidden = NO;
    }else {
        tv.editable = YES;
        tv1.hidden = YES;
    }
    
}

-(void)closeClick
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:100];
    [alert show];
    [alert release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scro) {
        CGFloat width = self.scro.frame.size.width;
        NSUInteger currentPage = floor((self.scro.contentOffset.x - width / 2) / width) + 1;
        _pageControl.currentPage = currentPage;
        self.number = currentPage;
        [self loadM122];
        [self loadM124];
        [self loadM126];
        [self loadM125a];
        
        UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
        tabv.hidden = YES;
    }
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M121" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        self.hezuoArr = responseDict[@"forumTitles"];
        [self loadSubViews];
        [self hideIndicator];
        [self loadM122];
    }else if ([@"M122" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        self.dic = responseDict;
        [self loaddataSubView];
        NSLog(@"hahha%@",responseDict);
    }else if ([@"M123" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        [self showTip:@"提交成功"];
        [self loadM122];
    }else if ([@"M124" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        self.M124dic = responseDict;
        [self loadM124View];
        UITableView *tabv = [self.view viewWithTag: -99999999 + self.number];
        [tabv reloadData];
        NSMutableArray *arr = self.M124dic[@"groupNames"];
        [self.M124tempArr removeAllObjects];
        
        for (NSMutableDictionary *dic in arr) {
            NSString *groupId = dic[@"groupId"];
            NSString *ifSelect = dic[@"ifSelect"];

            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag", nil];
            [self.M124tempArr addObject:mDic];
        }
        
        NSLog(@"*******%@",self.M124dic);
        NSLog(@"self.M124tempArr===%@",self.M124tempArr);
    }else if ([@"M127" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        [self showTip:@"投票成功"];
    }else if ([@"M125" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        
        if ([[NSString stringWithFormat:@"%@",responseDict[@"m125"]] isEqualToString:@"1"]) {
            self.M125dic = responseDict;
            NSLog(@"self.M125dic===%@",self.M125dic);
            
            UITableView *tabv = [self.view viewWithTag: 111111 + self.number];
            [tabv reloadData];
            [self loadM125SubView];
            UIButton *btn = [self.view viewWithTag:888888 + self.number];
            btn.hidden = NO;
            
            [self.M125tempArr removeAllObjects];
            NSMutableArray *arr = self.M125dic[@"forumSubTitles"][0][@"forumContents"];
            for (NSMutableDictionary *dic in arr) {
                NSString *groupId = dic[@"voteAnswerId"];
                NSString *ifSelect = dic[@"ifSelect"];
                NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag", nil];
                [self.M125tempArr addObject:mDic];
            }
            
            NSLog(@"self.M125tempArr===%@",self.M125tempArr);

        }else if ([[NSString stringWithFormat:@"%@",responseDict[@"m125"]] isEqualToString:@"0"]){
            self.M125Adic = responseDict;
            
            [self loadM125ASubView];
            
            UITableView *tabv = [self.view viewWithTag: 3333333 + self.number];
            [tabv reloadData];

            UIButton *btn = [self.view viewWithTag:5555555 + self.number];
            btn.hidden = NO;
            NSLog(@"self.M125Adic===%@",self.M125Adic);
            
            [self.M125AtempArr removeAllObjects];
            
            for (int i = 0; i < [self.M125Adic[@"forumSubTitles"] count]; i++) {
                NSMutableDictionary *dic = self.M125Adic[@"forumSubTitles"][i];
                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                for (NSMutableDictionary *dicc in dic[@"forumContents"]) {
                    NSString *groupId = [NSString stringWithFormat:@"%@",dicc[@"voteAnswerId"]];
                    NSString *ifSelect = [NSString stringWithFormat:@"%@",dicc[@"ifSelect"]];
                    NSString *content = [NSString stringWithFormat:@"%@",dicc[@"forumContent"]];
                    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag",content,@"forumContent", nil];
                    [arr1 addObject:mDic];
                }

                [self.M125AtempArr addObject:arr1];
            }
            
            NSLog(@"self.M125AtempArr===%@",self.M125AtempArr);
        }
        
    }else if ([@"M126" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        self.M126Arr = responseDict[@"options"];
        [self loadM126SubView];
        
        UITableView *tabv = [self.view viewWithTag: 444444 + self.number];
        [tabv reloadData];
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
    if ([@"M131" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏成功"];
    }
    if ([@"M131" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏失败"];
    }

    if ([@"M135" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布成功"];
    }
    if ([@"M135" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布失败"];
    }
}

@end
