//
//  ZMtoupiaodetailViewController.m
//  ZMEducation
//
//  Created by 李聪 on 2017/2/28.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMtoupiaodetailViewController.h"

@interface ZMtoupiaodetailViewController ()
{
    UITableView* se4Tabv;
    UILabel *titlelabel;
}
@property (nonatomic, strong)NSDictionary *m112Dic;
@property (nonatomic, strong)NSMutableArray *arr;

@property int count1;
@end

@implementation ZMtoupiaodetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [[NSMutableArray alloc]init];

    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    titlelabel.font = [UIFont boldSystemFontOfSize:20];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titlelabel];
    
    se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 100)];
    se4Tabv.delegate = self;
    se4Tabv.dataSource = self;
    se4Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    [self.view addSubview:se4Tabv];

    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];
    
    [self loadM112];
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
    return [self.m112Dic[@"groupNames"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        
        UILabel *labele = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 500, 30)];
        labele.tag = 200;
        [cell.contentView addSubview:labele];
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 120, 0, 120, 30)];
        nameLb.tag = 201;
        nameLb.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:nameLb];
        
        UILabel *countLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
        countLb.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        [cell.contentView addSubview:countLb];
        
        UILabel *countLb1 = [[UILabel alloc]initWithFrame:CGRectZero];
        countLb1.tag = 202;
        countLb1.textColor = [UIColor whiteColor];
        countLb1.backgroundColor = [UIColor colorWithRed:85/255.0f green:166/255.0f blue:239/255.0f alpha:1.0];
        [cell.contentView addSubview:countLb1];
        
    }
    
    UILabel *label = [cell.contentView viewWithTag:200];
    label.text = self.m112Dic[@"groupNames"][indexPath.row][@"optionName"];
    
    UILabel *label1 = [cell.contentView viewWithTag:201];
    label1.text = [NSString stringWithFormat:@"%@票",self.m112Dic[@"groupNames"][indexPath.row][@"voteCount"]];
    
    UILabel *labe2 = [cell.contentView viewWithTag:202];
    labe2.frame = CGRectMake(0, 30,((float)[self.m112Dic[@"groupNames"][indexPath.row][@"voteCount"] intValue]/self.count1)*800, 30);
    labe2.text = [NSString stringWithFormat:@"%g%%",((float)[self.m112Dic[@"groupNames"][indexPath.row][@"voteCount"] intValue]/self.count1)*100];
    
    return cell;
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
    [requestDict setValue:self.voteId forKey:@"voteId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
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

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M112" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        
        self.m112Dic = responseDict;
        
        self.count1 = 0;
        
        [self.arr removeAllObjects];
        for (NSMutableDictionary *dic in self.m112Dic[@"groupNames"]) {
            [self.arr addObject:dic[@"voteCount"]];
        }
        
        for (NSString *str in self.arr) {
            self.count1 += [str intValue];
        }
        
        titlelabel.text = self.m112Dic[@"voteTitle"];
        
         NSLog(@"self.m112Dic===%@",self.m112Dic);
        [se4Tabv reloadData];

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
