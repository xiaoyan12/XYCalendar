//
//  XYCalendarModel.h
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCalendarInfoModel : NSObject
/**
 天
 */
@property (nonatomic , copy) NSString *day;
/**
 是否选择
 */
@property (nonatomic , assign) BOOL isSelect;
/**
 是否高亮显示
 */
@property (nonatomic , assign) BOOL isHighlight;

@end


@interface XYCalendarModel : NSObject
/**
 月份
 */
@property (nonatomic , copy)   NSString *month;
/**
 年份
 */
@property (nonatomic , copy)   NSString *year;
/**
 当前月份显示的天数
 */
@property (nonatomic , strong) NSArray *dateArray;

@end

NS_ASSUME_NONNULL_END
