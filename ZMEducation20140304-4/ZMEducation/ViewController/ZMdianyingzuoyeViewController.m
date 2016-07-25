//
//  ZMdianyingzuoyeViewController.m
//  ZMEducation
//
//  Created by Queen on 16/7/25.
//  Copyright © 2016年 99Bill. All rights reserved.
//

#import "ZMdianyingzuoyeViewController.h"

@interface ZMdianyingzuoyeViewController ()
@property (nonatomic, strong) UIExpandingTextView * TV_Bk1;
@property (nonatomic, strong) UIExpandingTextView * TV_Bk2;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *contentImagv;

@end

@implementation ZMdianyingzuoyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)addCommentView
{
    NSLog(@"ffggggggg%@",gousiDict);
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [articleView addSubview:article_Category_View];
    [article_Category_View release];
    
    self.titleLb = [[UILabel alloc]initWithFrame:article_Category_View.bounds];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    [article_Category_View addSubview:self.titleLb];
    self.titleLb.text = gousiDict[@"unitTitle"];
    
    UIImageView *titleImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100,article_Category_View.frame.origin.y + article_Category_View.frame.size.height + 20 , self.view.frame.size.width - 200, 60)];
    titleImagv.image = [UIImage imageNamed:@"Article_Item_11"];
    titleImagv.userInteractionEnabled = NO;
    [articleView addSubview:titleImagv];
    
    self.TV_Bk1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(120, 10 , titleImagv.frame.size.width - 120, 40)];
    self.TV_Bk1.font = [UIFont systemFontOfSize:18];
    self.TV_Bk1.backgroundColor = [UIColor clearColor];
    self.TV_Bk1.text = gousiDict[@"title"];
    [titleImagv addSubview:self.TV_Bk1];
    
    self.contentImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100,titleImagv.frame.origin.y + titleImagv.frame.size.height + 20 , self.view.frame.size.width - 200, 500)];
    self.contentImagv.image = [UIImage imageNamed:@"Article_Item_12"];
    self.contentImagv.userInteractionEnabled = NO;
    self.contentImagv.tag = 300;
    [articleView addSubview:self.contentImagv];
    
    self.TV_Bk2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(60, 60 , self.contentImagv.frame.size.width - 120, self.contentImagv.frame.size.height - 120)];
    self.TV_Bk2.font = [UIFont systemFontOfSize:18];
    self.TV_Bk2.backgroundColor = [UIColor clearColor];
    self.TV_Bk2.text = gousiDict[@"articleDraft"];
    [self.contentImagv addSubview:self.TV_Bk2];

}

-(void)addDraftView
{
    
}

-(void)addContentView
{
    
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
