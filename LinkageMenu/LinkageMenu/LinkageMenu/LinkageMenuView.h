//
//  LinkageMenuView.h
//  LinkageMenu
//
//  Created by 风间 on 2017/3/8.
//  Copyright © 2017年 EmotionV. All rights reserved.
//  github: https://github.com/EmotionV/LinkageMenu

#import <UIKit/UIKit.h>

@interface LinkageMenuView : UIView

@property (nonatomic, strong) UIColor *selectViewColor;  /**< select view color (滑块颜色)*/
@property (nonatomic, strong) UIColor *textColor;  /**< text color (标题颜色)*/
@property (nonatomic, strong) UIColor *selectTextColor;  /**< select text color (标题选中的颜色)*/
@property (nonatomic, assign) CGFloat textSize;  /**< text size (标题字体大小)*/

/**
 Init Method

 @param frame   LinkageMenu frame
 @param menu    titles array
 @param views   right views array

 */
- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray *)menu andViews:(NSArray *)views;

@end
