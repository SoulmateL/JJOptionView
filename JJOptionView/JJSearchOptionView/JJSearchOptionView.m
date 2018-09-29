//
//  JJSearchOptionView.m
//  iPad
//
//  Created by 俊杰  廖 on 2018/9/28.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import "JJSearchOptionView.h"
#import "Masonry.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface JJSearchOptionView ()<UITableViewDelegate,UITableViewDataSource>

/**
 搜索控件
 */
@property (nonatomic, strong) UITextField *searchTextField;

/**
 右边箭头图片
 */
@property (nonatomic, strong) UIImageView *rightImageView;

/**
 选项列表
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 蒙版
 */
@property (nonatomic, strong) UIButton *backgroundBtn;
/**
 tableView的高度
 */
@property (nonatomic, strong) NSArray *tempDataSource;

@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, assign) BOOL isDirectionUp;
@property (nonatomic, assign) BOOL isShowing;
@end


static CGFloat const animationTime = 0.3;
static CGFloat const rowheight = 42;
static CGFloat const rows = 5;

@implementation JJSearchOptionView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataSource;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.cornerRadius = 5;
    self.borderWidth = 1;
    self.borderColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    
    [self addSubview:self.rightImageView];
    [self addSubview:self.searchTextField];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.rightImageView);
    }];
}


- (void)show {
    WEAKSELF;
    self.isShowing = YES;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backgroundBtn];
    [window addSubview:self.tableView];
    // 获取按钮在屏幕中的位置
    CGRect frame = [self convertRect:self.bounds toView:window];
    CGFloat tableViewY = frame.origin.y + frame.size.height;
    CGRect tableViewFrame;
    tableViewFrame.size.width = frame.size.width;
    tableViewFrame.size.height = self.tableViewHeight;
    tableViewFrame.origin.x = frame.origin.x;
    
    if (tableViewY + self.tableViewHeight < CGRectGetHeight([UIScreen mainScreen].bounds)) {
        tableViewFrame.origin.y = tableViewY;
        self.isDirectionUp = NO;
    }else {
        tableViewFrame.origin.y = frame.origin.y - self.tableViewHeight;
        self.isDirectionUp = YES;
    }
    self.tableView.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y+(self.isDirectionUp?self.tableViewHeight:0), tableViewFrame.size.width, 0);
    [UIView animateWithDuration:animationTime animations:^{
        weakSelf.rightImageView.transform = CGAffineTransformRotate(weakSelf.rightImageView.transform,self.isDirectionUp?-M_PI/2:M_PI/2);
        weakSelf.tableView.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y, tableViewFrame.size.width, tableViewFrame.size.height);
    } completion:nil];
    
}

- (void)dismiss {
    WEAKSELF;
    self.isShowing = NO;

    [UIView animateWithDuration:animationTime animations:^{
        weakSelf.rightImageView.transform = CGAffineTransformIdentity;
        weakSelf.tableView.frame = CGRectMake(weakSelf.tableView.frame.origin.x, weakSelf.tableView.frame.origin.y+(self.isDirectionUp?self.tableViewHeight:0), weakSelf.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [weakSelf.backgroundBtn removeFromSuperview];
        [weakSelf.tableView removeFromSuperview];
    }];
    
}


- (void)searchWithKeyword:(UITextField *)sender {
    NSLog(@"%@",sender.text);
    if (!self.isShowing) {
        [self show];
    }
    
    if (sender.text.length) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *string in self.tempDataSource) {
            if ([string containsString:sender.text]) {
                [array addObject:string];
            }
        }
        self.dataSource = [array copy];
        if (!array.count) {
            [self dismiss];
        }
    }else {
        self.dataSource = [NSArray arrayWithArray:self.tempDataSource];
        [self dismiss];
    }
    [self.tableView reloadData];

   
}


#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchTextField.text = self.dataSource[indexPath.row];
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(searchOptionView:selctedString:selectedIndex:)]) {
        [self.delegate searchOptionView:self selctedString:self.dataSource[indexPath.row] selectedIndex:indexPath.row];
    }
    if (self.selectedBlock) {
        self.selectedBlock(self,self.dataSource[indexPath.row],indexPath.row);
    }
}

#pragma mark getter && setter



- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.placeholder = @"请输入关键字";
        _searchTextField.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
        [_searchTextField addTarget:self action:@selector(searchWithKeyword:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.font = [UIFont systemFontOfSize:16];
    }
    return _searchTextField;
}


- (UIImageView *)rightImageView {
    if(!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_icon_drfault"]];
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = rowheight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.shadowOffset = CGSizeMake(4, 4);
        _tableView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _tableView.layer.shadowOpacity = 0.8;
        _tableView.layer.shadowRadius = 4;
        _tableView.layer.borderColor = [UIColor grayColor].CGColor;
        _tableView.layer.borderWidth = 0.5;
        _tableView.layer.cornerRadius = self.cornerRadius;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        }
    }
    return _tableView;
}

- (UIButton *)backgroundBtn {
    if (!_backgroundBtn) {
        _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundBtn.backgroundColor = [UIColor clearColor];
        _backgroundBtn.frame = [UIScreen mainScreen].bounds;
        [_backgroundBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundBtn;
}

- (CGFloat)tableViewHeight {
    return rows * rowheight;
}

- (void)setRowHeigt:(CGFloat)rowHeigt {
    _rowHeigt = rowHeigt;
    self.tableView.rowHeight = rowHeigt;
}

- (NSArray *)tempDataSource {
    if (!_tempDataSource) {
        _tempDataSource = [NSArray arrayWithArray:self.dataSource];
    }
    return _tempDataSource;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.searchTextField.placeholder = placeholder;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
}



- (void)setKeyWordFontSize:(CGFloat)keyWordFontSize {
    _keyWordFontSize = keyWordFontSize;
    self.searchTextField.font = [UIFont systemFontOfSize:keyWordFontSize];
}

- (void)setKeyWordColor:(UIColor *)keyWordColor {
    _keyWordColor = keyWordColor;
    self.searchTextField.textColor = keyWordColor;
}



- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return (UIColor *)self.layer.borderColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}


@end
