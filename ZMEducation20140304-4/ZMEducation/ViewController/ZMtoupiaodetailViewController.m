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
}
@property (nonatomic, strong)NSDictionary *m112Dic;
@end

@implementation ZMtoupiaodetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100)];
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
    UILabel *label = [cell.contentView viewWithTag:200];
    label.frame = CGRectMake(80, 5,[self.m112Dic[@"groupNames"][indexPath.row][@"voteCount"] intValue] * 20, 30);
    
    UILabel *label1 = [cell.contentView viewWithTag:201];
    label1.text = self.m112Dic[@"groupNames"][indexPath.row][@"optionName"];
    
    UILabel *labe2 = [cell.contentView viewWithTag:202];
    labe2.frame = CGRectMake(label.frame.size.width + label.frame.origin.x + 20, 0, 80, 40);
    labe2.text = [NSString stringWithFormat:@"%d票",[self.m112Dic[@"groupNames"][indexPath.row][@"voteCount"] intValue]];

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
        [se4Tabv reloadData];
        
        NSLog(@"self.m112Dic===%@",self.m112Dic);

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
