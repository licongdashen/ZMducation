//
//  ZMtoupiaoViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/2/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMtoupiaoViewController.h"
#import "ZMtoupiaoTableViewCell.h"

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
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height - 150, self.view.frame.size.width - 100 ,30)];
    [searchBtn setTitle:@"提交" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
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

}

-(void)commit:(UIButton *)send
{
    
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

    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",self.m112Dic[@"groupNames"][indexPath.row][@"optionName"],self.m112Dic[@"groupNames"][indexPath.row][@"optionContent"]];
    return cell;
}

-(void)se4Sel:(UIButton *)send
{
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
        [self loadM112];
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

    }else if (([@"M112" isEqualToString:method] && [@"00" isEqualToString:responseCode]) ){
        [self hideIndicator];

        self.m112Dic = responseDict;
        NSLog(@"self.m112Dic====%@",self.m112Dic);
        UITableView *tabv = [self.view viewWithTag: 100000 + self.number];
        [tabv reloadData];
        
        
        [self.m112tmepArr removeAllObjects];
        
        NSMutableArray *arr = self.m112Dic[@"groupNames"];
        for (NSMutableDictionary *dic in arr) {
            NSString *groupId = dic[@"optionId"];
            NSString *ifSelect = dic[@"ifSelect"];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag", nil];
            [self.m112tmepArr addObject:mDic];
        }
        
        NSLog(@"self.m112tmepArr===%@",self.m112tmepArr);
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
