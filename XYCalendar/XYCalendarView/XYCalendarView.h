//
//  XYCalendarView.h
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCalendarView : UIView

/// 初始化
/// @param dateArray 选中的时间 格式：2020-01-01
- (instancetype)initWithDateArray:(NSArray <NSString *>*)dateArray;

- (CGFloat)getHeight;

@end

NS_ASSUME_NONNULL_END
