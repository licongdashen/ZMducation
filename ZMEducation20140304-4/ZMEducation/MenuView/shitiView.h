#import "UIKit/UIKit.h"
#import "UIExpandingTextView.h"
#import "ZMHttpEngine.h"
#import "ZMAppDelegate.h"
#import "ZMBaseViewController.h"

@interface shitiView : ZMBaseViewController<UIExpandingTextViewDelegate,ZMHttpEngineDelegate>
{
    //NSString * _answerStr;
    //UIExpandingTextView * tf_answer;
    NSMutableArray * _answerInput;
    NSMutableArray * _checkBox;
    NSArray * _answerArr;
    NSString *nameStr;
    NSString *contentStr;
}


@property(nonatomic,assign)NSArray  * answerArr;
@property(nonatomic,assign)int questionId;
@property(nonatomic,assign)int questionType;
@property (nonatomic, strong) UIButton *shoucangBtn;
@property (nonatomic, strong) UIView *shoucangview;
@property (nonatomic, strong) NSDictionary *shiti;
@property (nonatomic, strong) UIScrollView *scro;

-(id)initWithQuestion:(NSDictionary * )shiti frame:(CGRect)frame;
@end
