//
//  LXAlertViewTool.h
//  test
//
//  Created by 天边的星星 on 2019/6/18.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXAlertViewTool : NSObject

///开启相机授权
+ (void)alertViewAuthorizationCameraInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback;

///登录领取成长值
+ (LXAlertView *)alertViewLoginGetGrowthValueInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback;

///隐私政策
+ (LXAlertView *)alertViewPrivacyPolicyInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback;

///订单推送通知
+ (LXAlertView *)alertViewPushNotificationInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback;

///提示登录
+ (LXAlertView *)alertViewLoginTextInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj, NSString* text))callback;

//按钮垂直排列
+ (void)alertViewVerticalButtonsInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback;

@end

NS_ASSUME_NONNULL_END
