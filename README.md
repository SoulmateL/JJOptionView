# JJOptionView
自己封装了一个简单的下拉列表控件

![CarouselView in action](picture.gif)

iOS封装的下拉列表控件，会自动识别向上向下展开

```
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
```





