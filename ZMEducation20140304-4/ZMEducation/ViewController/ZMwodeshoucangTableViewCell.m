//
//  ZMwodeshoucangTableViewCell.m
//  ZMEducation
//
//  Created by Queen on 2017/3/3.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMwodeshoucangTableViewCell.h"

@implementation ZMwodeshoucangTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.tv = [[UITextView alloc]initWithFrame:CGRectMake(420 + 20, 0, 250 + 50, 100)];
        self.tv.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tv];

        self.baocunBtn = [[UIButton alloc]initWithFrame:CGRectMake(720+ 20+ 10 + 50, 10, 50, 25)];
        [self.baocunBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.baocunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.baocunBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.baocunBtn.layer.borderWidth = 1;
        [self.baocunBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.baocunBtn];
        
        self.shanchuBtn = [[UIButton alloc]initWithFrame:CGRectMake(720+ 20+ 10 + 50, 45, 50, 25)];
        [self.shanchuBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.shanchuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.shanchuBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.shanchuBtn.layer.borderWidth = 1;
        [self.shanchuBtn addTarget:self action:@selector(shanchu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shanchuBtn];

    }
    
    return self;
}

-(void)save
{
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithDictionary:_dic];
    [dic1 setObject:self.tv.text forKey:@"collectContent"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yqq" object:nil userInfo:dic1];
}

-(void)shanchu
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yqq1" object:nil userInfo:_dic];
}

-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    
    self.tv.text = _dic[@"collectContent"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
