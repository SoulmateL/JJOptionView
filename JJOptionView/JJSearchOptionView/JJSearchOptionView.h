//
//  JJSearchOptionView.h
//  iPad
//
//  Created by 俊杰  廖 on 2018/9/28.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JJSearchOptionView;

@protocol JJSearchOptionViewDelegate <NSObject>
- (void)searchOptionView:(JJSearchOptionView *)optionView selctedString:(NSString *)selctedString selectedIndex:(NSInteger)selectedIndex;
@end

@interface JJSearchOptionView : UIView
/**
 标题名
 */
@property (nonatomic, strong) IBInspectable NSString *placeholder;

/**
 标题颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *keyWordColor;

/**
 标题字体大小
 */
@property (nonatomic, assign) IBInspectable CGFloat keyWordFontSize;

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

@property (nonatomic, weak) id<JJSearchOptionViewDelegate> delegate;

@property (nonatomic,copy) void(^selectedBlock)(JJSearchOptionView *optionView,NSString *selctedString,NSInteger selectedIndex);

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
