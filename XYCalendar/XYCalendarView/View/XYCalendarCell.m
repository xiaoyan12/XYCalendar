//
//  XYCalendarCell.m
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import "XYCalendarCell.h"
#import "XYCalendarModel.h"

@interface XYCalendarCell ()

@property (nonatomic , strong) UILabel *label;

@end

@implementation XYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self.contentView addSubview:self.label];
    
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake((self.frame.size.width-20.0f)/2.0f, 0, 20.0f, 20.0f);
        _label.font = [UIFont boldSystemFontOfSize:12.0f];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.layer.cornerRadius = 10.0f;
        _label.layer.masksToBounds = YES;
    }
    return _label;
}

- (void)updateCalendarModel:(XYCalendarInfoModel *)model{
    self.label.backgroundColor = [UIColor whiteColor];
    if (model.isHighlight) {
        self.label.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
        if (model.isSelect) {
            self.label.textColor = [UIColor whiteColor];
            self.label.backgroundColor = [UIColor colorWithRed:34/255.0 green:213/255.0 blue:157/255.0 alpha:1.0];
        }
    }else{
        self.label.textColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    }
    
    if (model.day.length) {
        self.label.text = model.day;
    }else{
        self.label.text = @"";
    }
}

@end
