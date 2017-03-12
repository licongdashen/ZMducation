//
//  ZMwodeshoucangViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/2.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMwodeshoucangViewController.h"
#import "ZMwodeshoucangTableViewCell.h"

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
    
    UITableView *titleTabv2;

    int selint;
    
    int row;
    
}

@property (nonatomic, strong) UIView *shoucangview;
@property (nonatomic, strong) NSDictionary *m004Dic;
@property (nonatomic, strong) NSMutableArray *m132Arr;

@end

@implementation ZMwodeshoucangViewController

-(void)dealloc
{
    [super dealloc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yqq" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yqq1" object:nil];

    
}

- (void)save:(NSNotification *)notification
{
    
    NSMutableDictionary *dic = (NSMutableDictionary *)[notification userInfo];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M133" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:dic[@"collectId"] forKey:@"collectId"];
    [requestDict setValue:dic[@"collectContent"] forKey:@"collectContent"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}


- (void)shanchu:(NSNotification *)notification
{
    
    NSDictionary *dic = [notification userInfo];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M134" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:dic[@"collectId"] forKey:@"collectId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hidden = YES;
    hidden1 = YES;

    tittleStr = @"1";
    selint = 0;
    row = 1;
    
    titlearr = [[NSArray alloc]initWithObjects:@"好词语",@"好句子",@"好段落",@"好开头",@"好结尾",@"好题目",@"好文章", nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"yqq" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shanchu:) name:@"yqq1" object:nil];

    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;

 
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
    contentTv.font = [UIFont systemFontOfSize:17];
    contentTv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentTv];
    
    
    UILabel * TitleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 130, 30)];
    TitleLb1.font = [UIFont boldSystemFontOfSize:16];
    TitleLb1.text = @"请选择课程名称:";
    [self.view addSubview:TitleLb1];
    
    UIButton* se3TitleBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 300, 30)];
    [se3TitleBtn1 setBackgroundImage:[UIImage imageNamed:@"Work_Browse_Button_01"] forState:UIControlStateNormal];
    [se3TitleBtn1 addTarget:self action:@selector(se4sel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:se3TitleBtn1];
    
    se3TitleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300 - 100, 30)];
    se3TitleLb1.font = [UIFont boldSystemFontOfSize:20];
    [se3TitleBtn1 addSubview:se3TitleLb1];

    
    UIButton *searchBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(480, 300, 60 ,30)];
    [searchBtn1 setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchBtn1.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn1.layer.borderWidth = 1;
    [searchBtn1 addTarget:self action:@selector(searchBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn1];
    
    titleTabv2 = [[UITableView alloc]initWithFrame:CGRectMake(20, 350, self.view.frame.size.width - 40, 450)];
    titleTabv2.delegate = self;
    titleTabv2.dataSource = self;
    titleTabv2.separatorStyle = UITableViewCellSeparatorStyleNone;
    titleTabv2.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:titleTabv2];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 40)];
    
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    type.text = @"类型";
    [headerView addSubview:type];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(65 + 10, 0, 1, 40)];
    line1.backgroundColor = [UIColor blackColor];
    [headerView addSubview:line1];
    
    UILabel *titile = [[UILabel alloc]initWithFrame:CGRectMake(70+ 10, 0, 220+ 10+ 10, 40)];
    titile.text = @"主题";
    titile.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titile];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(300+ 10+ 10+ 10, 0, 1, 40)];
    line2.backgroundColor = [UIColor blackColor];
    [headerView addSubview:line2];
    
    UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(310+ 10+ 10+ 10, 0, 80, 40)];
    score.text = @"来源";
    score.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:score];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(400+ 10+ 10+ 10, 0, 1, 40)];
    line3.backgroundColor = [UIColor blackColor];
    [headerView addSubview:line3];
    
    UILabel *tv = [[UILabel alloc]initWithFrame:CGRectMake(420 + 20, 0, 250 + 50, 40)];
    tv.text = @"内容";
    tv.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:tv];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(700+ 10+ 10+ 10+ 10+ 10+ 10+ 10+ 10 + 40, 0, 1, 40)];
    line4.backgroundColor = [UIColor blackColor];
    [headerView addSubview:line4];

    UILabel *tv1 = [[UILabel alloc]initWithFrame:CGRectMake(730 + 50 + 40, 0, 60, 40)];
    tv1.text = @"操作";
    tv1.textAlignment = NSTextAlignmentCenter;

    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(0, 39, self.view.frame.size.width - 40, 1)];
    line7.backgroundColor = [UIColor blackColor];
    [headerView addSubview:line7];
    
    [headerView addSubview:tv1];
    
//    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(800, 0, 1, 40)];
//    line5.backgroundColor = [UIColor blackColor];
//    [headerView addSubview:line5];
    
    titleTabv2.tableHeaderView = headerView;
    
    
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
    
    
    titleTabv = [[UITableView alloc]initWithFrame:CGRectMake(150, 80, se3TitleBtn.frame.size.width, 300)];
    titleTabv.delegate = self;
    titleTabv.dataSource = self;
    titleTabv.hidden = YES;
    //    titleTabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:titleTabv];

    
    titleTabv1 = [[UITableView alloc]initWithFrame:CGRectMake(150, 330, se3TitleBtn1.frame.size.width, 300)];
    titleTabv1.delegate = self;
    titleTabv1.dataSource = self;
    titleTabv1.hidden = YES;
    //    titleTabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:titleTabv1];

//
//    self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(700, 50, 60, 210)];
//    self.shoucangview.hidden = YES;
//    [self.view addSubview:self.shoucangview];
//    
//    int y = 0;
//    for (int i = 0; i < 7; i ++) {
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 60, 30)];
//        btn.tag = i;
//        [btn setTitle:titlearr[i] forState:UIControlStateNormal];
//        btn.layer.borderColor = [UIColor blackColor].CGColor;
//        btn.layer.borderWidth = 1;
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//        [self.shoucangview addSubview:btn];
//        y += 30;
//    }

}

-(void)searchBtn1
{

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M132" forKey:@"method"];
    [requestDict setValue:self.m004Dic[@"courses"][selint][@"courseId"]?self.m004Dic[@"courses"][selint][@"courseId"]:@"" forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)action:(UIButton *)sender
{
    
}

-(void)shoucang
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M131" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:titleTf.text forKey:@"collectTitile"];
    [requestDict setValue:contentTv.text forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%d",row] forKey:@"typeId"];
    [requestDict setValue:@"5" forKey:@"sourceId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];


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
        [self showTip:responseDict[@"responseMessage"]];
    }
    if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.m004Dic = responseDict;
        [titleTabv1 reloadData];
        se3TitleLb1.text = self.m004Dic[@"courses"][0][@"course"];
        NSLog(@"self.m004Dic===%@",self.m004Dic);
    }
    if ([@"M132" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];

        self.m132Arr = responseDict[@"collects"];
        
        [titleTabv2 reloadData];
        
        NSLog(@"self.m132Arr===%@",self.m132Arr);

    }
    if ([@"M132" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }
    if ([@"M133" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏修改成功"];
        [self performSelector:@selector(resh) withObject:nil afterDelay:2];
    }
    if ([@"M133" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }
    
    if ([@"M134" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏删除成功"];
        [self performSelector:@selector(resh) withObject:nil afterDelay:2];
    }
    if ([@"M134" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }
}

-(void)resh
{
    [self searchBtn1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == titleTabv2) {
        return 140;
    }
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
    }else if (tableView == titleTabv1){
    
        return [self.m004Dic[@"courses"] count];
    }else if (tableView == titleTabv2) {
    
       return [self.m132Arr count];
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
    }else if(tableView == titleTabv1){
    
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        }
        
        cell.textLabel.text = self.m004Dic[@"courses"][indexPath.row][@"course"];

        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell2";
        
        ZMwodeshoucangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[ZMwodeshoucangTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
            
            UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60 + 10, 140)];
            type.tag = 200;
            type.font = [UIFont systemFontOfSize:16];
            type.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:type];
            
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(65+ 10, 0, 1, 140)];
            line1.backgroundColor = [UIColor blackColor];
            [cell.contentView addSubview:line1];
            
            UILabel *titile = [[UILabel alloc]initWithFrame:CGRectMake(70+ 10, 0, 220 + 10+ 10, 140)];
            titile.tag = 201;
            titile.font = [UIFont systemFontOfSize:16];
            titile.textAlignment = NSTextAlignmentCenter;

            [cell.contentView addSubview:titile];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(300+ 10+ 10+ 10, 0, 1, 140)];
            line2.backgroundColor = [UIColor blackColor];
            [cell.contentView addSubview:line2];
            
            
            UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(310+ 10+ 10+ 10, 0, 80, 140)];
            score.tag = 202;
            score.font = [UIFont systemFontOfSize:16];
            score.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:score];
            
            UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(400+ 10+ 10+ 10, 0, 1, 140)];
            line3.backgroundColor = [UIColor blackColor];
            [cell.contentView addSubview:line3];
            
            
            UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(700+ 10+ 10+ 10 + 50 + 40, 0, 1, 140)];
            line4.backgroundColor = [UIColor blackColor];
            [cell.contentView addSubview:line4];
            
//            UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(800+ 10+ 10+ 10 + 50, 0, 1, 100)];
//            line5.backgroundColor = [UIColor blackColor];
//            [cell.contentView addSubview:line5];
            
            UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(0, 139, titleTabv2.frame.size.width, 1)];
            line6.backgroundColor = [UIColor blackColor];
            [cell.contentView addSubview:line6];
            
        }

        UILabel *type = [cell.contentView viewWithTag:200];
        
        type.text = self.m132Arr[indexPath.row][@"typeName"];
        
        UILabel *type1 = [cell.contentView viewWithTag:201];
        type1.text = [NSString stringWithFormat:@"%@(%@)",self.m132Arr[indexPath.row][@"collectTitle"],self.m132Arr[indexPath.row][@"author"]];

        UILabel *type2 = [cell.contentView viewWithTag:202];
        type2.text = self.m132Arr[indexPath.row][@"sourceName"];
        
        cell.dic = self.m132Arr[indexPath.row];

        
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
        
        row = indexPath.row + 1;
        
    }else if (tableView == titleTabv1){
        titleTabv1.hidden = YES;
        hidden1 = YES;
        se3TitleLb1.text = self.m004Dic[@"courses"][indexPath.row][@"course"];
        selint = (int)indexPath.row;
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
