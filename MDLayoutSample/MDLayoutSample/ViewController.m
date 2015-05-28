//
//  ViewController.m
//  MDLayoutSample
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "ViewController.h"
#import "MDLayout.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *centerButton;
@end

@implementation ViewController

-(void)loadView{
    [super viewDidLoad];
    UIView *layoutView = [MDLayout loadViewWithFileName:@"demo.xml" withSuperView:nil andHost:nil];
    self.view = layoutView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)centerButton_click:(id)sender{
    NSLog(@"clicked in controller:%@",sender);
}
@end
