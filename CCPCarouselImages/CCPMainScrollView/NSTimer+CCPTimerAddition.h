//
//  NSTimer+CCPTimerAddition.h
//  CCPCarouselImages
//
//  Created by liqunfei on 16/3/8.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CCPTimerAddition)

- (void)pauseTimer;
- (void)resumeTimerAfterDelayTimerInteval:(NSTimeInterval)inteval;

@end
