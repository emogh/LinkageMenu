//
//  OneCollectionViewCell.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/10.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "OneCollectionViewCell.h"

@implementation OneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self addSubview:self.backView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.width - 20)];
        _backView.backgroundColor = [UIColor grayColor];
    }
    return _backView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _backView.frame.origin.y +  _backView.frame.size.height + 10, self.frame.size.width, 20)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}
@end
