//
//  NSDate+Date.h
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Date)
/// 获取日
+ (NSInteger)day:(NSString *)date;
/// 获取月
+ (NSInteger)month:(NSString *)date;
/// 获取年
+ (NSInteger)year:(NSString *)date;
/// 获取当月第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSString *)dateStr;
/// 计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr;
/// 获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval;
///根据具体日期获取时间戳
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateString;

+ (BOOL)isToday:(NSString *)date;
+ (BOOL)isEqualBetweenWithDate:(NSString *)date toDate:(NSString *)toDate;
///格式：2018-01
+ (BOOL)isCurrenMonth:(NSString *)date;
/**
 获取当前时间
 */
+ (NSString *)getCurrentTime;
/**
 得到当前时间N天前后的日期
 @param day   传入正数 n天后   传入负数 N天前
 @return return value description
 */
+ (NSString *)getTimeAfterNowWithDay:(int)day withCurrentTimes:(NSString *)currentTime;
/**
 得到当前时间是星期几
 */
+ (NSInteger)getWeekDayFromDate:(NSString *)dateString;

/**
 获取当前时间 月多少天
 */
+ (int)getCurrentMonthDayNum:(NSString *)deteStr;
/**
 获取下个月的年份
 */
+ (NSString *)getNextYearWithMonth:(int)month startYear:(NSInteger)year index:(int)index;

@end

NS_ASSUME_NONNULL_END
