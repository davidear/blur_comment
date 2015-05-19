//
//  JSGCommentView.h
//  BeaconMall
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 zkjinshi. All rights reserved.
//
/*!
    需要实现效果:
    1. 背景毛玻璃
    2. 键盘上部自定义
    3. 跟随键盘实时更新frame
*/
#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)();
typedef void(^ResendVerifyMSGBlock)();
@interface BlurCommentView : UIImageView

+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success;
+ (void)commentshowSuccess:(SuccessBlock)success;
@end
