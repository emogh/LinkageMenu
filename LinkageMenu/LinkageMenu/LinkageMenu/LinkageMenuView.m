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
#define TABBAR_HEIGHT 49  //tabbar height


#define ANIMATION_TIME 0.2  //menu scrollview animation time

#define FUll_VIEW_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define FUll_VIEW_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)

@interface LinkageMenuView()

@property (nonatomic, strong) UIScrollView *menuView;  /**< menu view */
@property (nonatomic, strong) UIView *bottomView;  /**< selected back view */
@property (nonatomic, strong) UIView *lineView;  /**< separator line */
@property (nonatomic, strong) UIView *rightview;  /**< right view */
@end

@implementation LinkageMenuView{
    NSArray *menuArray;
    NSArray *viewArray;
    NSInteger titlesCount; //menu count
    NSInteger newChoseTag;  //tag of this time selected
    NSInteger choseTag;  //tag of last time selected
    CGFloat btnHeight;  //change button height to fit different screen
    NSInteger DTScrollTag; //dont scroll until tag+1
    CGFloat blankHeight;
    CGFloat half_blankHeight;
}

- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray *)menu andViews:(NSArray *)views{
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
        
        _textSize = 14.0;
        _textColor = [UIColor blackColor];
        _selectTextColor = [UIColor whiteColor];
        _selectViewColor = [UIColor blackColor];
        
        if (views.count < menu.count) {
            NSLog(@"add more views");
        }

        for (int i = 0; i < views.count; i++) {
            UIView *view = [views objectAtIndex:i];
            view.frame = self.rightview.bounds;
        }
        
        [self.rightview addSubview:(UIView *)[views objectAtIndex:0]];
        
        menuArray = menu;
        viewArray = views;
        titlesCount = menuArray.count;
        blankHeight = btnHeight - BOTTOMVIEW_HEIGHT;
        half_blankHeight = (btnHeight - BOTTOMVIEW_HEIGHT) / 2.0;
        choseTag = 1;  //acquiesce selected button is 1
        self.frame = frame;
        [self addSubview:self.menuView];
        [self addSubview:self.lineView];
        [self addSubview:self.rightview];
    }
    return self;
}

#pragma mark - Setter Method
- (void)setSelectViewColor:(UIColor *)selectViewColor{
    _selectTextColor = selectViewColor;
    _bottomView.backgroundColor = _selectViewColor;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    for (int i = 2; i <= menuArray.count; i++) {
        UIButton *button = [self viewWithTag:i];
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
}
- (void)setSelectTextColor:(UIColor *)selectTextColor{
    _selectTextColor = selectTextColor;
    UIButton *button = [self viewWithTag:1];
    [button setTitleColor:_selectTextColor forState:UIControlStateNormal];
}
- (void)setTextSize:(CGFloat)textSize{
    _textSize = textSize;
    for (int i = 1; i <= menuArray.count; i++) {
        UIButton *button = [self viewWithTag:i];
        button.titleLabel.font = [UIFont systemFontOfSize:textSize];
    }
}



- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(MENU_WIDTH, 0, LINEVIEW_WIDTH, self.frame.size.height)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIView *)rightview{
    if (!_rightview) {
        _rightview = [[UIView alloc] initWithFrame:CGRectMake(MENU_WIDTH + LINEVIEW_WIDTH, NAVIGATION_HEIGHT, FUll_VIEW_WIDTH - MENU_WIDTH + LINEVIEW_WIDTH, FUll_VIEW_HEIGHT)];
    }
    return _rightview;
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
        _bottomView.backgroundColor = _selectViewColor;
        [_menuView addSubview:_bottomView];
        
        for (int i = 1; i <= menuArray.count; i++) {
            UIButton *menuButton = [[UIButton alloc] init];
            menuButton.tag = i;
            menuButton.titleLabel.font = [UIFont systemFontOfSize:_textSize];
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
        [lastButton setTitleColor:_textColor forState:UIControlStateNormal];
        
        CGFloat scroHeight = _menuView.contentSize.height - FUll_VIEW_HEIGHT + TABBAR_HEIGHT;
        
        if (menuArray.count > DTScrollTag * 2.0) {
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
                    [_menuView setContentOffset:CGPointMake(0, scroHeight - blankHeight - 5.0) animated:NO];
                }];
            }
 
        }

        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _bottomView.frame = CGRectMake((MENU_WIDTH - BOTTOMVIEW_WIDTH) / 2.0,button.frame.origin.y +  half_blankHeight, BOTTOMVIEW_WIDTH, BOTTOMVIEW_HEIGHT);
        } completion:nil];
        [self performSelector:@selector(delayChangeTextColor) withObject:nil afterDelay:0.07];
        

        for(UIView *view in [_rightview subviews])
        {
            [view removeFromSuperview];
        }
        
        NSInteger viewtag;
        if (button.tag >= viewArray.count) {
            viewtag = viewArray.count - 1;
        }else{
            viewtag = button.tag - 1;
        }
        UIView *rigView = [viewArray objectAtIndex:viewtag];
        [_rightview addSubview:rigView];
        
    }
}

- (void)delayChangeTextColor{
        UIButton *button = (UIButton *)[self viewWithTag:newChoseTag];
        [button setTitleColor:_selectTextColor forState:UIControlStateNormal];
        choseTag = newChoseTag;
}

@end
