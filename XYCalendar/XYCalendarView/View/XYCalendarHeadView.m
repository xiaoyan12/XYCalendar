//
//  XYCalendarHeadView.m
//  XYCalendar
//
//  Created by IvorChao on 2020/11/25.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import "XYCalendarHeadView.h"

@interface XYCalendarHeadView ()

@property (nonatomic , strong) UILabel *label;

@end

@implementation XYCalendarHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:250/255.0 alpha:1.0];
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.label];
    
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake(20.0f, 0, self.frame.size.width-40.0f, 28.0f);
        _label.textColor = [UIColor colorWithRed:167/255.0f green:166/255.0f blue:173/255.0f alpha:1.0f];
        _label.font = [UIFont boldSystemFontOfSize:12.0f];
    }
    return _label;
}

- (void)updateCalendarHeadStr:(NSString *)string{
    self.label.text = string;
}


@end
