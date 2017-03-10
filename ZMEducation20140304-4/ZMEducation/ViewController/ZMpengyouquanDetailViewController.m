//
//  ZMpengyouquanDetailViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/8.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMpengyouquanDetailViewController.h"
#import "ZMpengyouuanTableViewCell.h"

@interface ZMpengyouquanDetailViewController ()
{
    UILabel *label;
    UITableView *tabv1;
    UIButton *commmitBtn;
    UITableView *tabv2;

}

@property (nonatomic ,strong) NSDictionary *m137Dic;

@property (nonatomic ,strong) NSMutableArray *m137tempArr;

@end

@implementation ZMpengyouquanDetailViewController

-(void)notice
{
    [tabv1 reloadData];
    NSLog(@"self.m137tempArr===%@",self.m137tempArr);

}

-(void)commit
{
    [commmitBtn setTitle:@"已投票" forState:UIControlStateNormal];
    commmitBtn.enabled = NO;

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M138" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.dic[@"releaseId"] forKey:@"voteId"];
    [requestDict setValue:self.m137tempArr forKey:@"voteContent"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice) name:@"youyouyou" object:nil];
    
    self.m137tempArr = [[ NSMutableArray alloc]init];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
 
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30)];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

    tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 650, 300)];
    tabv1.delegate = self;
    tabv1.dataSource = self;
    tabv1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabv1.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:tabv1];
    

    
    commmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, 60, 30)];
    commmitBtn.center = CGPointMake(self.view.center.x, commmitBtn.center.y);
    [commmitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commmitBtn.layer.borderColor = [UIColor blackColor].CGColor;
    commmitBtn.layer.borderWidth = 1;
    [commmitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commmitBtn];
    
    tabv2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 450, 650, 300)];
    tabv2.delegate = self;
    tabv2.dataSource = self;
    tabv2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabv2.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:tabv2];
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];


    [self m137];

}

-(void)m137
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M137" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.dic[@"releaseId"] forKey:@"releaseId"];
    
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
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView == tabv1) {
        return [self.m137Dic[@"releases"] count];
    }else{
        return [self.m137Dic[@"releases"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == tabv1) {
        static NSString *CellIdentifier = @"Cell4";
        
        ZMpengyouuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[ZMpengyouuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        }
        
        cell.dic = self.m137Dic[@"releases"][indexPath.row];
        cell.arr = self.m137tempArr;
        cell.dic1 = self.m137tempArr[indexPath.row];
        
        return cell;

    }else {
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
            
            UILabel *labele = [[UILabel alloc]init];
            labele.tag = 200;
            labele.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:labele];
            
            UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
            nameLb.tag = 201;
            [cell.contentView addSubview:nameLb];
            
            UILabel *countLb = [[UILabel alloc]init];
            countLb.tag = 202;
            [cell.contentView addSubview:countLb];
            
        }
        UILabel *labeld = [cell.contentView viewWithTag:200];
        labeld.frame = CGRectMake(80, 5,[self.m137Dic[@"releases"][indexPath.row][@"voteCount"] intValue] * 20, 30);
        
        UILabel *label1 = [cell.contentView viewWithTag:201];
        label1.text = self.m137Dic[@"releases"][indexPath.row][@"author"];
        
        UILabel *labe22 = [cell.contentView viewWithTag:202];
        labe22.frame = CGRectMake(labeld.frame.size.width + labeld.frame.origin.x + 20, 0, 80, 40);
        labe22.text = [NSString stringWithFormat:@"%d票",[self.m137Dic[@"releases"][indexPath.row][@"voteCount"] intValue]];

        return cell;
    }
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M137" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.m137Dic = responseDict;
        NSLog(@"self.m137Dic===%@",self.m137Dic);
        label.text = self.m137Dic[@"sourceName"];
        
        
        if ([[NSString stringWithFormat:@"%@",self.m137Dic[@"ifVote"]] isEqualToString:@"1"]) {
            [commmitBtn setTitle:@"已投票" forState:UIControlStateNormal];
            commmitBtn.enabled = NO;
        }else{
            [commmitBtn setTitle:@"投票" forState:UIControlStateNormal];
            commmitBtn.enabled = YES;
        }
        
        [self.m137tempArr removeAllObjects];
        NSMutableArray *arr = self.m137Dic[@"releases"];
        for (NSMutableDictionary *dic in arr) {
            NSString *groupId = dic[@"detailId"];
            NSString *ifSelect = dic[@"ifSelect"];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:groupId,@"optionId",ifSelect,@"flag", nil];
            [self.m137tempArr addObject:mDic];
        }
        
        NSLog(@"self.m137tempArr===%@",self.m137tempArr);
        [tabv1 reloadData];
        [tabv2 reloadData];
    }else if ([@"M138" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self hideIndicator];
        [self showTip:@"投票成功"];
        [self m137];

    }
    if ([@"M138" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
