//#import <UIKit/UIKit.h>
#import "ZMArticleBaseViewController.h"

@interface ZMMdlConceptionVCtrl : ZMArticleBaseViewController
{
    UIExpandingTextView * TF_Draft_Title ;
    UIExpandingTextView  * TV_Draft_Content ;
    NSMutableArray * article_Contents_Arr;
    NSMutableArray * article_Comments_Arr;

}


@end