//
//  LXAlertView.m
//  test
//
//  Created by 天边的星星 on 2019/6/14.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAlertView.h"

#define kLQHexColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]

@interface LXAlertView ()<UITextViewDelegate>

@property (nonatomic, strong, readonly) UIButton* closeBtn;
@property (nonatomic, strong, readonly) UIImageView* imgView;
@property (nonatomic, strong, readonly) UILabel* textLbl;
@property (nonatomic, strong, readonly) UILabel* subTextLbl;
@property (nonatomic, strong, readonly) UITextView* textView;
@property (nonatomic, strong, readonly) NSMutableArray<UIButton*>* buttonArrM;

///父控件
@property (nonatomic, weak) UIView* parentView;
///计算性属性，经过校准的父控件frame
@property (nonatomic, assign) CGRect parentFrame;

@end

@implementation LXAlertView

#pragma mark --- life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self p_initConfiguration];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initConfiguration];
    }
    return self;
}
- (void)p_initConfiguration {
    _buttonArrM = [NSMutableArray array];
    
    if (self.frame.size.width < 1.0) {
        _alertViewWidth = 260;
    }
    self.backgroundColor = UIColor.whiteColor;
    _alertViewWidth = 260;
    _closeDirection = LXAlertViewCloseDirectionTypeRight;
    _closeSize = CGSizeZero;
    
    _maskBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    
    _imgContentMode = UIViewContentModeScaleAspectFit;
    
    _textFont = [UIFont systemFontOfSize:16];
    _textColor = UIColor.darkTextColor;
    _textAlignment = NSTextAlignmentCenter;
    
    _subTextFont = [UIFont systemFontOfSize:15];
    _subTextColor = UIColor.darkTextColor;
    _subTextAlignment = NSTextAlignmentCenter;
    
    _textViewTextColor = UIColor.darkTextColor;
    _textViewTextFont = [UIFont systemFontOfSize:15];
    _textViewBackgroundColor = UIColor.whiteColor;
    _textViewHeight = 50;
    
    _btnHeight = 44;
    _queueType = LXAlertViewButtonQueueTypeHorizonal;
    
    _originY = 16;
    _marginCenterY = 0;
    _marginBetweenImageAndText = 20;
    _marginBetweenTextAndSubText = 20;
    _marginBetweenSubTextAndTextView = 20;
    _marginBetweenTextViewAndButton = 20;
    _marginLeftXText = 40;
    _marginRightXText = 40;
    _marginLeftXSubText = 40;
    _marginRightXSubText = 40;
    _marginLeftXTextView = 40;
    _marginRightXTextView = 40;
    _marginLeftXLeftButton = 40;
    _marginRightXRightButton = 40;
    _marginBetweenButtons = 20;
    _marginButtonBottom = 16;
    
    _marginCloseHoriznal = 0;
    _marginCloseVertical = 0;
    _autoHideWhenEvent = YES;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        _parentView = newSuperview;
        
        //校准父控件的frame
        [self p_adjustParentViewFrame];
        self.frame = CGRectMake((self.parentFrame.size.width-_alertViewWidth)*0.5, 0, _alertViewWidth, 0);
        [self p_setupView];
    }
}
///校准父控件的frame
- (void)p_adjustParentViewFrame {
    CGRect parantFrame = _parentView.frame;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (@available(iOS 11.0,*)) {
        inset = self.parentView.safeAreaInsets;
        parantFrame = CGRectMake(parantFrame.origin.x+inset.left, parantFrame.origin.y+inset.top, parantFrame.size.width-inset.left-inset.right, parantFrame.size.height-inset.top-inset.bottom);
    }else {
        if ([self.parentView isKindOfClass:UIScrollView.class]) {
            UIScrollView* scrollView = (UIScrollView*)self.parentView;
            inset = scrollView.contentInset;
            parantFrame = CGRectMake(parantFrame.origin.x+inset.left, parantFrame.origin.y+inset.top, parantFrame.size.width-inset.left-inset.right, parantFrame.size.height-inset.top-inset.bottom);
        }
    }
    self.parentFrame = parantFrame;
}
- (void)p_setupView {
    
    _maskBackView = UIView.alloc.init;
    _maskBackView.backgroundColor = _maskBackgroundColor;
    _maskBackView.frame = CGRectMake(0, 0, self.parentFrame.size.width, self.parentFrame.size.height);
    if (_allowMaskCallback) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_actionForClickMaskView)];
        [_maskBackView addGestureRecognizer:tap];
    }
    [self.parentView addSubview:_maskBackView];
    
    if (_closeImgName) {
        UIImage* img = [UIImage imageNamed:_closeImgName];
        if (img) {
            _closeBtn = UIButton.alloc.init;
            _closeBtn.contentMode = UIViewContentModeScaleAspectFit;
            [_closeBtn setImage:img forState:UIControlStateNormal];
            if (CGSizeEqualToSize(CGSizeZero, _closeSize)) {
                _closeSize = img.size;
            }
            if (_closeDirection == LXAlertViewCloseDirectionTypeLeft) {
                _closeBtn.frame = CGRectMake(_marginCloseHoriznal, _marginCloseVertical, _closeSize.width, _closeSize.height);
            }else {
                _closeBtn.frame = CGRectMake(_alertViewWidth-_marginCloseHoriznal-_closeSize.width, _marginCloseVertical, _closeSize.width, _closeSize.height);
            }
            [_closeBtn addTarget:self action:@selector(p_actionForCloseButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_closeBtn];
        }
    }
    
    
    _imgView = UIImageView.alloc.init;
    _imgView.backgroundColor = _imgBackgroundColor;
    _imgView.contentMode = _imgContentMode;
    
    _textLbl = UILabel.alloc.init;
    _textLbl.numberOfLines = 0;
    _textLbl.textAlignment = _textAlignment;
    _textLbl.backgroundColor = _textBackgroundColor;
    _textLbl.preferredMaxLayoutWidth = self.frame.size.width-_marginLeftXText-_marginRightXText;
    _textLbl.frame = CGRectMake(0, 0, _textLbl.preferredMaxLayoutWidth, 0);
    
    _subTextLbl = UILabel.alloc.init;
    _subTextLbl.numberOfLines = 0;
    _subTextLbl.textAlignment = _subTextAlignment;
    _subTextLbl.backgroundColor = _subTextBackgroundColor;
    _subTextLbl.preferredMaxLayoutWidth = self.frame.size.width-_marginLeftXSubText-_marginRightXSubText;
    _subTextLbl.frame = CGRectMake(0, 0, _subTextLbl.preferredMaxLayoutWidth, 0);
    
    _textView = UITextView.alloc.init;
    _textView.backgroundColor = _textViewBackgroundColor;
    _textView.layer.borderColor = _textViewBorderColor.CGColor;
    _textView.layer.borderWidth = _textViewBorderWidth;
    _textView.layer.cornerRadius = _textViewCornerRadius;
    _textView.font = _textViewTextFont;
    _textView.textColor = _textViewTextColor;
    _textView.editable = _textViewAllowInput;
    _textView.scrollEnabled = _textViewAllowInput;
    
    [self addSubview:self.imgView];
    [self addSubview:self.textLbl];
    [self addSubview:self.subTextLbl];
    [self addSubview:self.textView];
    
    //图片处理
    [self p_actionForInitImgView];
    
    //文本处理
    [self p_actionForInitTextLabel];
    
    //子文本处理
    [self p_actionForInitSubTextLabel];
    
    //text view处理
    [self p_actionForInitTextView];
    
    //按钮处理
    [self p_actionForInitButtons];
}
#pragma mark --- layout frame
- (void)layoutSubviews {
    [super layoutSubviews];
    [self p_actionForUpdateOrigin];
}
#pragma mark --- actions
- (void)setTextViewAllowInput:(BOOL)textViewAllowInput {
    _textViewAllowInput = textViewAllowInput;
    if (textViewAllowInput) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(p_actionForWillShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(p_actionForWillHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
}
- (void)p_actionForWillShowKeyboard:(NSNotification *)noti {
    CGFloat endKeyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSInteger curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //需要上移多少
    CGFloat marginMoveUp = 0;
    //转换坐标
    UIWindow* keyWindow = UIApplication.sharedApplication.delegate.window;
    CGPoint keyPoint = [self convertPoint:CGPointMake(0, self.frame.size.height) toView:keyWindow];
    if (keyPoint.y > endKeyboardY) {//需要上移
        marginMoveUp = keyPoint.y-endKeyboardY;
    }
    
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-marginMoveUp, self.frame.size.width, self.frame.size.height);
    } completion:nil];
}
- (void)p_actionForWillHideKeyboard:(NSNotification *)noti {
    NSInteger curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        self.frame = CGRectMake(self.frame.origin.x, (self.parentView.frame.size.height-self.frame.size.height)*0.5+self.marginCenterY, self.frame.size.width, self.frame.size.height);
    } completion:nil];
}
///图片处理，主要是设置图片的宽高
- (void)p_actionForInitImgView {
    if (_imgName) {
        UIImage* img = [UIImage imageNamed:_imgName];
        if (img) {
            if (_imgWidth < 1) {
                _imgWidth = img.size.width;
            }
            if (_imgHeight < 1) {
                _imgHeight = img.size.height;
            }
            _imgView.frame = CGRectMake(0, 0, _imgWidth, _imgHeight);
            _imgView.image = img;
        }
    }
}
///文本处理，主要是设置文本的宽高
- (void)p_actionForInitTextLabel {
    if (_text) {
        _textLbl.text = _text;
        _textLbl.font = _textFont;
        _textLbl.textColor = _textColor;
    }
    if (_attText) {
        _textLbl.attributedText = _attText;
    }
    [_textLbl sizeToFit];
    CGRect frame = _textLbl.frame;
    _textLbl.frame = CGRectMake(0, 0, _textLbl.preferredMaxLayoutWidth, frame.size.height);
}
///子文本处理，主要是设置子文本的宽高
- (void)p_actionForInitSubTextLabel {
    if (_subText) {
        _subTextLbl.text = _subText;
        _subTextLbl.font = _subTextFont;
        _subTextLbl.textColor = _subTextColor;
    }
    if (_subAttText) {
        _subTextLbl.attributedText = _subAttText;
    }
    [_subTextLbl sizeToFit];
    CGRect frame = _subTextLbl.frame;
    _subTextLbl.frame = CGRectMake(0, 0, _subTextLbl.preferredMaxLayoutWidth, frame.size.height);
}
///text view处理，主要是设置子text view的宽高
- (void)p_actionForInitTextView {
    if (_textViewAllowInput) {//允许输入
        _textView.frame = CGRectMake(0, 0, self.frame.size.width-_marginLeftXTextView-_marginRightXTextView, _textViewHeight);
    }else {//不允许输入
        _textView.text = _textViewText;
        _textView.attributedText = _textViewAttText;
        _textView.delegate = self;
        
        if (_textViewText || _textViewAttText) {
            CGSize size = [_textView sizeThatFits:CGSizeMake(self.frame.size.width-_marginLeftXTextView-_marginRightXTextView, CGFLOAT_MAX)];
            _textView.frame = CGRectMake(0, 0, self.frame.size.width-_marginLeftXTextView-_marginRightXTextView, size.height);
        }
    }
}
///按钮处理，主要是设置按钮的x和size
- (void)p_actionForInitButtons {
    if (_btnTitlesArr && _btnTitlesArr.count) {
        for (int i=0; i<_btnTitlesArr.count; i++) {
            UIButton* btn = UIButton.alloc.init;
            [btn setTitle:_btnTitlesArr[i] forState:UIControlStateNormal];
            
            if (_btnColorsArr && _btnColorsArr.count) {
                @try {
                    [btn setTitleColor:_btnColorsArr[i] forState:UIControlStateNormal];
                } @catch (NSException *exception) {
                    [btn setTitleColor:kLQHexColor(0x222222) forState:UIControlStateNormal];
                } @finally {
                    
                }
            }else {
                [btn setTitleColor:kLQHexColor(0x222222) forState:UIControlStateNormal];
            }
            
            if (_btnFontsArr && _btnFontsArr.count) {
                @try {
                    btn.titleLabel.font = _btnFontsArr[i];
                } @catch (NSException *exception) {
                    btn.titleLabel.font = [UIFont systemFontOfSize:15];
                } @finally {
                    
                }
            }else {
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
            }
            
            if (_btnBorderWidthArr && _btnBorderWidthArr.count) {
                @try {
                    btn.layer.borderWidth = _btnBorderWidthArr[i].floatValue;
                } @catch (NSException *exception) {
                    btn.layer.borderWidth = 0;
                } @finally {
                    
                }
            }
            
            if (_btnBorderColorArr && _btnBorderColorArr.count) {
                @try {
                    btn.layer.borderColor = _btnBorderColorArr[i].CGColor;
                } @catch (NSException *exception) {
                } @finally {
                    
                }
            }
            
            if (_btnCornerRadiusArr && _btnCornerRadiusArr.count) {
                @try {
                    btn.layer.cornerRadius = _btnCornerRadiusArr[i].floatValue;
                } @catch (NSException *exception) {
                    btn.layer.cornerRadius = 0;
                } @finally {
                    
                }
            }
            if (_btnBackgroundColorsArr && _btnBackgroundColorsArr.count) {
                @try {
                    btn.backgroundColor = _btnBackgroundColorsArr[i];
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
            }
            
            if (_queueType == LXAlertViewButtonQueueTypeHorizonal) {//水平排列
                CGFloat width = (self.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton-(_btnTitlesArr.count-1)*_marginBetweenButtons)/_btnTitlesArr.count;
                CGFloat x = _marginLeftXLeftButton+i*(width+_marginBetweenButtons);
                btn.frame = CGRectMake(x, 0, width, _btnHeight);
            }else {//垂直排列
                CGFloat width = self.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton;
                btn.frame = CGRectMake(_marginLeftXLeftButton, 0, width, _btnHeight);
            }
            btn.tag = i;
            [btn addTarget:self action:@selector(p_actionForClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArrM addObject:btn];
            [self addSubview:btn];
        }
    }
}
///更新控件的位置
- (void)p_actionForUpdateOrigin {
    
    //计算所有控件的有效高度
    CGFloat buttonTotalHeight = 0;
    if (self.buttonArrM.count && _queueType == LXAlertViewButtonQueueTypeHorizonal) {
        buttonTotalHeight = _btnHeight;
    }else if (self.buttonArrM.count && _queueType == LXAlertViewButtonQueueTypeVertical) {
        buttonTotalHeight = self.buttonArrM.count*_btnHeight+(self.buttonArrM.count-1)*_marginBetweenButtons;
    }else {}
    
    CGFloat totalHeight = self.imgView.frame.size.height+self.textLbl.frame.size.height+self.subTextLbl.frame.size.height+self.textView.frame.size.height+buttonTotalHeight+_originY+_marginBetweenImageAndText+_marginBetweenTextAndSubText+_marginBetweenSubTextAndTextView+_marginBetweenTextViewAndButton+_marginButtonBottom;
    NSAssert(totalHeight<=self.parentFrame.size.height, @"abnormal view's height is bigger than it's parent's");
    
    //计算控件的位置
    CGRect frame = self.imgView.frame;
    CGFloat x = (self.frame.size.width-self.imgWidth)*0.5;
    CGFloat y = _originY;
    self.imgView.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    frame = self.textLbl.frame;
    x = _marginLeftXText;
    y = CGRectGetMaxY(self.imgView.frame)+self.marginBetweenImageAndText;
    self.textLbl.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    frame = self.subTextLbl.frame;
    x = _marginLeftXSubText;
    y = CGRectGetMaxY(self.textLbl.frame)+self.marginBetweenTextAndSubText;
    self.subTextLbl.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    frame = self.textView.frame;
    y = CGRectGetMaxY(self.subTextLbl.frame)+_marginBetweenSubTextAndTextView;
    self.textView.frame = CGRectMake(_marginLeftXTextView, y, frame.size.width, frame.size.height);
    
    __weak typeof(self) weakself = self;
    if (_queueType == LXAlertViewButtonQueueTypeHorizonal) {//水平排列
        [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            obj.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(weakself.textView.frame)+weakself.marginBetweenTextViewAndButton, frame.size.width, frame.size.height);
        }];
    }else {//垂直排列
        CGFloat startY = CGRectGetMaxY(self.textView.frame)+_marginBetweenTextViewAndButton;
        [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat y = startY + idx*(obj.frame.size.height+weakself.marginBetweenButtons);
            obj.frame = CGRectMake(obj.frame.origin.x, y, obj.frame.size.width, obj.frame.size.height);
        }];
    }
    //校正alert view的最终frame
    y = (self.parentFrame.size.height-totalHeight)*0.5;
    self.frame = CGRectMake((self.parentFrame.size.width-_alertViewWidth)*0.5, y+_marginCenterY, _alertViewWidth, totalHeight);
}
- (void)p_actionForClickButton:(UIButton *)sender {
    [self endEditing:YES];
    NSString* text = nil;
    if (self.alertEventBlock) {
        if (_textViewAllowInput) {
            text = _textView.text;
        }
        self.alertEventBlock(LXAlertViewEventTypeButtons, @(sender.tag), text);
    }
    if (self.autoHideWhenEvent) {
        [self remove];
    }
}
- (void)p_actionForClickMaskView {
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeMask, nil, nil);
    }
    if (self.autoHideWhenEvent) {
        [self remove];
    }
}
- (void)p_actionForCloseButton:(UIButton *)sender {
    if (self.autoHideWhenEvent) {
        [self remove];
    }
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeClose, nil, nil);
    }
}
- (void)remove {
    [self.maskBackView removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark --- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeTextView, URL.copy, nil);
    }
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeTextView, textAttachment, nil);
    }
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeTextView, URL.copy, nil);
    }
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if (self.alertEventBlock) {
        self.alertEventBlock(LXAlertViewEventTypeTextView, textAttachment, nil);
    }
    return NO;
}
- (void)dealloc {
    if (_textViewAllowInput) {
        [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
    NSLog(@"dealloc --- %@", NSStringFromClass(self.class));
}

@end
