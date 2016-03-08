//
//  NSTimer+CCPTimerAddition.m
//  CCPCarouselImages
//
//  Created by liqunfei on 16/3/8.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "NSTimer+CCPTimerAddition.h"

@implementation NSTimer (CCPTimerAddition)

- (void)pauseTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimerAfterDelayTimerInteval:(NSTimeInterval)inteval {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:inteval]];
}

@end
