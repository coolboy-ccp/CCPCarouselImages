//
//  ViewController.m
//  CCPCarouselImages
//
//  Created by liqunfei on 16/3/8.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "CCPScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creataMainScrollView];
}

- (void)creataMainScrollView {
    NSArray *arr = @[@"1.png",@"2.jpeg",@"3.jpg",@"4.jpeg"];
    CCPScrollView *mainScrollView = [[CCPScrollView alloc] initWithFrame:self.view.bounds];
    [mainScrollView CreateScrollViewWithLocationImages:arr timerDuration:3.0f];
    mainScrollView.tapImgBlock = ^(NSInteger index) {
        NSLog(@"index----%ld",(unsigned long)index);
    };
    [self.view addSubview:mainScrollView];
}

@end
