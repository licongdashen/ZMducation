#import "UIKit/UIKit.h"
#import "UIExpandingTextView.h"

@interface shitiView : UIView<UIExpandingTextViewDelegate>
{
    //NSString * _answerStr;
    //UIExpandingTextView * tf_answer;
    NSMutableArray * _answerInput;
    NSMutableArray * _checkBox;
    NSArray * _answerArr;
}


@property(nonatomic,assign)NSArray  * answerArr;
@property(nonatomic,assign)int questionId;
@property(nonatomic,assign)int questionType;
@property (nonatomic, strong) UIButton *shoucangBtn;

-(id)initWithQuestion:(NSDictionary * )shiti frame:(CGRect)frame;
@end
