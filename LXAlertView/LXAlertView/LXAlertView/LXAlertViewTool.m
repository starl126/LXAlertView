//
//  LXAlertViewTool.m
//  test
//
//  Created by 天边的星星 on 2019/6/18.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAlertViewTool.h"
#import "LXAlertView.h"

@implementation LXAlertViewTool

+ (void)alertViewAuthorizationCameraInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback {
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.closeImgName = @"closed_btn";
    alertView.originY = 20;
    alertView.imgName = @"xiangji";
    alertView.imgWidth = 100;
    alertView.imgHeight = 80;
    
    alertView.text = @"开启相机权限";
    alertView.textFont = [UIFont boldSystemFontOfSize:18];
    alertView.textColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    
    alertView.subText = @"开启后才能进行拍摄或是扫二维码";
    alertView.subTextColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0];
    alertView.subTextBackgroundColor = UIColor.whiteColor;
    
    alertView.textViewHeight = 0;
    
    alertView.btnTitlesArr = @[@"去开启"];
    alertView.btnFontsArr = @[[UIFont boldSystemFontOfSize:15]];
    UIColor* color = [UIColor colorWithRed:76.0/255.0 green:147.0/255.0 blue:247.0/255.0 alpha:1.0];
    alertView.btnColorsArr = @[color.copy];
    
    color = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:0.1];
    alertView.btnBorderColorArr = @[color];
    alertView.queueType = LXAlertViewButtonQueueTypeHorizonal;
    alertView.btnBorderWidthArr = @[@1.0];
    
    alertView.marginBetweenImageAndText = 16;
    alertView.marginBetweenTextAndSubText = 10;
    alertView.marginBetweenSubTextAndTextView = 0;
    alertView.marginBetweenTextViewAndButton = 10;
    alertView.marginLeftXSubText = 20;
    alertView.marginRightXSubText = 20;
    alertView.marginLeftXLeftButton = -1;
    alertView.marginRightXRightButton = -1;
    
    alertView.marginButtonBottom = -1;
    alertView.alertEventBlock = ^(LXAlertViewEventType eventType, id  _Nullable obj, NSString * _Nullable text) {
        if (callback) {
            callback(eventType, obj);
        }
    };
    
    alertView.backgroundColor = UIColor.whiteColor;
    alertView.layer.cornerRadius = 2;
    [inView addSubview:alertView];
}
+ (LXAlertView *)alertViewLoginGetGrowthValueInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback; {
    
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.closeImgName = @"closed_btn";
    
    alertView.imgName = @"tree";
    
    UIColor* color = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    UIFont* font = [UIFont systemFontOfSize:16];
    NSMutableAttributedString* attText = [[NSMutableAttributedString alloc] initWithString:@"你已获得+5成长值" attributes:@{NSForegroundColorAttributeName:color.copy, NSFontAttributeName:font}];
    color = [UIColor colorWithRed:233.0/255.0 green:83.0/255 blue:95.0/255.0 alpha:1.0];
    [attText addAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font} range:NSMakeRange(4, 2)];
    alertView.attText = attText.copy;
    
    alertView.textViewHeight = 0;
    alertView.btnTitlesArr = @[@"登录领取"];
    alertView.btnColorsArr = @[UIColor.whiteColor];
    alertView.btnFontsArr  = @[[UIFont systemFontOfSize:20]];
    alertView.btnBackgroundColorsArr = @[color];
    alertView.btnCornerRadiusArr = @[@4];
    
    alertView.marginLeftXText = 0;
    alertView.marginRightXText = 0;
    alertView.marginBetweenImageAndText = 16;
    alertView.marginBetweenTextAndSubText = 0;
    alertView.marginBetweenSubTextAndTextView = 0;
    alertView.marginBetweenTextViewAndButton = 20;
    alertView.marginLeftXLeftButton = 20;
    alertView.marginRightXRightButton = 20;
    alertView.textViewHeight = 0;
    
    alertView.autoHideWhenEvent = NO;
    alertView.alertEventBlock = ^(LXAlertViewEventType eventType, id  _Nullable obj, NSString * _Nullable text) {
        if (callback) {
            callback(eventType, obj);
        }
    };
    
    [inView addSubview:alertView];
    
    alertView.transform = CGAffineTransformMakeScale(0, 0);
    alertView.maskBackView.alpha = 0.0;
    
    return alertView;
}
+ (LXAlertView *)alertViewPrivacyPolicyInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback; {
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.text = @"程序员开发隐私政策";
    alertView.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    alertView.textFont = [UIFont boldSystemFontOfSize:16];
    
    NSMutableAttributedString* attText = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 1;
    style.paragraphSpacing = 5;
    
    NSString* text = @"感谢您使用程序员宣言！为帮助您安全使用产品和服务，在您同意并授权的基础上，我们可能会收集您公司的名称、法定联系人、加班情况、位置信息等，以便政府及时遏制996加班制度。请您在使用前务必仔细阅读并透彻理解";
    UIColor* color = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    UIFont* font = [UIFont systemFontOfSize:14];
    
    NSAttributedString* att1 = [[NSAttributedString alloc] initWithString:text.copy attributes:@{NSForegroundColorAttributeName:color.copy, NSFontAttributeName:font.copy, NSParagraphStyleAttributeName:style}];
    [attText appendAttributedString:att1.copy];
    
    NSURL* url = [NSURL URLWithString:@"https://996.icu/#/zh_CN"];
    color = [UIColor colorWithRed:138.0/255.0 green:194.0/255.0 blue:239.0/255.0 alpha:1.0];
    att1 = [[NSAttributedString alloc] initWithString:@"《996程序员抗争宣言》" attributes:@{NSLinkAttributeName:url,NSForegroundColorAttributeName:color.copy, NSFontAttributeName:font.copy,NSParagraphStyleAttributeName:style}];
    [attText appendAttributedString:att1.copy];
    
    text = @"\n如您同意此政策，请点击\"同意\"并开始使用我们的产品和服务，我们尽全力保护您的个人信息安全";
    font = [UIFont systemFontOfSize:13];
    color = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    att1 = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color.copy, NSFontAttributeName:font.copy,NSParagraphStyleAttributeName:style}];
    
    [attText appendAttributedString:att1.copy];
    
    NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"circle"];
    att1 = [NSAttributedString attributedStringWithAttachment:attachment];
    attachment.bounds = CGRectMake(0, -4, 15, 15);
    [attText appendAttributedString:att1.copy];
    
    alertView.textViewAttText = attText.copy;
    alertView.textViewAllowInput = NO;
    
    color = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
    font = [UIFont systemFontOfSize:14];
    alertView.btnTitlesArr = @[@"不同意", @"同意"];
    alertView.btnColorsArr = @[color.copy,UIColor.whiteColor];
    alertView.btnBackgroundColorsArr = @[UIColor.whiteColor, [UIColor colorWithRed:75.0/255.0 green:149.0/255.0 blue:247.0/255.0 alpha:1.0]];
    alertView.btnFontsArr = @[font.copy,font.copy];
    alertView.btnBorderColorArr = @[UIColor.lightGrayColor,UIColor.clearColor];
    alertView.btnBorderWidthArr = @[@(1.0/UIScreen.mainScreen.scale),@0];
    alertView.btnCornerRadiusArr = @[@2,@2];
    alertView.btnHeight = 32;
    
    alertView.marginLeftXTextView = 8;
    alertView.marginRightXTextView = 8;
    alertView.marginLeftXLeftButton = 16;
    alertView.marginRightXRightButton = 16;
    alertView.marginBetweenButtons = 10;
    alertView.marginButtonBottom = 10;
    alertView.marginBetweenImageAndText = 0;
    alertView.marginBetweenTextAndSubText = 0;
    alertView.marginBetweenSubTextAndTextView = 0;
    alertView.marginBetweenTextViewAndButton = 0;
    
    alertView.autoHideWhenEvent = NO;
    alertView.alertEventBlock = ^(LXAlertViewEventType eventType, id  _Nullable obj, NSString * _Nullable text) {
        if (callback) {
            callback(eventType, obj);
        }
    };;
    
    alertView.layer.cornerRadius = 4;
    [inView addSubview:alertView];
    alertView.transform = CGAffineTransformMakeScale(0, 0);
    alertView.maskBackView.alpha = 0.0;
    
    return alertView;
}
+ (LXAlertView *)alertViewPushNotificationInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback {
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.imgName = @"push";
    alertView.imgWidth = 140;
    alertView.imgHeight = 100;
    
    alertView.text = @"打开推送通知";
    alertView.textColor = UIColor.blackColor;
    alertView.textFont = [UIFont boldSystemFontOfSize:18];
    alertView.textAlignment = NSTextAlignmentLeft;
    
    alertView.subText = @"允许推送通知，才不会错过成功报名的消息哦";
    alertView.subTextFont = [UIFont systemFontOfSize:13];
    alertView.subTextColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    alertView.subTextAlignment = NSTextAlignmentLeft;
    
    alertView.textViewHeight = 0;
    
    alertView.btnTitlesArr = @[@"下次再说",@"打开通知"];
    UIColor* color1 = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    UIColor* color2 = [UIColor colorWithRed:75.0/255.0 green:149.0/255.0 blue:247.0/255.0 alpha:1.0];
    alertView.btnColorsArr = @[color1.copy,color2.copy];
    alertView.btnBorderWidthArr = @[@(1.0/UIScreen.mainScreen.scale),@(1.0/UIScreen.mainScreen.scale)];
    
    color1 = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    alertView.btnBorderColorArr = @[color1.copy,color1.copy];
    UIFont* font = [UIFont systemFontOfSize:13];
    alertView.btnFontsArr = @[font,font];
    alertView.btnHeight = 34;
    
    alertView.marginBetweenImageAndText = 20;
    alertView.marginBetweenTextAndSubText = 8;
    alertView.marginBetweenSubTextAndTextView = 0;
    alertView.marginBetweenTextViewAndButton = 15;
    alertView.marginButtonBottom = -1;
    alertView.marginLeftXText = 10;
    alertView.marginRightXText = 10;
    alertView.marginLeftXSubText = 10;
    alertView.marginRightXSubText = 10;
    alertView.marginLeftXLeftButton = 0;
    alertView.marginRightXRightButton = 0;
    alertView.marginBetweenButtons = 0;
    
    alertView.layer.cornerRadius = 4;
    alertView.autoHideWhenEvent = NO;
    alertView.alertEventBlock = ^(LXAlertViewEventType eventType, id  _Nullable obj, NSString * _Nullable text) {
        if (callback) {
            callback(eventType, obj);
        }
    };;
    
    [inView addSubview:alertView];
    alertView.maskBackView.alpha = 0.0;
    alertView.transform = CGAffineTransformMakeScale(0, 0);
    
    return alertView;
}
+ (LXAlertView *)alertViewLoginTextInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj, NSString* text))callback {
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.text = @"提示";
    alertView.textFont = [UIFont boldSystemFontOfSize:20];
    alertView.textColor = UIColor.blackColor;
    
    alertView.subText = @"确定退出登录？";
    alertView.subTextFont = [UIFont systemFontOfSize:16];
    alertView.subTextColor = UIColor.blackColor;
    
    alertView.textViewHeight = 30;
    alertView.textViewAllowInput = YES;
    alertView.textViewTextFont = [UIFont systemFontOfSize:16];
    alertView.textViewTextColor = UIColor.darkGrayColor;
    alertView.textViewBorderColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0];
    alertView.textViewBorderWidth = 1.0;
    
    alertView.btnTitlesArr = @[@"取消",@"确定"];
    UIColor* color1 = [UIColor colorWithRed:79.0/255.0 green:136.0/255.0 blue:240.0/255.0 alpha:1.0];
    UIColor* color2 = [UIColor colorWithRed:92.0/255.0 green:154.0/255.0 blue:242.0/255.0 alpha:1.0];
    alertView.btnFontsArr = @[[UIFont systemFontOfSize:20],[UIFont systemFontOfSize:20]];
    alertView.btnColorsArr = @[color1.copy,color2.copy];
    color1 = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    alertView.btnBorderColorArr = @[color1.copy,color1.copy];
    alertView.btnBorderWidthArr = @[@(0.5),@0.5];
    
    alertView.marginBetweenImageAndText = 0;
    alertView.marginBetweenTextAndSubText = 8;
    alertView.marginBetweenSubTextAndTextView = 25;
    alertView.marginBetweenTextViewAndButton = 15;
    alertView.marginButtonBottom = -1;
    alertView.marginLeftXTextView = 15;
    alertView.marginRightXTextView = 15;
    alertView.marginLeftXLeftButton = 0;
    alertView.marginRightXRightButton = 0;
    alertView.marginBetweenButtons = -0.5;
    alertView.btnHeight = 40;
    
    alertView.autoHideWhenEvent = NO;
    alertView.alertEventBlock = callback;
    
    alertView.layer.cornerRadius = 4.0;
    [inView addSubview:alertView];
    alertView.transform = CGAffineTransformMakeScale(0, 0);
    alertView.maskBackView.alpha = 0.0;
    
    return alertView;
}
+ (void)alertViewVerticalButtonsInView:(UIView *)inView callback:(void (^)(LXAlertViewEventType eventType, id obj))callback {
    LXAlertView* alertView = [[LXAlertView alloc] init];
    alertView.alertViewWidth = inView.frame.size.width-100;
    
    alertView.text = @"测试垂直排列按钮";
    alertView.subText = @"垂直按钮排版，此处省去......";
    alertView.textViewHeight = 0;
    
    alertView.btnTitlesArr = @[@"按钮1",@"按钮2",@"按钮3"];
    UIFont* font = [UIFont systemFontOfSize:18];
    alertView.btnFontsArr = @[font,font,font];
    alertView.queueType = LXAlertViewButtonQueueTypeVertical;
    UIColor* color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    alertView.btnBorderColorArr = @[color,color,color];
    alertView.btnBorderWidthArr = @[@0.5,@0.5,@0.5];
    
    alertView.marginBetweenImageAndText = 0;
    alertView.marginBetweenSubTextAndTextView = 0;
    alertView.marginButtonBottom = -0.5;
    alertView.marginBetweenButtons = -0.5;
    alertView.marginLeftXLeftButton = 0;
    alertView.marginRightXRightButton = 0;
    alertView.btnHeight = 34;
    alertView.layer.cornerRadius = 4;
    alertView.layer.masksToBounds = YES;
    
    [inView addSubview:alertView];
    alertView.alertEventBlock = ^(LXAlertViewEventType eventType, id  _Nullable obj, NSString * _Nullable text) {
        if (callback) {
            callback(eventType, obj);
        }
    };
}

@end
