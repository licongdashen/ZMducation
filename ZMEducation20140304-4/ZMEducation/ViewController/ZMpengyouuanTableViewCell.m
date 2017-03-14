//
//  ZMpengyouuanTableViewCell.m
//  ZMEducation
//
//  Created by 李聪 on 2017/3/8.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMpengyouuanTableViewCell.h"

@implementation ZMpengyouuanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.se3SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
        [self.se3SelBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.se3SelBtn];

        self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 400, 30)];
        self.nameLb.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.nameLb];

        self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 900, 100)];
        self.contentLb.font = [UIFont systemFontOfSize:16];
        self.contentLb.numberOfLines = 6;
        [self addSubview:self.contentLb];

    }
    
    return self;
}

-(void)setDic1:(NSMutableDictionary *)dic1
{
    _dic1 = dic1;
    if ([[NSString stringWithFormat:@"%@",_dic1[@"flag"]] isEqualToString:@"1"]){
        [self.se3SelBtn setSelected:YES];
    }else{
        [self.se3SelBtn setSelected:NO];
    }
}

-(void)action
{
    if ([[NSString stringWithFormat:@"%@",_dic1[@"flag"]] isEqualToString:@"1"]){
        [_dic1 setObject:@"0" forKey:@"flag"];
    }else{
        [_dic1 setObject:@"1" forKey:@"flag"];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"youyouyou" object:nil];

}

-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    
    self.nameLb.text = [NSString stringWithFormat:@"%@:%@(%@)",dic[@"author"],dic[@"detailTitle"],dic[@"voteCount"]];
    self.contentLb.text = dic[@"detailContent"];
}

-(void)setArr:(NSMutableArray *)arr
{
    _arr = arr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
