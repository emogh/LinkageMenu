//
//  ViewController.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/7.
//  Copyright © 2017年 EmotionV. All rights reserved.
//  github: https://github.com/EmotionV/LinkageMenu

#import "ViewController.h"
#import "LinkageMenuView.h"
#import "OneView.h"
#import "TwoView.h"
#import "OneCollectionViewCell.h"
#define FUll_VIEW_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define FUll_VIEW_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define NAVIGATION_HEIGHT 64  //navigationbar height
#define TABBAR_HEIGHT 49  //tabbar height

@interface ViewController ()

@property (strong,nonatomic) OneView *oneView;
@property (strong,nonatomic) OneView *twoView;
@property (strong,nonatomic) TwoView *threeView;
@property (strong,nonatomic) UIView *fourView;
@property (strong,nonatomic) OneView *fiveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //example view 1
    _oneView = [[OneView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH - 101, FUll_VIEW_HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT)];
    _oneView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    //example view 2
    _twoView = [[OneView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH - 101, FUll_VIEW_HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT)];
    _twoView.dataArray = @[@"11",@"22",@"33",@"44",@"55",@"66",@"77",@"88"];

    //example view 3
    _threeView = [[TwoView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH - 101, FUll_VIEW_HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT) style:UITableViewStylePlain];
    
    //example view 4
    _fourView = [[UIView alloc] init];
    _fourView.backgroundColor = [UIColor redColor];

    //example view 5
    _fiveView = [[OneView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH - 101, FUll_VIEW_HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT)];
    _fiveView.dataArray = @[@"11",@"22",@"33",@"44",@"55",@"66",@"77",@"88",@"99",@"1010"];
    
    //views array
    NSArray *views = @[_oneView,_twoView,_threeView,_fourView,_fiveView];
    
    //if views count less than menu count, leftover views will load the last view of the views
    //如果view数量少于标题数量，剩下的view会默认加载view数组的最后一个view
    LinkageMenuView *lkMenu = [[LinkageMenuView alloc] initWithFrame:CGRectMake(0, 0,FUll_VIEW_WIDTH , FUll_VIEW_HEIGHT - TABBAR_HEIGHT) WithMenu:@[@"为您推荐",@"美容美妆",@"奶粉纸尿裤",@"母婴专区",@"箱包配饰",@"家居个护",@"营养保健",@"服饰鞋靴",@"海外直邮",@"数码家电",@"环球美食",@"运动户外",@"生鲜",@"国家馆",@"品牌馆"] andViews:views];

//    lkMenu.textSize = 11;
//    lkMenu.textColor = [UIColor blueColor];
//    lkMenu.selectTextColor = [UIColor redColor];
//    lkMenu.bottomViewColor = [UIColor yellowColor];
    
    [self.view addSubview:lkMenu];
    
}

@end
