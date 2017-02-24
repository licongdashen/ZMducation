//
//  ZMhezuo1TableViewCell.m
//  ZMEducation
//
//  Created by Queen on 2017/2/24.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMhezuo1TableViewCell.h"

@implementation ZMhezuo1TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.se3SelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Btn"] forState:UIControlStateNormal];
        [self.se3SelBtn setImage:[UIImage imageNamed:@"Share_Select_Btn"] forState:UIControlStateSelected];
        [self.se3SelBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.se3SelBtn];
        
        self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 400, 30)];
        self.titleLb.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLb];
        
        self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, 400, 65)];
        self.contentLb.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.contentLb];

    }
    
    return self;
}

-(void)setHezuo1dic:(NSMutableDictionary *)hezuo1dic
{
    _hezuo1dic = hezuo1dic;
    self.titleLb.text = [NSString stringWithFormat:@"%@(%@):",_hezuo1dic[@"author"],_hezuo1dic[@"groupName"]];

    self.contentLb.text = [NSString stringWithFormat:@"%@",_hezuo1dic[@"forumContent"]];
}

-(void)setHezuoarr:(NSMutableArray *)hezuoarr
{
    _hezuoarr = hezuoarr;
}

-(void)setHezuodic:(NSMutableDictionary *)hezuodic
{
    _hezuodic = hezuodic;
    if ([[NSString stringWithFormat:@"%@",_hezuodic[@"flag"]] isEqualToString:@"1"]){
        [self.se3SelBtn setSelected:YES];
    }else{
        [self.se3SelBtn setSelected:NO];
    }
}

-(void)action
{
    NSMutableDictionary *dic = _hezuodic;

    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]){
        [dic setValue:@"0" forKey:@"flag"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"youyou" object:nil];
        return;
    }
    for (NSMutableDictionary *dic in self.hezuoarr) {
        [dic setObject:@"0" forKey:@"flag"];
    }
    if ([[NSString stringWithFormat:@"%@",dic[@"flag"]] isEqualToString:@"1"]) {
    }else {
        [dic setValue:@"1" forKey:@"flag"];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"youyou" object:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
