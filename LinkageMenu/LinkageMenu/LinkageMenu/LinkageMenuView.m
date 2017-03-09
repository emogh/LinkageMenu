//
//  LinkageMenuView.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/8.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "LinkageMenuView.h"
#define MENU_WIDTH 100  //left menu width
#define BOTTOMVIEW_HEIGHT 25  //bottom selected view height
#define BOTTOMVIEW_WIDTH (MENU_WIDTH - 10)  //bottom selected view width
#define LINEVIEW_WIDTH 1.0  //separator line view width

#define FULLVIEW_FOR6 667   //iPhone6(s) height

#define NAVIGATION_HEIGHT 64  //navigationbar height
#define TARBAR_HEIGHT 49  //tabbar height


#define ANIMATION_TIME 0.2  //menu scrollview animation time

#define FUll_VIEW_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define FUll_VIEW_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)

@interface LinkageMenuView()

@property (nonatomic, strong) UIScrollView *menuView;  /**< menu view */
@property (nonatomic, strong) UIView *bottomView;  /**< selected back view */
@property (nonatomic, strong) UIView *lineView;  /**< separator line */

@end

@implementation LinkageMenuView{
    NSArray *menuArray;
    NSInteger titlesCount; //menu count
    NSInteger newChoseTag;  //tag of this time selected
    NSInteger choseTag;  //tag of last time selected
    float btnHeight;  //change button height to fit different screen
    NSInteger DTScrollTag; //dont scroll until tag+1
    float blankHeight;
    float half_blankHeight;
}

- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray *)menu{
    if (self = [super init]) {
        if (FUll_VIEW_HEIGHT < FULLVIEW_FOR6) {
            btnHeight = 43;
            DTScrollTag = 5;
        }else if (FUll_VIEW_HEIGHT == FULLVIEW_FOR6){
            btnHeight = 44;
            DTScrollTag = 6;
        }else if (FUll_VIEW_HEIGHT > FULLVIEW_FOR6){
            btnHeight = 42.7;
            DTScrollTag = 7;
        }
        menuArray = menu;
        titlesCount = menuArray.count;
        blankHeight = btnHeight - BOTTOMVIEW_HEIGHT;
        half_blankHeight = (btnHeight - BOTTOMVIEW_HEIGHT) / 2.0;
        choseTag = 1;  //acquiesce selected button is 1
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
        _menuView.scrollsToTop = NO;
        _menuView.showsVerticalScrollIndicator = NO;
        
        _menuView.contentSize = CGSizeMake(0, titlesCount * btnHeight + blankHeight + 5.0);

        _bottomView = [[UIView alloc] initWithFrame:CGRectMake((MENU_WIDTH - BOTTOMVIEW_WIDTH) / 2.0, blankHeight + 1.0,BOTTOMVIEW_WIDTH , BOTTOMVIEW_HEIGHT)];
        _bottomView.layer.cornerRadius = BOTTOMVIEW_HEIGHT / 2.0;
        _bottomView.backgroundColor = [UIColor colorWithRed:43.0/225.0 green:31.0/225.0 blue:92.0/225.0 alpha:1.0];
        [_menuView addSubview:_bottomView];
        
        for (int i = 1; i <= menuArray.count; i++) {
            UIButton *menuButton = [[UIButton alloc] init];
            menuButton.tag = i;
            menuButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [menuButton setTitle:[menuArray objectAtIndex:(i - 1)] forState:UIControlStateNormal];
            [menuButton setBackgroundColor:[UIColor clearColor]];
            menuButton.frame = CGRectMake(0, btnHeight * (i - 1) + half_blankHeight + 1.0, MENU_WIDTH, btnHeight);
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
        
        float scroHeight = _menuView.contentSize.height - FUll_VIEW_HEIGHT + TARBAR_HEIGHT;
        if (button.tag <= DTScrollTag) {
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                [_menuView setContentOffset:CGPointMake(0,- NAVIGATION_HEIGHT) animated:NO];
            }];
            
        }else if (button.tag > menuArray.count - DTScrollTag){
            
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                [_menuView setContentOffset:CGPointMake(0, scroHeight) animated:NO];
            }];
        }else if(button.tag == DTScrollTag + 1){
            
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                [_menuView setContentOffset:CGPointMake(0,- NAVIGATION_HEIGHT + blankHeight + 1.0) animated:NO];
            }];
            
        }else if (button.tag > DTScrollTag + 1 && button.tag < menuArray.count - DTScrollTag){
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                [_menuView setContentOffset:CGPointMake(0,- NAVIGATION_HEIGHT + blankHeight + 1.0 + button.frame.size.height * (button.tag - DTScrollTag - 1)) animated:NO];
            }];
        }else if (button.tag == menuArray.count - DTScrollTag){
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                [_menuView setContentOffset:CGPointMake(0, scroHeight - blankHeight) animated:NO];
            }];
        }

        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _bottomView.frame = CGRectMake((MENU_WIDTH - BOTTOMVIEW_WIDTH) / 2.0,button.frame.origin.y +  half_blankHeight, BOTTOMVIEW_WIDTH, BOTTOMVIEW_HEIGHT);
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
