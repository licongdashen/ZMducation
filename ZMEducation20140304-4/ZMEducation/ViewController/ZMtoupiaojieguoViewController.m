//
//  ZMtoupiaojieguoViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/13.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMtoupiaojieguoViewController.h"

@interface ZMtoupiaojieguoViewController ()
{
    UITableView* se4Tabv;
    UILabel *titlelabel;
    
}
@property (nonatomic, strong)NSMutableArray *arr;

@property int count1;

@end

@implementation ZMtoupiaojieguoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    self.arr = [[NSMutableArray alloc]init];
    
    titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    titlelabel.font = [UIFont boldSystemFontOfSize:20];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = self.str;
    [self.view addSubview:titlelabel];
    
    UIButton* refishBtn = [[UIButton alloc]initWithFrame:CGRectMake(800, 120, 50, 25)];
    [refishBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refishBtn addTarget:self action:@selector(refish) forControlEvents:UIControlEventTouchUpInside];
    refishBtn.layer.borderColor = [UIColor blackColor].CGColor;
    refishBtn.layer.borderWidth = 1;
    [self.view addSubview:refishBtn];
    
    se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width - 100, self.view.frame.size.height - 100)];
    se4Tabv.delegate = self;
    se4Tabv.dataSource = self;
    se4Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    se4Tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:se4Tabv];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:self.dic1];
    [httpEngine release];

    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];

}

-(void)refish
{
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:self.dic1];
    [httpEngine release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.dic[@"forumSubTitles"][0][@"forumContents"] count];
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
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 100, 0, 120, 30)];
        nameLb.tag = 201;
        nameLb.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:nameLb];
        
        UILabel *countLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
        countLb.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        [cell.contentView addSubview:countLb];
        
        UILabel *countLb1 = [[UILabel alloc]initWithFrame:CGRectZero];
        countLb1.tag = 202;
        countLb1.backgroundColor = [UIColor colorWithRed:85/255.0f green:166/255.0f blue:239/255.0f alpha:1.0];
        [cell.contentView addSubview:countLb1];
        
    }
    
    UILabel *label = [cell.contentView viewWithTag:200];
    label.text = [NSString stringWithFormat:@"%@(%@):%@票",self.dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"author"],self.dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"groupName"],[NSString stringWithFormat:@"%@",self.dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"voteCount"]]];;
    
    //    UILabel *label1 = [cell.contentView viewWithTag:201];
    //    label1.text = [NSString stringWithFormat:@"%@票",self.dic[@"groupNames"][indexPath.row][@"voteCount"]];
    
    UILabel *labe2 = [cell.contentView viewWithTag:202];
    labe2.frame = CGRectMake(0, 30,((float)[self.dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"voteCount"] intValue]/self.count1)*800, 30);
    labe2.text = [NSString stringWithFormat:@"%g%%",((float)[self.dic[@"forumSubTitles"][0][@"forumContents"][indexPath.row][@"voteCount"] intValue])/self.count1*100];
    
    return cell;
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M125" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        self.dic = (NSMutableDictionary *)responseDict;
        NSLog(@"m125dic===%@",self.dic);
        self.count1 = 0;
        
        for (NSDictionary *dic in self.dic[@"forumSubTitles"][0][@"forumContents"]) {
            self.count1 += [dic[@"voteCount"] intValue];
        }
        
        [se4Tabv reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
