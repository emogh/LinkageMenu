//
//  LinkageMenuView.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/8.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "LinkageMenuView.h"
#define MENU_WIDTH 100
#define BOTTOMVIEW_HEIGHT 25
#define BOTTOMVIEW_WIDTH 90
#define LINEVIEW_WIDTH 1.0

#define FULLVIEW_FOR5 568 //iPhone5(s) height
#define FULLVIEW_FOR6 667 //iPhone6(s) height

#define FUll_VIEW_WIDTH     ([[UIScreen mainScreen] bounds].size.width) //screen width
#define FUll_VIEW_HEIGHT    ([[UIScreen mainScreen] bounds].size.height) //screen height

@interface LinkageMenuView()

@property (nonatomic, strong) UIScrollView *menuView;  /**< 菜单 */
@property (nonatomic, strong) UIView *bottomView;  /**< 选择的背景视图 */
@property (nonatomic, strong) UIView *lineView;  /**< 竖线 */
@property (nonatomic, strong) UIView *contentView;  /**< 右边内容视图 */
@end

@implementation LinkageMenuView{
    NSArray *menuArray;
    NSInteger newChoseTag;//当前选中button的tag
    NSInteger choseTag;//上次选中button的tag
    float btnHeight; //适配不同屏幕调整button高度
}

- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray *)menu{
    if (self = [super init]) {
        if (FUll_VIEW_HEIGHT <= FULLVIEW_FOR5) {
            btnHeight = 47.5;
        }else if (FUll_VIEW_HEIGHT == FULLVIEW_FOR6){
            btnHeight = 44;
        }else if (FUll_VIEW_HEIGHT > FULLVIEW_FOR6){
            btnHeight = 46;
        }
        menuArray = menu;
        choseTag = 1;//默认选中第一个
        self.frame = frame;
        [self addSubview:self.menuView];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(MENU_WIDTH, 0, LINEVIEW_WIDTH, self.frame.size.height)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIScrollView *)menuView{
    if (!_menuView) {
        _menuView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MENU_WIDTH, self.frame.size.height)];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.scrollsToTop = NO;
        _menuView.showsVerticalScrollIndicator = NO;
        NSInteger titlesCount = menuArray.count;
        _menuView.contentSize = CGSizeMake(0, titlesCount * btnHeight + (btnHeight - BOTTOMVIEW_HEIGHT) + 5.0);

        _bottomView = [[UIView alloc] initWithFrame:CGRectMake((MENU_WIDTH - BOTTOMVIEW_WIDTH) / 2.0,(btnHeight - BOTTOMVIEW_HEIGHT) / 2.0 * 2.0 + 1.0,BOTTOMVIEW_WIDTH , BOTTOMVIEW_HEIGHT)];
        _bottomView.layer.cornerRadius = BOTTOMVIEW_HEIGHT / 2.0;
        _bottomView.backgroundColor = [UIColor colorWithRed:43.0/225.0 green:31.0/225.0 blue:92.0/225.0 alpha:1.0];
        [_menuView addSubview:_bottomView];
        
        for (int i = 1; i <= menuArray.count; i++) {
            UIButton *menuButton = [[UIButton alloc] init];
            menuButton.tag = i;
            menuButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [menuButton setTitle:[menuArray objectAtIndex:(i - 1)] forState:UIControlStateNormal];
            [menuButton setBackgroundColor:[UIColor clearColor]];
            menuButton.frame = CGRectMake(0, btnHeight * (i - 1) + (btnHeight - BOTTOMVIEW_HEIGHT) / 2.0 + 1.0, MENU_WIDTH, btnHeight);
            if (i == 1) {
                [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [menuButton addTarget:self action:@selector(choseMenu:) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:menuButton];
        }
    }
    return _menuView;
}

- (void)choseMenu:(UIButton *)button{
    NSLog(@"==%ld,%@",(long)button.tag,button.titleLabel.text);
    newChoseTag = button.tag;
    
    if (newChoseTag != choseTag) {
        UIButton *lastButton = (UIButton *)[self viewWithTag:choseTag];
        [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _bottomView.frame = CGRectMake((MENU_WIDTH - BOTTOMVIEW_WIDTH) / 2.0,button.frame.origin.y +  (btnHeight - BOTTOMVIEW_HEIGHT) / 2.0, BOTTOMVIEW_WIDTH, BOTTOMVIEW_HEIGHT);
        } completion:nil];
        [self performSelector:@selector(delayChangeTextColor) withObject:nil afterDelay:0.07];
    }
}

- (void)delayChangeTextColor{
        UIButton *button = (UIButton *)[self viewWithTag:newChoseTag];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        choseTag = newChoseTag;
}

@end
