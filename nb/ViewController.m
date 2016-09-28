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
@interface ViewController ()<ClickAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    CustomAlert *aler = [[CustomAlert alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
   [aler setAlert:@"提示" message:@"呵呵" cancelButtonTitle:@"cancel" sureButtonTitle:@"ok" delegate:self];
    
    
    
}


- (void)clickAlertButton:(UIButton *)button {


    NSLog(@"%ld",button.tag);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    NSLog(@"ddd");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
