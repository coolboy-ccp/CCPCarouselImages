//
//  CCPScrollView.h
//  CCPCarouselImages
//
//  Created by liqunfei on 16/3/8.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapImageBlock)(NSInteger index);
@interface CCPScrollView : UIView

@property (nonatomic,assign)TapImageBlock tapImgBlock;

- (void)CreateScrollViewWithLocationImages:(NSArray *)LImages timerDuration:(NSTimeInterval)duration;
@end
