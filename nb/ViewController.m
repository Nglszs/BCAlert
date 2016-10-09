//
//  ViewController.m
//  nb
//
//  Created by Jack on 16/8/26.
//  Copyright © 2016年 毕研超. All rights reserved.
//

#import "ViewController.h"
#import "nb-Swift.h"
#import <ReplayKit/ReplayKit.h>
#import "BCAlert.h"
@interface ViewController ()<ClickAlertDelegate,CustomAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //swift
    CustomAlert *aler = [[CustomAlert alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
   [aler setAlert:@"提示" message:@"呵呵" cancelButtonTitle:@"cancel" sureButtonTitle:@"ok" delegate:self];
    
    
    
    //oc
    
//    BCAlert *OCAlert = [[BCAlert alloc] initWithTitle:@"警告" content:@"内容" cancelButton:@"cancel" endSureButton:@"ok" delegate:self];
    
}

//swift 代理
- (void)clickAlertButton:(UIButton *)button {


    NSLog(@"%ld",button.tag);

}


//oc代理

- (void)clickCustomAlertButton:(UIButton *)button {

    NSLog(@"%ld",button.tag);

}

- (NSInteger)pringtheh {

    return 10086;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
