//
//  JJOptionView.h
//  DropdownListDemo
//
//  Created by 俊杰  廖 on 2018/9/20.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE

@class JJOptionView;

@protocol JJOptionViewDelegate <NSObject>

@optional

- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex;

@end

@interface JJOptionView : UIView
/**
 标题名
 */
@property (nonatomic, strong) IBInspectable NSString *title;

/**
 标题颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *titleColor;

/**
 标题字体大小
 */
@property (nonatomic, assign) IBInspectable CGFloat titleFontSize;

/**
 视图圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 视图边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/**
 边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 cell高度
 */
@property (nonatomic, assign) CGFloat rowHeigt;

/**
 数据源
 */
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak) id<JJOptionViewDelegate> delegate;

@property (nonatomic,copy) void(^selectedBlock)(JJOptionView *optionView,NSInteger selectedIndex);

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
