//
//  BCAlert.m
//  nb
//
//  Created by Jack on 16/9/28.
//  Copyright © 2016年 毕研超. All rights reserved.
//

#import "BCAlert.h"

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define line228Color [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]
@interface BCAlert()

{
    
    //这里不解释，看字面意思也知道
    UIButton *sureButton,*cancelButton;
    UILabel *tipLabel,*contentLabel;
    UIView *mainView;

    
}

@property (nonatomic, strong) UIWindow *window;
@end

@implementation BCAlert


- (instancetype)initWithTitle:(NSString *)title content:(NSString *)contentText cancelButton:(NSString *)cancelTitle endSureButton:(NSString *)sureTitle delegate:(id)delegate {

    _titleStr = title;
    _contentStr = contentText;
    _cancelStr = cancelTitle;
    _sureStr = sureTitle;
    self.delegate = delegate;
   
    return [self initWithFrame:[UIScreen mainScreen].bounds];

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //背景
        UIView *backView = [[UIView alloc]initWithFrame:self.frame];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.35;
        [self addSubview:backView];
        
        //内容,这里不做界面适配，需要的自己做，很简单
        mainView = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 270)/2, (CGRectGetHeight(self.frame) - 132)/2, 270, 132)];
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.layer.cornerRadius = 10;
        mainView.layer.masksToBounds = YES;
        [self addSubview:mainView];
        
        
        tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 16, mainView.frame.size.width, 16)];
        tipLabel.font = [UIFont systemFontOfSize:16];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:tipLabel];
        
        
        
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(tipLabel.frame) + 7, 270 - 36, 50)];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:contentLabel];
        
        
        cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 7, 270/2 - 1, 44)];
       
        [cancelButton setTitleColor:COLOR(173, 142, 101, 1) forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.tag = 0;
        [mainView addSubview:cancelButton];
        
        sureButton = [[UIButton alloc]initWithFrame:CGRectMake(270/2, CGRectGetMaxY(contentLabel.frame) + 7,270/2, 44)];
        
        
        [ sureButton setTitleColor:COLOR(173, 142, 101, 1) forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
        sureButton.tag = 1;
        [mainView addSubview: sureButton];
        [sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
      
        
        [self adjustView];
        
    }

    return self;
}


- (void)adjustView {//判断，各种可能性，然后调整view
    
    //这里加上判断条件，同一时间段只能在屏幕上出现一个此弹窗，防止多次弹窗bug
    
    BOOL ishowAlert = [[NSUserDefaults standardUserDefaults] boolForKey:@"AlertIsShow"];
    
    if (ishowAlert) {
        return;
    }
    

    tipLabel.text = _titleStr;
    contentLabel.text = _contentStr;
   
    
    CGFloat tempHeight = [self getStringHeightWith:_contentStr width:270 - 36 font:[UIFont systemFontOfSize:14]];
    contentLabel.frame = CGRectMake(16, CGRectGetMaxY(tipLabel.frame) + 7, 270 - 32, tempHeight);
    
    UIImageView *linImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, 270, .5)];
    linImage.tag = 200;
    linImage.backgroundColor = line228Color;
    [mainView addSubview:linImage];
    
    UIImageView *linImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(270/2 - 1, CGRectGetMaxY(contentLabel.frame) + 16 , 0.5, 44)];

    linImage2.backgroundColor = line228Color;
    [mainView addSubview:linImage2];
    
    cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame)  + 16, 270/2 - 1, 44);
    sureButton.frame = CGRectMake(270/2, CGRectGetMaxY(contentLabel.frame)  + 16,270/2, 44);
    
    [cancelButton setTitle:_cancelStr forState:UIControlStateNormal];
    [sureButton setTitle:_sureStr forState:UIControlStateNormal];
    
    if (_titleStr == nil) {
        tipLabel.hidden = YES;
        contentLabel.frame = CGRectMake(16, 16, mainView.frame.size.width - 32, tempHeight);
        
        linImage.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, 270, 0.5);
        linImage2.frame = CGRectMake(270/2 - 1, CGRectGetMaxY(contentLabel.frame) + 16, 0.5, 44);
        
        if (_sureStr == nil) {
            linImage2.hidden = YES;
            sureButton.hidden = YES;
            cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
            
        }else{
            
            cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width/2 - 1, 44);
            sureButton.frame = CGRectMake(mainView.frame.size.width/2, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width/2, 44);
            
        }
        
    }
    
    if (_sureStr == nil) {
        sureButton.hidden = YES;
        linImage2.hidden = YES;
        cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
    }
    
    if (_cancelStr == nil) {
        cancelButton.hidden = YES;
        linImage2.hidden = YES;
    sureButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
    }
    
    CGFloat height = CGRectGetMaxY(contentLabel.frame) + 44 + 16;
    
    mainView.frame = CGRectMake((CGRectGetWidth(self.frame) - 270)/2, (CGRectGetHeight(self.frame) - height)/2, 270, height);
    
    
    _window = [[UIWindow alloc]initWithFrame:self.frame];
    _window.windowLevel = UIWindowLevelAlert + 1;
    
    [_window addSubview:self];
    [_window makeKeyAndVisible];
    

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AlertIsShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


- (void)shutAlert {
    
    [self removeFromSuperview];
    
    [_window resignKeyWindow];
    
    _window = nil;
    
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AlertIsShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
}

- (void)clickButton:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomAlertButton:)]) {
        
        [self.delegate clickCustomAlertButton:btn];
    
    }
   
    //关闭弹窗
    [self shutAlert];
}

//获取字符串高度
- (CGFloat)getStringHeightWith:(NSString*)tempStr width:(CGFloat)tempWidth font:(UIFont*)tempFont {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 4.f;    //行间距
    paragraphStyle.maximumLineHeight = 20.f;    //每行的最大高度
    paragraphStyle.minimumLineHeight = 16.f;    //每行的最小高度
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    CGRect rect = [tempStr boundingRectWithSize:CGSizeMake(tempWidth, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                     attributes:@{NSFontAttributeName:tempFont,NSParagraphStyleAttributeName:paragraphStyle}
                                        context:nil];
    //文字的高度
    float tempHeight = rect.size.height;
    
    return tempHeight;
}
@end
