//
//  ZMwodeshoucangViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/2.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMwodeshoucangViewController.h"

@interface ZMwodeshoucangViewController ()
{
    UILabel * se3TitleLb;
    UILabel * se3TitleLb1;

    NSArray *titlearr;
    BOOL hidden;
    UITableView *titleTabv;
    
    BOOL hidden1;
    UITableView *titleTabv1;
    
    NSString * tittleStr;
    UITextField * titleTf;
    
    UITextView *contentTv;
    
}
@property (nonatomic, strong) UIView *shoucangview;
@property (nonatomic, strong) NSDictionary *m004Dic;

@end

@implementation ZMwodeshoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hidden = YES;
    hidden1 = YES;

    tittleStr = @"1";
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;

    titlearr = [[NSArray alloc]initWithObjects:@"好词语",@"好句子",@"好段落",@"好开头",@"好结尾",@"好题目",@"好文章", nil];
    
    self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 210)];
    self.shoucangview.center = self.view.center;
    self.shoucangview.hidden = YES;
    [self.view addSubview:self.shoucangview];
    
    int y = 0;
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 60, 30)];
        btn.tag = i;
        [btn setTitle:titlearr[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.shoucangview addSubview:btn];
        y += 30;
    }

    UILabel * TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 130, 30)];
    TitleLb.font = [UIFont boldSystemFontOfSize:16];
    TitleLb.text = @"请选择收藏类型:";
    [self.view addSubview:TitleLb];
    
    UIButton* se3TitleBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 50, 200, 30)];
    [se3TitleBtn setBackgroundImage:[UIImage imageNamed:@"Work_Browse_Button_01"] forState:UIControlStateNormal];
    [se3TitleBtn addTarget:self action:@selector(se3sel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:se3TitleBtn];
    
    se3TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200 - 100, 30)];
    se3TitleLb.font = [UIFont boldSystemFontOfSize:20];
    se3TitleLb.text = titlearr[0];
    [se3TitleBtn addSubview:se3TitleLb];

    titleTabv = [[UITableView alloc]initWithFrame:CGRectMake(150, 80, se3TitleBtn.frame.size.width, 300)];
    titleTabv.delegate = self;
    titleTabv.dataSource = self;
    titleTabv.hidden = YES;
//    titleTabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:titleTabv];

    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(380, 50, 60 ,30)];
    [searchBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 30)];
    titleLb.text = @"收藏主题:";
    titleLb.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:titleLb];
    
    titleTf = [[UITextField alloc]initWithFrame:CGRectMake(150, 100, 500, 30)];
    titleTf.layer.borderColor = [UIColor blackColor].CGColor;
    titleTf.layer.borderWidth = 1;
    [self.view addSubview:titleTf];
    
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 100, 30)];
    contentLb.text = @"收藏内容:";
    contentLb.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:contentLb];

    contentTv = [[UITextView alloc]initWithFrame:CGRectMake(150, 150, 500, 120)];
    contentTv.layer.borderColor = [UIColor blackColor].CGColor;
    contentTv.layer.borderWidth = 1;
    contentTv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentTv];
    
    
    
    UILabel * TitleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 130, 30)];
    TitleLb1.font = [UIFont boldSystemFontOfSize:16];
    TitleLb1.text = @"请选择课程名称:";
    [self.view addSubview:TitleLb1];
    
    
    UIButton* se3TitleBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 200, 30)];
    [se3TitleBtn1 setBackgroundImage:[UIImage imageNamed:@"Work_Browse_Button_01"] forState:UIControlStateNormal];
    [se3TitleBtn1 addTarget:self action:@selector(se4sel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:se3TitleBtn1];
    
    se3TitleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200 - 100, 30)];
    se3TitleLb1.font = [UIFont boldSystemFontOfSize:20];
    [se3TitleBtn addSubview:se3TitleLb1];

    
    titleTabv1 = [[UITableView alloc]initWithFrame:CGRectMake(150, 320, se3TitleBtn1.frame.size.width, 300)];
    titleTabv1.delegate = self;
    titleTabv1.dataSource = self;
    titleTabv1.hidden = YES;
    //    titleTabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:titleTabv1];
    
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
    [requestDict setValue:@"M004" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    [self showIndicator];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
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
    [requestDict setValue:titleTf.text forKey:@"collectTitile"];
    [requestDict setValue:contentTv.text forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag + 1] forKey:@"typeId"];
    [requestDict setValue:@"5" forKey:@"sourceId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)shoucang
{
    self.shoucangview.hidden = NO;

}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M131" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏成功"];
    }
    if ([@"M131" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏失败"];
    }
    if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.m004Dic = responseDict;
        
        NSLog(@"self.m004Dic===%@",self.m004Dic);
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
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView == titleTabv) {
        return [titlearr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == titleTabv) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        }
        
        cell.textLabel.text = titlearr[indexPath.row];
        
        return cell;
    }else{
    
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == titleTabv) {
        tittleStr = [NSString stringWithFormat:@"%d",indexPath.row + 1];
        titleTabv.hidden = YES;
        hidden = YES;
        se3TitleLb.text = titlearr[indexPath.row];
    }
}

-(void)se4sel:(UIButton *)sende
{
    
    if (hidden1 == YES) {
        titleTabv1.hidden = NO;
        hidden1 = NO;
    }else{
        titleTabv1.hidden = YES;
        hidden1 = YES;
    }

}

-(void)se3sel:(UIButton *)sende
{
    if (hidden == YES) {
        titleTabv.hidden = NO;
        hidden = NO;
    }else{
        titleTabv.hidden = YES;
        hidden = YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
