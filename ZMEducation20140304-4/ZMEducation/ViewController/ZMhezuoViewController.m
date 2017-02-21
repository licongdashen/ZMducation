//
//  ZMhezuoViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMhezuoViewController.h"

@implementation ZMhezuoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.M124tempArr = [[NSMutableArray alloc]init];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    
    self.view = view;
    
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
        backview4.backgroundColor = [UIColor blackColor];
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
        
        toupiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(650, se2Tabv.frame.origin.y + se2Tabv.frame.size.height + 20, 50, 30)];
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
        se3slTabv.separatorStyle = UITableViewCellSeparatorStyleNone;
        se3slTabv.backgroundColor = [UIColor whiteColor];
        se3slTabv.tag = 444444 + i;
        [backview3 addSubview:se3slTabv];

        
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
}

-(void)toupiao
{
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
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
    return 40;
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
        if ([[NSString stringWithFormat:@"%@",self.M124dic[@"groupNames"][section][@"ifSelect"]] isEqualToString:@"1"]) {
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
        
    }else if (self.number == 2){
    
    }
    return backView;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];
    
    if (seg.selectedSegmentIndex == 1) {
        return [self.M124dic[@"groupNames"] count];
    }else if (seg.selectedSegmentIndex == 2){
    
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    UISegmentedControl *seg = [self.view viewWithTag:9999 + self.number];

    if (seg.selectedSegmentIndex == 1) {
        return [self.M124dic[@"groupNames"][section][@"forumContents"]count];
    }else if (seg.selectedSegmentIndex == 2){
        
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
    
    }
    return nil;
}

-(void)se2Sel:(UIButton *)send
{
    int tag = send.tag;
    NSLog(@"hhhhhhh%d",tag);

    UIButton* shareBtn = (UIButton*)send;
    [shareBtn setSelected:!shareBtn.selected];
    
    int count = tag - 11111 - self.number*100;
    
    NSMutableDictionary *dic = self.M124tempArr[count];
    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]) {
        [dic setValue:@"0" forKey:@"flag"];
    }else {
        [dic setValue:@"1" forKey:@"flag"];
    }
    
    NSLog(@"vvvvvvv%@",self.M124tempArr);
}

-(void)se3sel:(UIButton *)send
{
    int tag = send.tag;

    
}

-(void)loadM124View
{
    UILabel *label = [self.view viewWithTag:-9999999 + self.number];
    label.text = self.M124dic[@"forumTitle"];
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
//    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"optionId"];

    [self showIndicator];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
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

    }else if ([@"M126" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        self.M126Arr = responseDict[@"options"];
        [self loadM126SubView];
    }
}

@end
