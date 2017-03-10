//
//  ZMwengaoDetailViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/10.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMwengaoDetailViewController.h"

@interface ZMwengaoDetailViewController ()
{
    UITableView* se4Tabv;
    NSString *arr111;
    UILabel *titlelabel;

}
@end

@implementation ZMwengaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
//    se4Tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100)];
//    se4Tabv.delegate = self;
//    se4Tabv.dataSource = self;
//    se4Tabv.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
//    [self.view addSubview:se4Tabv];

    arr111 = @"";
    for (NSString *str in self.arr) {
        arr111 = [arr111 stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
    }
    
    titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    titlelabel.font = [UIFont boldSystemFontOfSize:20];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = self.str111;
    [self.view addSubview:titlelabel];
    
    UITextView *tvvv = [[UITextView alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
    tvvv.backgroundColor = [UIColor clearColor];
    tvvv.editable = NO;
    tvvv.text = arr111;
    [self.view addSubview:tvvv];
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
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
    return [self.arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
        
        UITextView *labele = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        labele.tag = 200;
        labele.font = [UIFont systemFontOfSize:15];
        labele.backgroundColor = [UIColor clearColor];
        labele.editable = NO;
        [cell.contentView addSubview:labele];
        
    }
    
    UITextView *tv= [cell.contentView viewWithTag:200];
    tv.text = self.arr[indexPath.row];
    
    return cell;
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
