//
//  ViewController.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/7.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "ViewController.h"
#import "LinkageMenuView.h"
#define FUll_VIEW_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define FUll_VIEW_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    LinkageMenuView *lkmenu = [[LinkageMenuView alloc] initWithFrame:CGRectMake(0, 0,FUll_VIEW_WIDTH , FUll_VIEW_HEIGHT - 49) WithMenu:@[@"为您推荐",@"美容美妆",@"奶粉纸尿裤",@"母婴专区",@"箱包配饰",@"家居个护",@"营养保健",@"服饰鞋靴",@"海外直邮",@"数码家电",@"环球美食",@"运动户外",@"生鲜",@"国家馆",@"品牌馆"]];
    [self.view addSubview:lkmenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
