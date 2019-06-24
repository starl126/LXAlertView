//
//  ViewController.m
//  LXAlertView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAlertViewController.h"
#import "LXAlertViewTool.h"

@interface LXAlertViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LXAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self p_testCamera];
            break;
        case 1:
            [self p_testGrowthValue];
            break;
        case 2:
            [self p_testPrivatePolicy];
            break;
        case 3:
            [self p_testPushNotification];
            break;
        case 4:
            [self p_testLoginTextView];
            break;
        case 5:
            [self p_testVerticalButtons];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)p_testVerticalButtons {
    [LXAlertViewTool alertViewVerticalButtonsInView:self.view callback:^(LXAlertViewEventType eventType, id  _Nonnull obj) {
        NSLog(@"obj=%@", obj);
    }];
}
- (void)p_testLoginTextView {
    __block LXAlertView* alertView = [LXAlertViewTool alertViewLoginTextInView:self.view callback:^(LXAlertViewEventType eventType, id  _Nonnull obj, NSString* text) {
        NSLog(@"idx=%@,text=%@", obj,text);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            alertView.maskBackView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [alertView remove];
        }];
    }];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        alertView.maskBackView.alpha = 1.0;
    } completion:nil];
}
- (void)p_testPushNotification {
    __block LXAlertView* alertView = [LXAlertViewTool alertViewPushNotificationInView:self.view callback:^(LXAlertViewEventType eventType, id  _Nonnull obj) {
        NSLog(@"idx=%@", obj);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            alertView.maskBackView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [alertView remove];
        }];
    }];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        alertView.maskBackView.alpha = 1.0;
    } completion:nil];
}
- (void)p_testPrivatePolicy {
    
    __block LXAlertView* alertView = [LXAlertViewTool alertViewPrivacyPolicyInView:self.view callback:^(LXAlertViewEventType eventType, id  _Nonnull obj) {
        if (eventType == LXAlertViewEventTypeTextView) {
            NSLog(@"attachment=%@", obj);
        }else {
            NSLog(@"idx=%@", obj);
        }
        [alertView remove];
    }];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        alertView.maskBackView.alpha = 1.0;
    } completion:nil];
}
- (void)p_testCamera {
    [LXAlertViewTool alertViewAuthorizationCameraInView:self.view callback:^(LXAlertViewEventType eventType, id obj){
        NSLog(@"点击了去开启---%d", eventType);
    }];
}
- (void)p_testGrowthValue {
    
    __block LXAlertView* alertView = [LXAlertViewTool alertViewLoginGetGrowthValueInView:self.view callback:^(LXAlertViewEventType eventType, id obj) {
        if (eventType == LXAlertViewEventTypeClose) {
            [alertView remove];
        }else {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                alertView.maskBackView.alpha = 0;
                alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [alertView remove];
            }];
        }
    }];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        alertView.maskBackView.alpha = 1.0;
    } completion:nil];
}

@end
