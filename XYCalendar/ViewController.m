//
//  ViewController.m
//  XYCalendar
//
//  Created by IvorChao on 2020/11/24.
//  Copyright © 2020 甜心互娱. All rights reserved.
//

#import "ViewController.h"
#import "XYCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (IBAction)buttonCliick:(UIButton *)sender {
    self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5f];
    XYCalendarView *view = [[XYCalendarView alloc] initWithDateArray:@[@"2021-02-25",@"2021-02-21",@"2021-03-01",@"2021-01-31"]];
    [self.view addSubview:view];
//    view.frame = CGRectMake(38, 200, self.view.frame.size.width-76.0f, [view getHeight]);
    view.frame = CGRectMake(38, 200, self.view.frame.size.width-76.0f, 400.0f);
}

@end
