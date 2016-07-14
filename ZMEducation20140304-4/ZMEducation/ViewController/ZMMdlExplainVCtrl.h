//#import <UIKit/UIKit.h>
#import "ZMArticleBaseViewController.h"

@interface ZMMdlExplainVCtrl : ZMArticleBaseViewController
{
   
    UIExpandingTextView * TF_Draft_Title ;
    UIExpandingTextView  * TV_Draft_Content ;
    
    NSMutableArray * article_Contents_Arr;
     NSMutableArray * article_Comments_Arr;
    
    
}



@end