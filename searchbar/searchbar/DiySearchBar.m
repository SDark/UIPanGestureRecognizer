//
//  DiySearchBar.m
//  DQLoc
//
//  Created by Mory on 2017/4/17.
//  Copyright © 2017年 Mory. All rights reserved.
//

#import "DiySearchBar.h"


@implementation DiySearchBar



-(void)layoutSubviews{


    for (UIView *view in self.subviews) {
        
        for (UIView *subView in view.subviews) {
       
            if ([subView isKindOfClass:[UITextField class]]) {

                subView.frame = CGRectMake(0, 0, self.bounds.size.width,  self.bounds.size.height);
            
            } 
        }
    }
}


@end
