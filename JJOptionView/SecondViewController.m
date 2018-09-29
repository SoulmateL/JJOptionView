//
//  SecondViewController.m
//  JJOptionView
//
//  Created by 俊杰  廖 on 2018/9/29.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import "SecondViewController.h"
#import "JJSearchOptionView/JJSearchOptionView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    JJSearchOptionView *view = [[JJSearchOptionView alloc] initWithFrame:CGRectMake(100, 700, 200, 40)];
    view.dataSource = @[@"1",@"22",@"213",@"432",@"462",@"872",@"298",@"245",@"20",@"20567"];
    view.selectedBlock = ^(JJSearchOptionView * _Nonnull optionView, NSString * _Nonnull selctedString, NSInteger selectedIndex) {
        
    };
    [self.view addSubview:view];
    
    JJSearchOptionView *view1 = [[JJSearchOptionView alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    view1.dataSource = @[@"1",@"22",@"213",@"432",@"462",@"872",@"298",@"245",@"20",@"20567"];
    view1.selectedBlock = ^(JJSearchOptionView * _Nonnull optionView, NSString * _Nonnull selctedString, NSInteger selectedIndex) {
        
    };
    [self.view addSubview:view1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
