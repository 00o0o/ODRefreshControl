//
//  ODLoadMoreControl.m
//  ODRefreshControlDemo
//
//  Created by Clover on 3/2/16.
//
//

#define kLoadingViewHeight 50.0
#define kLoadingText       @"上拉加载更多"
#define kLoadingTextSize   12.0
#define kPadding           5.0

#import "ODLoadMoreControl.h"

@interface ODLoadMoreControl ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, readwrite) BOOL loading;
@property (nonatomic) CGFloat contentHeight;
@end

@implementation ODLoadMoreControl

- (id)initInScrollView:(UIScrollView *)scrollView {
    return [self initInScrollView:scrollView activityIndicatorView:nil];
}

- (id)initInScrollView:(UIScrollView *)scrollView activityIndicatorView:(UIActivityIndicatorView *)activity {
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth(scrollView.frame), kLoadingViewHeight)];
    if(self) {
        self.scrollView = scrollView;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [scrollView addSubview:self];
        [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        
        _activity = activity ? activity : [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activity];
        _textLabel = [UILabel new];
        _textLabel.text = kLoadingText;
        _textLabel.textColor = [UIColor grayColor];
        _textLabel.font = [UIFont systemFontOfSize:kLoadingTextSize];
        [_textLabel sizeToFit];
        [self addSubview:_textLabel];
        
        _activity.center = self.center;
        _textLabel.center = self.center;
        
        self.hasmore = NO;
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    _textLabel.text = text;
    [_textLabel sizeToFit];
    _textLabel.center = self.center;
}

- (void)setTextColor:(UIColor *)textColor {
    _textLabel.textColor = textColor;
}

- (void)setHasmore:(BOOL)hasmore {
    _hasmore = hasmore;
    if(hasmore) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kLoadingViewHeight, 0);
    }else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    self.hidden = !hasmore;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    if([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange:change];
    }else if([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.frame.size.width, self.frame.size.height);
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    if(self.scrollView.contentOffset.y > 0 && (self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - self.scrollView.frame.size.height + kLoadingViewHeight)) >= 30 && !_loading && _hasmore) {
        [self beginLoading];
        
    }
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    self.scrollView = nil;
}

- (void)beginLoading {
    _loading = YES;
    _textLabel.hidden = YES;
    [_activity startAnimating];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)endLoading {
    _loading = NO;
    _textLabel.hidden = NO;
    [_activity stopAnimating];
}

@end
