//
//  XYCalendarCell.h
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XYCalendarInfoModel;

@interface XYCalendarCell : UICollectionViewCell

- (void)updateCalendarModel:(XYCalendarInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
