//
//  ViewController.m
//  MDLayoutSample
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "ViewController.h"
#import "MDStyle.h"
#import "MDLayout.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *headerButton;
@end

@implementation ViewController

-(void)loadView{
    [super viewDidLoad];
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"demo.xml"];
    //    MDStylesheet *sheet = [MDStylesheet readStyleSheetFromXMLElement:[rootXML child:@"Resources"]];
    UIView *layoutView = [MDLayoutInfo loadViewWithXMLElement:[rootXML child:@"Layout"] superView:nil andHost:self];
    layoutView.backgroundColor = [UIColor whiteColor];
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

-(void)headerButton_click:(id)sender{
    NSLog(@"clicked in controller:%@",sender);
}
@end
