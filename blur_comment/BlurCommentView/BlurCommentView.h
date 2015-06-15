//
//  JSGCommentView.h
//  blur_comment
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BlurCommentViewDelegate <NSObject>
@optional
- (void)commentDidFinished:(NSString *)commentText;
@end
typedef void(^SuccessBlock)(NSString *commentText);
@interface BlurCommentView : UIImageView
//
+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success;
+ (void)commentshowInView:(UIView *)view delegate:(id <BlurCommentViewDelegate>)delegate;

//default is in [UIApplication sharedApplication].keyWindow
+ (void)commentshowSuccess:(SuccessBlock)success;
+ (void)commentshowDelegate:(id <BlurCommentViewDelegate>)delegate;
@end
