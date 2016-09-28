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
@interface ViewController ()<CustomAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
       
    
     
}

- (void)hehe {

    NSLog(@"可以");

}

- (void)clickCustomAlertButton:(UIButton *)button {

    if (button.tag == 0) {
        
        NSLog(@"点击了取消");
    } else {
    
        NSLog(@"点击了确定");
    
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
