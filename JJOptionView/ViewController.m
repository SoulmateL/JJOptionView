//
//  ViewController.m
//  JJOptionView
//
//  Created by 俊杰  廖 on 2018/9/20.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import "ViewController.h"
#import "JJOptionView/JJOptionView.h"
@interface ViewController ()<JJOptionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    UIView *a = [[UIView alloc] initWithFrame:CGRectMake(20,500 , 100, 1)];
//    a.backgroundColor = [UIColor redColor];
//    [self.view addSubview:a];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:1 animations:^{
//            a.frame = CGRectMake(20, 200, 100, 300);
//        }];
//    });
    
    
    
    
    
    JJOptionView *view = [[JJOptionView alloc] initWithFrame:CGRectMake(100, 700, 200, 40)];
    view.dataSource = @[@"111",@"222",@"333",@"444",@"555"];
    view.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
        NSLog(@"%@",optionView);
        NSLog(@"%ld",selectedIndex);
    };
    [self.view addSubview:view];


    JJOptionView *view1 = [[JJOptionView alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    view1.dataSource = @[@"1",@"2",@"3",@"4",@"5"];
    view1.delegate = self;
    [self.view addSubview:view1];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex {
    NSLog(@"%@",optionView);
    NSLog(@"%ld",selectedIndex);
}


@end
