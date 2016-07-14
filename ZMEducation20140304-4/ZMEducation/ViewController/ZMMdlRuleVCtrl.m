#import "ZMMdlRuleVCtrl.h"


@implementation ZMMdlRuleVCtrl

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    {
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        IV_Bg.image = [UIImage imageNamed:@"bg_rule.png"];
        [self.view addSubview:IV_Bg];
    }
    
    {
        UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
        UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
        [article_Category_View setImage:article_Category_Image];
        [self.view addSubview:article_Category_View];
        [article_Category_View release];
        
        [self addLabel:@"评分规则"
                 frame:CGRectMake(291, 20, 421, 30)
                  size:18
              intoView:self.view];
    }
    
    {
        
        UIButton* backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setFrame:CGRectMake(950, 10, 47, 47)];
        [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Back_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Back_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [backBut addTarget:self
                    action:@selector(backClick:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBut];
    }
    {
       /* UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(180, 650, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBut];*/
    }
    {
       /* UIButton* query_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [query_But setFrame:CGRectMake(905, 93, 71, 61)];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [query_But addTarget:self
                      action:@selector(queryClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:query_But];*/
    }
  
    
}
-(IBAction)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end