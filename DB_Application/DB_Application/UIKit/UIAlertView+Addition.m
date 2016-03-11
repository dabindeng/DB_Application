//
//  UIAlertView+Addition.m
//  Epweike_Witkey
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 zengxusheng. All rights reserved.
//

#import "UIAlertView+Addition.h"

@implementation UIAlertView(Addition)



- (void)textFieldResignFirstResponder
{
    for (UIWindow *w in [[UIApplication sharedApplication] windows])
    {
        [w endEditing:YES];
    }
}

@end
