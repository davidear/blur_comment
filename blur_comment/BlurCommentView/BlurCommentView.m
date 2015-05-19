//
//  JSGCommentView.m
//  BeaconMall
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 zkjinshi. All rights reserved.
//

#import "BlurCommentView.h"
#import "UIImageEffects.h"
#define ANIMATE_DURATION    0.3f

#define kSheetViewHeight    156
@interface BlurCommentView ()
@property (strong, nonatomic) SuccessBlock success;
@property (strong, nonatomic) UIView *sheetView;
@property (strong, nonatomic) UITextView *commentTextView;
@end
@implementation BlurCommentView
{
//    UIView *_sheetView;
    CGFloat _keyboardHeight;
    UITextView *_commentTextView;
}

+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success
{
    BlurCommentView *commentView = [[BlurCommentView alloc] initWithFrame:view.bounds];
    if (commentView) {
        //增加EventResponsor
        [commentView addEventResponsors];
        //block
        commentView.success = success;
        
        //截图并虚化
        commentView.image = [UIImageEffects imageByApplyingLightEffectToImage:[commentView snapShot:view]];
        
        [view addSubview:commentView];
        [view addSubview:commentView.sheetView];
        [commentView.commentTextView becomeFirstResponder];
    }
}

+ (void)commentshowSuccess:(SuccessBlock)success
{
    [BlurCommentView commentshowInView:[UIApplication sharedApplication].keyWindow success:success];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.alpha = 0;
    
    CGRect rect = self.bounds;
    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - kSheetViewHeight, rect.size.width, kSheetViewHeight)];
    _sheetView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, 10, 50, 30);
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton addTarget:self action:@selector(cancelComment:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:cancelButton];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(_sheetView.bounds.size.width - 50 - 10, 10, 50, 30);
    commentButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [commentButton setTitle:@"发送" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:commentButton];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"写评论";
    label.frame = CGRectMake((_sheetView.bounds.size.width - 30) / 2, 10, 50, 30);
    label.font = [UIFont systemFontOfSize:14];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_sheetView addSubview:label];
    
    _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, _sheetView.bounds.size.height - 10 - 100, rect.size.width - 10 * 2, 100)];
    _commentTextView.text = nil;
    [_sheetView addSubview:_commentTextView];
}

- (UIImage *)snapShot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)addEventResponsors
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Botton Action
- (void)cancelComment:(id)sender {
    [_sheetView endEditing:YES];
}
- (void)comment:(id)sender {
    //发送请求
    if (_success) {
        _success();
    }
    //
    [_sheetView endEditing:YES];
}

- (void)dismissCommentView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
    [_sheetView removeFromSuperview];
}
#pragma mark -
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSLog(@"%@", aNotification);
    _keyboardHeight = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval animationDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 1;
        _sheetView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _sheetView.bounds.size.height - _keyboardHeight, _sheetView.bounds.size.width, 156);
        
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 0;
        _sheetView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _sheetView.bounds.size.width, 156);
    } completion:^(BOOL finished){
        [self dismissCommentView];
    }];
}
@end
