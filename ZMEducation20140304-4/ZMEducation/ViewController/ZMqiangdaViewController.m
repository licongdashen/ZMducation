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
    tabv.hidden = YES;
    isHidden = YES;
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
