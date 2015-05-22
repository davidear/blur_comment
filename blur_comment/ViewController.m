//
//  ViewController.m
//  blur_comment
//
//  Created by dai.fengyi on 15/5/19.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"
#import "BlurCommentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showCommentView:(id)sender {
    [BlurCommentView commentshowSuccess:^(NSString *text) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
