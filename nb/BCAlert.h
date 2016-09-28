//
//  BCAlert.h
//  nb
//
//  Created by Jack on 16/9/28.
//  Copyright © 2016年 毕研超. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomAlertDelegate <NSObject>

@optional

- (void)clickCustomAlertButton:(UIButton *)button;

@end

@interface BCAlert : UIView

/**
 *  如果这里直接调用initWithFrame，则需要对下面的字符串赋值，所以建议直接使用下面生命的方法
 */

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, copy) NSString *cancelStr;
@property (nonatomic, copy) NSString *sureStr;

@property (nonatomic, weak) id <CustomAlertDelegate> delegate;

/**
 *  初始化方法,如果想去掉引用警告，则自己拆分出一个show方法，这里不再实现
 */

- (instancetype) initWithTitle:(NSString *)title content:(NSString *)contentText cancelButton:(NSString *)cancelTitle
   endSureButton:(NSString *)sureTitle delegate:(id)delegate;




@end
