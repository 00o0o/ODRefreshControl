//
//  ODLoadMoreControl.h
//  ODRefreshControlDemo
//
//  Created by Clover on 3/2/16.
//
//

#import <UIKit/UIKit.h>

@interface ODLoadMoreControl : UIControl

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic) BOOL hasmore;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;

- (id)initInScrollView:(UIScrollView *)scrollView;
- (id)initInScrollView:(UIScrollView *)scrollView activityIndicatorView:(UIActivityIndicatorView *)activity;

- (void)endLoading;
@end
