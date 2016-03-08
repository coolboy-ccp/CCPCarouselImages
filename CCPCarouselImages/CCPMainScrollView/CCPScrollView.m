//
//  CCPScrollView.m
//  CCPCarouselImages
//
//  Created by liqunfei on 16/3/8.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "CCPScrollView.h"
#import "NSTimer+CCPTimerAddition.h"

#define VIEW_H self.bounds.size.height
#define VIEW_W self.bounds.size.width
#define IMAGE_NAME(name) [UIImage imageNamed:name]

@interface CCPScrollView()<UIScrollViewDelegate>
{
    UIImageView *headImageView;
    UIImageView *tailImageView;
    UIImageView *centerImageView;
    UIScrollView *mainScrollView;
    NSInteger currentIndex;
    NSInteger pageInteger;
    NSTimer *scrollTimer;
    NSTimeInterval SDuration;
}
@property (nonatomic,strong) NSArray *SImages;

@end

@implementation CCPScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
    }
    return self;
}

- (void)CreateScrollViewWithLocationImages:(NSArray *)LImages timerDuration:(NSTimeInterval)duration{
    SDuration = duration;
    self.SImages = LImages;
    currentIndex = 0;
    if (!mainScrollView) {
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        mainScrollView.delegate = self;
        mainScrollView.backgroundColor = [UIColor clearColor];
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.contentSize = CGSizeMake(VIEW_W * 3, VIEW_H);
        mainScrollView.pagingEnabled = YES;
        [self addSubview:mainScrollView];
    }
    if (LImages.count == 1) {
        centerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        centerImageView.image = [UIImage imageNamed:LImages[0]];
        [mainScrollView addSubview:centerImageView];
        mainScrollView.scrollEnabled = NO;
    }
    else if (LImages.count >= 2) {
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_W, VIEW_H)];
        headImageView.image = IMAGE_NAME([LImages lastObject]);
        centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_W, 0, VIEW_W, VIEW_H)];
        centerImageView.image = IMAGE_NAME([LImages firstObject]);
        tailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_W * 2, 0, VIEW_W, VIEW_H)];
        tailImageView.image = IMAGE_NAME(LImages[1]);
        mainScrollView.contentOffset = CGPointMake(VIEW_W, 0);
        [mainScrollView addSubview:headImageView];
        [mainScrollView addSubview:centerImageView];
        [mainScrollView addSubview:tailImageView];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [mainScrollView addGestureRecognizer:tap];
    if (!scrollTimer && (duration > 0)) {
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
}

- (void)timerAction:(NSTimer *)timer {
    CGPoint offSet = CGPointMake(mainScrollView.contentOffset.x + VIEW_W, 0);
    [mainScrollView setContentOffset:offSet animated:YES];
}

- (void)tapImage:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateBegan) {
        [scrollTimer pauseTimer];
    }
    if (tap.state == UIGestureRecognizerStateEnded) {
        [scrollTimer resumeTimerAfterDelayTimerInteval:0];
    }
    self.tapImgBlock(pageInteger);
}


#pragma mark -- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollTimer resumeTimerAfterDelayTimerInteval:SDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x;
    if (offSetX >= 2*VIEW_W) {
        scrollView.contentOffset = CGPointMake(VIEW_W, 0);
        currentIndex++;
        if (currentIndex == self.SImages.count -1) {
            headImageView.image = IMAGE_NAME(self.SImages[currentIndex -1]);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages.firstObject);
            pageInteger = currentIndex;
            currentIndex = -1;
        }
        else if (currentIndex == self.SImages.count) {
            headImageView.image = IMAGE_NAME(self.SImages.lastObject);
            centerImageView.image = IMAGE_NAME(self.SImages.firstObject);
            centerImageView.image = IMAGE_NAME(self.SImages[1]);
            currentIndex = 0;
            pageInteger = currentIndex;
        }
        else if (currentIndex == 0) {
            headImageView.image = IMAGE_NAME(self.SImages.lastObject);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages[currentIndex + 1]);
            pageInteger = currentIndex;
        }
        else {
            headImageView.image = IMAGE_NAME(self.SImages[currentIndex - 1]);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages[currentIndex + 1]);
            pageInteger = currentIndex;
        }
    }
    else if (offSetX <= 0) {
        scrollView.contentOffset = CGPointMake(VIEW_W, 0);
        currentIndex--;
        if (currentIndex == -2) {
            currentIndex = self.SImages.count - 2;
            headImageView.image = IMAGE_NAME(self.SImages[currentIndex +1]);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages.lastObject);
            pageInteger = currentIndex;
        }
        else if (currentIndex == -1) {
            currentIndex = self.SImages.count - 1;
            headImageView.image = IMAGE_NAME(self.SImages[currentIndex - 1]);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages.firstObject);
            pageInteger = currentIndex;
        }
        else if (currentIndex == 0) {
            headImageView.image = IMAGE_NAME(self.SImages.lastObject);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages[currentIndex + 1]);
            pageInteger = currentIndex;
        }
        else {
            headImageView.image = IMAGE_NAME(self.SImages[currentIndex -1]);
            centerImageView.image = IMAGE_NAME(self.SImages[currentIndex]);
            tailImageView.image = IMAGE_NAME(self.SImages[currentIndex + 1]);
            pageInteger = currentIndex;
        }
        
    }
}

- (void)dealloc {
    [scrollTimer invalidate];
    scrollTimer = nil;
}

@end
