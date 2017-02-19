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
    
    [self showIndicator];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];


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
        
        backview1 = [[UIView alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
        backview1.backgroundColor = [UIColor yellowColor];
        backview1.hidden = NO;
        backview1.tag = 99999 + i;
        [self.backView addSubview:backview1];
        
        backview2 = [[UIView alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
        backview2.backgroundColor = [UIColor greenColor];
        backview2.hidden = YES;
        backview2.tag = 999999 + i;
        [self.backView addSubview:backview2];
        
        backview3 = [[UIView alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
        backview3.backgroundColor = [UIColor blueColor];
        backview3.hidden = YES;
        backview3.tag = 9999999 + i;
        [self.backView addSubview:backview3];
        
        backview4 = [[UIView alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
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

-(void)refish
{
    [self loadM122];
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
    [requestDict setValue:self.hezuoArr[self.number][@"forumTitleId"] forKey:@"forumTitleId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

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
    CGFloat width = self.scro.frame.size.width;
    NSUInteger currentPage = floor((self.scro.contentOffset.x - width / 2) / width) + 1;
    _pageControl.currentPage = currentPage;
    self.number = currentPage;
    [self loadM122];
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
    }
}

@end
