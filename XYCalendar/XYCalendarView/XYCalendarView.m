//
//  XYCalendarView.m
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import "XYCalendarView.h"
#import "XYCalendarCell.h"
#import "NSDate+Date.h"
#import "XYCalendarModel.h"
#import "XYCalendarHeadView.h"

@interface XYCalendarView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic , strong) UICollectionView *collectionView;
/**
 数据数组
 */
@property (nonatomic , strong) NSMutableArray *dataArray;
/**
 选中的数组
 */
@property (nonatomic , strong) NSArray *selectDateArray;

@property (nonatomic , assign) CGFloat viewHeight;

@end

@implementation XYCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithDateArray:(NSArray<NSString *> *)dateArray{
    if (self = [super init]) {
        self.selectDateArray = dateArray;
        self.backgroundColor = [UIColor whiteColor];
        [self createData];
        [self createUI];
    }
    return self;
}


- (void)createData{
    //获取当前时间
    NSString *endStr = @"2021-03-01";
    NSString *startStr = [NSDate getTimeAfterNowWithDay:-1200 withCurrentTimes:endStr];
    
    NSArray   *startArray = [startStr componentsSeparatedByString:@"-"];
    NSArray   *endArray   = [endStr componentsSeparatedByString:@"-"];
    NSInteger monthCount  = ([endArray[0] integerValue] - [startArray[0] integerValue])* 12 + ([endArray[1] integerValue] - [startArray[1] integerValue]) + 1;
    BOOL isAdd = NO;
    //获取年份
    NSInteger year = 0;
    for (int i = 0; i < monthCount; i++) {
        XYCalendarModel *model = [[XYCalendarModel alloc] init];
        int statrIndex = 0;
        int count = 0;
        int month = ((int)[NSDate month:startStr] + i)%12;
        month = month ? month : 12;
        if (month < 10) {
            model.month = [NSString stringWithFormat:@"0%d",month];
        }else{
            model.month = [NSString stringWithFormat:@"%d",month];
        }
        //判断有没有初始的年份
        if (year == 0) {
            year = [[startArray firstObject] integerValue];
        }
        //判断是否需要添加年份
        if (isAdd == YES) {
            year++;
            isAdd = NO;
        }
        //赋值年份
        model.year = [NSString stringWithFormat:@"%ld",year];
        //判断月份是不是到12月了 是 更改状态下次循环增加年份
        if (month%12==0) {
            isAdd = YES;
        }
        
        if (i == 0) {
            //第一个月
            statrIndex = [[startArray lastObject] intValue];
            count = [NSDate getCurrentMonthDayNum:startStr];
        }else if (i == monthCount-1) {
            //最后一个月
            statrIndex = 1;
            count = [[endArray lastObject] intValue];
        }else{
            //中间的月份
            statrIndex = 1;
            count = [NSDate getCurrentMonthDayNum:[NSString stringWithFormat:@"%@-%@-01",model.year,model.month]];
        }

        NSMutableArray *dayArray = [NSMutableArray array];
        int index = 0;
        for (int j = statrIndex; j <= count; j++) {
            XYCalendarInfoModel *dayModel = [[XYCalendarInfoModel alloc] init];
            //判断是一个月的时候  避免31天的月份显示问题
            if (monthCount == 1) {
                index++;
                //判断是不是选中的30天 避免31天的月份显示问题
                if (index <= 30) {
                    dayModel.isHighlight = YES;
                }else{
                    dayModel.isHighlight = NO;
                }
            }else{
                dayModel.isHighlight = YES;
            }
            //赋值日期
            if (j >= 10) {
                dayModel.day = [NSString stringWithFormat:@"%d",j];
            }else if (j >= 1 && j < 10){
                dayModel.day = [NSString stringWithFormat:@"0%d",j];
            }else{
                dayModel.day = @"";
            }
            //赋值选中的日期
            NSString *selectStr = [NSString stringWithFormat:@"%@-%@-%@",model.year, model.month,dayModel.day];
            [self.selectDateArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *selectDate = (NSString *)obj;
                if ([selectStr containsString:selectDate]) {
                    dayModel.isSelect = YES;
                }
            }];
            [dayArray addObject:dayModel];
        }
        model.dateArray = dayArray;
        [self.dataArray addObject:model];
    }
    
    //填补因当月1号星期数的不同的空白
    for (int i = 0; i < self.dataArray.count; i++) {
        XYCalendarModel *model = [self.dataArray objectAtIndex:i];
        NSInteger dayCount = 0;
        if (i == 0) {
            dayCount = [NSDate getWeekDayFromDate:startStr];
            if (dayCount == 7) {
                dayCount = 0;
            }
        }else{
            NSString *dateStr = [NSString stringWithFormat:@"%@-%@-01",model.year, model.month];
            //获取该月第一天星期几
            dayCount = [NSDate firstWeekdayInThisMonth:dateStr];
        }
        
        NSMutableArray *dayArray = [NSMutableArray array];
        for (NSInteger j = 1; j <= dayCount; j++) {
            XYCalendarInfoModel *dayModel = [[XYCalendarInfoModel alloc] init];
            dayModel.isHighlight = NO;
            if (i == 0) {
                NSInteger day = [[startArray lastObject] intValue]-j;
                if (day >= 10) {
                    dayModel.day = [NSString stringWithFormat:@"%ld",day];
                }else if (day >= 1 && day < 10){
                    dayModel.day = [NSString stringWithFormat:@"0%ld",day];
                }else{
                    dayModel.day = @"";
                }
            }else{
                dayModel.day = @"";
            }
            [dayArray insertObject:dayModel atIndex:0];
        }
        [dayArray addObjectsFromArray:model.dateArray];
        model.dateArray = dayArray;
    }
    //获取高度
    self.viewHeight = 60.0f*self.dataArray.count;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XYCalendarModel *model = (XYCalendarModel *)obj;
        if (model.dateArray.count%7 == 0) {
            self.viewHeight += (model.dateArray.count/7)*20.0f+((model.dateArray.count/7)-1)*12.0f;
        }else{
            self.viewHeight += (model.dateArray.count/7+1)*20.0f+(model.dateArray.count/7)*12.0f;
        }
    }];
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)createUI{
    [self addSubview:self.collectionView];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(16.0f, 20.0f,16.0f, 20.0f);
        layout.itemSize = CGSizeMake((300.0f-40.0f)/7.0f, 20.0f);
        layout.minimumLineSpacing = 12.0f;
        layout.minimumInteritemSpacing = 0.0f;
        
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, self.viewHeight) collectionViewLayout:layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 400.0f) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:XYCalendarCell.class forCellWithReuseIdentifier:@"XYCalendarCell"];
        
        [_collectionView registerClass:XYCalendarHeadView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XYCalendarHeadView"];
        
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    XYCalendarModel *model = self.dataArray[section];
    return model.dateArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYCalendarCell" forIndexPath:indexPath];
    XYCalendarModel *model = self.dataArray[indexPath.section];
    [cell updateCalendarModel:model.dateArray[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XYCalendarModel *model = self.dataArray[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XYCalendarHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XYCalendarHeadView" forIndexPath:indexPath];
        
        [headView updateCalendarHeadStr:[NSString stringWithFormat:@"%@年%@月",model.year,model.month]];
        return headView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 28.0f);
}

- (CGFloat)getHeight{
    return self.viewHeight;
}

@end
