//
//  ZMhezuoTableViewCell.m
//  ZMEducation
//
//  Created by Queen on 2017/2/24.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMhezuoTableViewCell.h"
#import "ZMAppDelegate.h"

@implementation ZMhezuoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.se3SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
        [self addSubview:self.se3SelBtn];
        
        self.shoucangBtn = [[UIButton alloc]initWithFrame:CGRectMake(210,10, 50, 30)];
        [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.shoucangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.shoucangBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.shoucangBtn.layer.borderWidth = 1;
        [self addSubview:self.shoucangBtn];
        
        if ([((ZMAppDelegate*)[UIApplication sharedApplication].delegate).str isEqualToString:@"02"]) {
            self.fabuBtn = [[UIButton alloc]initWithFrame:CGRectMake(280,10, 50, 30)];
            [self.fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
            [self.fabuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.fabuBtn.layer.borderColor = [UIColor blackColor].CGColor;
            self.fabuBtn.layer.borderWidth = 1;
            [self addSubview:self.fabuBtn];
        }
       
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
