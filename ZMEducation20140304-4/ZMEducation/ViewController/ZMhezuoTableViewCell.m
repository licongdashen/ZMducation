//
//  ZMhezuoTableViewCell.m
//  ZMEducation
//
//  Created by Queen on 2017/2/24.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMhezuoTableViewCell.h"

@implementation ZMhezuoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.se3SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
        [self addSubview:self.se3SelBtn];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
