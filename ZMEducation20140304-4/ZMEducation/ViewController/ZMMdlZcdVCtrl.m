#import "ZMMdlZcdVCtrl.h"
#import "ZcdQueryCharacter.h"
#import "ZcdQueryWord.h"
#import "ZcdQueryPhrase.h"
#import "ZcdQueryPoem.h"
#import "ZcdQueryTruth.h"
#import "ZcdQueryFolks.h"

#define kTagTypeSelectBtn 6660
#define kTagTypeTableView 6670
#define kTagQueryView 9999
#define kTagBtnZyk 9797
@implementation ZMMdlZcdVCtrl

@synthesize zcdDelegate = _zcdDelegate;

-(void)initTypeArr
{

    type_Arr = [[NSMutableArray alloc]init];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"字典",@"name",
                         @"10",@"code",
                         nil]];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"词典",@"name",
                         @"20",@"code",
                         nil]];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"成语",@"name",
                         @"30",@"code",
                         nil]];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"诗词",@"name",
                         @"40",@"code",
                         nil]];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"名言",@"name",
                         @"50",@"code",
                         nil]];
    [type_Arr addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"俗语",@"name",
                         @"60",@"code",
                         nil]];

}

-(void)loadView
{
    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initTypeArr];
  
    
    {
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        IV_Bg.image = [UIImage imageNamed:@"bg_zcd.png"];
        [self.view addSubview:IV_Bg];
        [IV_Bg release];
    }
    
    {
        UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
        UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
        [article_Category_View setImage:article_Category_Image];
        [self.view addSubview:article_Category_View];
        [article_Category_View release];
        
        [self addLabel:@"字词典"
                 frame:CGRectMake(291, 20, 421, 30)
                  size:18
              intoView:self.view];
    }
    {
        UIButton* typeSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeSelectBut setTag:kTagTypeSelectBtn];
        [typeSelectBut setFrame:CGRectMake(128, 133, 125, 40)];
        [typeSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [typeSelectBut setTitle:@"选择类型" forState:UIControlStateNormal];
        [typeSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [typeSelectBut addTarget:self
                            action:@selector(typeSelectClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeSelectBut];
        
    }
    

    
    {
        UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBut setFrame:CGRectMake(948, 46, 49, 49)];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [closeBut addTarget:self
                     action:@selector(closeClick:)
           forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeBut];
    }

   
    
    
    //[self getHistoryList];
    
    //默认载入字典查询条件
    ZcdQueryCharacter * viewQueryCharacter = [[ZcdQueryCharacter alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
    viewQueryCharacter.tag = kTagQueryView;
    [self.view addSubview:viewQueryCharacter];
    
    {
        UIButton * zyk_But = [UIButton buttonWithType:UIButtonTypeCustom];
        zyk_But.tag = kTagBtnZyk;
        [zyk_But setFrame:CGRectMake(873, 719, 315, 40)];
        [zyk_But addTarget:self action:@selector(zykClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zyk_But];
    }

    
}

-(void)queryClick:(id)sender
{
    NSString * queryType = [type_Arr[typeSelectIndex] objectForKey:@"code"];
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    [queryConditions addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",
                               @"b",@"value",
                                @"1",@"matchMode",
                               nil]];
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    

    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:[userDict objectForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict objectForKey:@"currentCourseId"] forKey:@"courseId"];
    
    [requestDict setValue:queryType forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"1" forKey:@"returnMode"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];


}


-(IBAction)closeClick:(id)sender
{
    [_zcdDelegate zcdViewDidClose:self];

}

-(void)zykViewDidClose:(ZMMdlZykVCtrl*)viewController{
    [_zcdDelegate zcdViewDidClose:self];

}


-(void)zykClick:(id)sender
{
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M066" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

    
}

-(void)getHistoryList
{

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M055" forKey:@"method"];
    [requestDict setValue:@"dictionary" forKey:@"type"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if(([@"M055" isEqualToString:method] && [@"00" isEqualToString:responseCode]))
    {
        
    }
    else if([@"M054" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    {
        
        
    }else if ([@"M066" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSString * statusStr = [responseDict valueForKey:@"library"];
        if([@"01" isEqualToString:statusStr]){
            ZMMdlZykVCtrl * zykViewCtrl = [[ZMMdlZykVCtrl alloc]init];
            zykViewCtrl.delegate = self;
            [self.navigationController pushViewController:zykViewCtrl animated:YES];
        }else{
            [self showTip:@"暂无内容！"];
        }
        
        
    }
    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
    
    //[super hideIndicator];
}

-(IBAction)typeSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView* courseTableView = [[UITableView alloc] initWithFrame:frame];
    
    [courseTableView setTag:kTagTypeTableView];
    courseTableView.delegate = self;
    courseTableView.dataSource = self;
    [tableViewController setTableView:courseTableView];
    [courseTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    [popoverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    [tableViewController release];
}



#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"[tableDataSourceArray count]:%d",[_dataSource count]);
    int tag = tableView.tag;
    
    if (tag == kTagTypeTableView) {
        return [type_Arr count];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
    
    int tag = tableView.tag;
    if (tag == kTagTypeTableView) {
        NSDictionary* courseDict = [type_Arr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[courseDict valueForKey:@"name"]];
    }
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //int tag = tableView.tag;
    //    if (tag == kTagWorkTableView) {
    //        return 50;
    //    }
    return 39.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagTypeTableView) {
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagTypeSelectBtn];
        
        NSDictionary* courseDict = [type_Arr objectAtIndex:indexPath.row];
        [courseBtn setTitle:[courseDict valueForKey:@"name"] forState:UIControlStateNormal];
        typeSelectIndex= indexPath.row;
        //清除其他queryview
        {
            UIView * queryView = [self.view viewWithTag:kTagQueryView];
            [queryView removeFromSuperview];
        }
        switch ([[courseDict valueForKey:@"code"] intValue]) {
            case 10:
                
                {
                    ZcdQueryCharacter * viewQueryCharacter = [[ZcdQueryCharacter alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
                    viewQueryCharacter.tag = kTagQueryView;
                    
                    [self.view addSubview:viewQueryCharacter];
                }
                break;
            case 20:
                {
                    ZcdQueryWord * viewQueryWord = [[ZcdQueryWord alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195-50)];
                    viewQueryWord.tag = kTagQueryView;
                    [self.view addSubview:viewQueryWord];
                }
                
                break;
            case 30:
                {
                    ZcdQueryPhrase * viewQueryPhrase = [[ZcdQueryPhrase alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
                    viewQueryPhrase.tag = kTagQueryView;
                    [self.view addSubview:viewQueryPhrase];
                }
                
                break;
            case 40:
                {
                    ZcdQueryPoem * viewQueryPoem = [[ZcdQueryPoem alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
                    viewQueryPoem.tag = kTagQueryView;
                    [self.view addSubview:viewQueryPoem];
                }
                break;
            case 50:
                {
                    ZcdQueryTruth * viewQueryTruth = [[ZcdQueryTruth alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
                    viewQueryTruth.tag = kTagQueryView;
                    [self.view addSubview:viewQueryTruth];
                }
                break;
            case 60:
                {
                    ZcdQueryFolks * viewQueryFolks = [[ZcdQueryFolks alloc]initWithFrame:CGRectMake(0, 195, 1024, 768-195)];
                    viewQueryFolks.tag = kTagQueryView;
                    [self.view addSubview:viewQueryFolks];
                }
                
                break;
                
            default:
                break;
        }
        //把资源库btn放在最前面
        {
            UIView * queryView = [self.view viewWithTag:kTagBtnZyk];
            [self.view bringSubviewToFront:queryView];
        }
        
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end