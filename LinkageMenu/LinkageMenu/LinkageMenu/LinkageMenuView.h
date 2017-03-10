//
//  LinkageMenuView.h
//  LinkageMenu
//
//  Created by 风间 on 2017/3/8.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkageMenuView : UIView

@property (nonatomic, strong) UIColor *selectViewColor;  /**< select view color */

@property (nonatomic, strong) UIColor *textColor;  /**< text color */

@property (nonatomic, strong) UIColor *selectTextColor;  /**< select text color */

@property (nonatomic, assign) CGFloat textSize;  /**< text size */


- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray *)menu andViews:(NSArray *)views;

@end
