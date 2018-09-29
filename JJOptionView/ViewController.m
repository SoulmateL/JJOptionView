//
//  ViewController.m
//  JJOptionView
//
//  Created by 俊杰  廖 on 2018/9/20.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import "ViewController.h"
#import "JJOptionView/JJOptionView.h"
#import "SecondViewController.h"
@interface ViewController ()<JJOptionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:button];

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

- (void)next {
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex {
    NSLog(@"%@",optionView);
    NSLog(@"%ld",selectedIndex);
}


@end
