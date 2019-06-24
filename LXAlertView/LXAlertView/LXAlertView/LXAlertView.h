//
//  LXAlertView.h
//  test
//
//  Created by 天边的星星 on 2019/6/14.
//  Copyright © 2019 starxin. All rights reserved.
//

#import <UIKit/UIKit.h>

///@summary 按钮排列方式，默认是水平排列
typedef NS_ENUM(uint, LXAlertViewButtonQueueType) {
    ///水平排序
    LXAlertViewButtonQueueTypeHorizonal = 0,
    ///垂直排序
    LXAlertViewButtonQueueTypeVertical
};
///@summary 关闭按钮的方向
typedef NS_ENUM(uint, LXAlertViewCloseDirectionType) {
    ///左上
    LXAlertViewCloseDirectionTypeLeft = 0,
    ///右上
    LXAlertViewCloseDirectionTypeRight
};
/**
 @summary 内部事件回调类型
 
 - LXAlertViewEventTypeMask: 蒙版点击事件
 - LXAlertViewEventTypeClose: 按钮关闭事件
 - LXAlertViewEventTypeButtons: 底部按钮事件
 - LXAlertViewEventTypeTextView: UITextView富文本内部事件：url链接和attachment事件
 */
typedef NS_ENUM(int, LXAlertViewEventType) {
    ///蒙版点击事件
    LXAlertViewEventTypeMask = -1,
    ///按钮关闭事件
    LXAlertViewEventTypeClose,
    ///底部按钮事件
    LXAlertViewEventTypeButtons,
    ///UITextView富文本内部事件：url链接和attachment事件
    LXAlertViewEventTypeTextView
};

/**
 弹窗界面事件回调
 
 @param eventType 内部事件类型，详情请查看LXAlertViewEventType定义
 @param obj 只在LXAlertViewEventTypeButtons和LXAlertViewEventTypeTextView事件类型下有效，用于区分具体事件对象，LXAlertViewEventTypeButtons下为按钮的索引对象，LXAlertViewEventTypeTextView为NSURL或者NSTextAttachment对象
 @param text 仅在textViewAllowInput=yes时才有值
 */
typedef void (^LXAlertEventBlock)(LXAlertViewEventType eventType, id __nullable obj, NSString* __nullable text);

NS_ASSUME_NONNULL_BEGIN

/**
 @summary 同系统UIAlertView的弹窗控件，此控件只是创建弹窗控件，相关显示动效需要自己去定制
 @detail 内部控件从上往下依次是：图片、文本、子文本、text view、按钮，根据设置动态计算size和origin，alertView的高度是动态计算的，顶部关闭按钮
 */
@interface LXAlertView : UIView

#pragma mark --- 全局设置
///alert view的宽度，默认是260
@property (nonatomic, assign, readwrite) CGFloat alertViewWidth;

#pragma mark --- 顶部关闭按钮
///顶部关闭按钮的图片名称，没有就不显示
@property (nonatomic, copy, readwrite) NSString* closeImgName;

///顶部按钮的方向，默认是LXAlertViewCloseDirectionTypeRight
@property (nonatomic, assign) LXAlertViewCloseDirectionType closeDirection;

///顶部按钮的size,若未设置则根据图片实际大小
@property (nonatomic, assign) CGSize closeSize;

#pragma mark --- 蒙版设置
///蒙版颜色，默认是黑色，alpha为0.3;
@property (nonatomic, strong) UIColor* maskBackgroundColor;

#pragma mark --- 图片属性设置
///图片名称，以图片有二进制数据为创建图片控件的依据
@property (nonatomic, copy, readwrite) NSString* imgName;

///图片宽度，默认值图片的实际宽度
@property (nonatomic, assign, readwrite) CGFloat imgWidth;

///图片高度，默认值图片的实际高度
@property (nonatomic, assign, readwrite) CGFloat imgHeight;

///图片显示模式，默认UIViewContentModeScaleAspectFit
@property (nonatomic, assign, readwrite) UIViewContentMode imgContentMode;

///图片的背景颜色，默认是无色
@property (nonatomic, strong, readwrite) UIColor* imgBackgroundColor;

#pragma mark --- 文本属性设置
///文本内容，若同时设置了富文本，则富文本优先级高，富文本下文本内容的其他属性设置无效
@property (nonatomic, copy, readwrite) NSString* text;

///文本富文本，不为空才会创建文本控件
@property (nonatomic, copy, readwrite) NSAttributedString* attText;

///文本字体大小，默认系统16，富文本无效
@property (nonatomic, strong, readwrite) UIFont* textFont;

///文本颜色，默认系统darkTextColor，富文本无效
@property (nonatomic, strong, readwrite) UIColor* textColor;

///文本的背景颜色
@property (nonatomic, strong, readwrite) UIColor* textBackgroundColor;

///文本对齐方式，默认是center，富文本无效
@property (nonatomic, assign) NSTextAlignment textAlignment;


///子文本内容，若同时设置了富文本，则富文本优先级高，富文本下文本内容的其他属性设置无效
@property (nonatomic, copy, readwrite) NSString* subText;

///子文本富文本，不为空才会创建子文本控件
@property (nonatomic, copy, readwrite) NSAttributedString* subAttText;

///子文本字体大小，默认系统15，富文本无效
@property (nonatomic, strong, readwrite) UIFont* subTextFont;

///子文本颜色默认系统darkTextColor，富文本无效
@property (nonatomic, strong, readwrite) UIColor* subTextColor;

///子文本的背景颜色
@property (nonatomic, strong, readwrite) UIColor* subTextBackgroundColor;

///子文本对齐方式，默认是center，富文本无效
@property (nonatomic, assign) NSTextAlignment subTextAlignment;

#pragma mark --- text view属性设置
///是否允许输入文本，若允许输入则高度为外界传入的textViewHeight高度，若不允许输入则为实际内容的高度，不可编辑内容不可滚动，并可回调内部url链接点击事件,默认是NO
@property (nonatomic, assign, readwrite) BOOL textViewAllowInput;

///text view的文本内容，富文本下无效
@property (nonatomic, copy, readwrite) NSString* textViewText;

///text view的富文本
@property (nonatomic, copy, readwrite) NSAttributedString* textViewAttText;

///text view的颜色，富文本无效，默认系统darkTextColor
@property (nonatomic, strong, readwrite) UIColor* textViewTextColor;

///text view的文本字体大小，默认系统15，富文本无效
@property (nonatomic, strong, readwrite) UIFont* textViewTextFont;

///text view的背景颜色，默认是白色
@property (nonatomic, strong, readwrite) UIColor* textViewBackgroundColor;

///text view的高度，默认值为50
@property (nonatomic, assign, readwrite) CGFloat textViewHeight;

///text view的border color
@property (nonatomic, strong, readwrite) UIColor* textViewBorderColor;

///text view的border width
@property (nonatomic, assign, readwrite) CGFloat textViewBorderWidth;

///text view的corner radius
@property (nonatomic, assign, readwrite) CGFloat textViewCornerRadius;

#pragma mark --- 按钮属性设置,注意按钮的宽度是根据间距和父控件宽度动态计算的
///按钮的标题数组，数组个数不等于0才会创建按钮控件
@property (nonatomic, strong, readwrite) NSArray<NSString*>* btnTitlesArr;

///按钮的标题颜色，默认0x222222
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnColorsArr;

///按钮的标题字体大小，默认系统15
@property (nonatomic, strong, readwrite) NSArray<UIFont*>* btnFontsArr;

///按钮的border宽度
@property (nonatomic, strong, readwrite) NSArray<NSNumber*>* btnBorderWidthArr;

///按钮的border颜色
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnBorderColorArr;

///按钮的corner radius
@property (nonatomic, strong, readwrite) NSArray<NSNumber*>* btnCornerRadiusArr;

///按钮背景颜色
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnBackgroundColorsArr;

///按钮高度，默认是44
@property (nonatomic, assign, readwrite) CGFloat btnHeight;

///按钮排序方式，默认是LXAlertViewButtonQueueTypeHorizonal
@property (nonatomic, assign, readwrite) LXAlertViewButtonQueueType queueType;

#pragma mark --- 间距设置
///alert view的子控件的初始y值，默认是16
@property (nonatomic, assign, readwrite) CGFloat originY;

///alert view的中心点距离父控件的中心点偏移量，默认是0
@property (nonatomic, assign, readwrite) CGFloat marginCenterY;

///图片和文本垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenImageAndText;

///文本和子文本垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenTextAndSubText;

///子文本和text view的垂直方向的间距，默认值20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenSubTextAndTextView;

///text view和按钮垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenTextViewAndButton;

///文本距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXText;

///文本距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXText;

///子文本距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXSubText;

///子文本距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXSubText;

///text view距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXTextView;

///text view距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXTextView;

///最左边按钮距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXLeftButton;

///最右边按钮距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXRightButton;

///按钮之间的间距，默认是20，当queueType=LXAlertViewButtonQueueTypeHorizonal时，此间距
///为水平按钮之间间距；当queueType=LXAlertViewButtonQueueTypeVertical时，此间距为垂直按钮之间的间距
@property (nonatomic, assign, readwrite) CGFloat marginBetweenButtons;

///按钮底部距离alert view的垂直方向的间距，默认值为16
@property (nonatomic, assign, readwrite) CGFloat marginButtonBottom;

///顶部关闭按钮的水平间距，默认是0，若方向为LXAlertViewCloseDirectionTypeLeft则为左边距，LXAlertViewCloseDirectionTypeRight则为右边距
@property (nonatomic, assign, readwrite) CGFloat marginCloseHoriznal;

///顶部关闭按钮垂直间距，默认是0
@property (nonatomic, assign, readwrite) CGFloat marginCloseVertical;

#pragma mark --- 回调设置
///是否允许点击蒙版回调回调，默认是NO
@property (nonatomic, assign, getter=isAllowMaskCallback) BOOL allowMaskCallback;
///内部事件回调：allowMaskCallback=yes时，点击蒙版才会回调
@property (nonatomic, copy) LXAlertEventBlock alertEventBlock;
///是否自动隐藏，内部事件触发时，默认是yes
@property (nonatomic, assign, getter=isAutoHide) BOOL autoHideWhenEvent;

#pragma mark --- actions
///内部蒙版控件共享给外部获取，方便做一些动画之类的操作
@property (nonatomic, strong, readonly) UIView* maskBackView;
///移除控件
- (void)remove;

@end

NS_ASSUME_NONNULL_END
