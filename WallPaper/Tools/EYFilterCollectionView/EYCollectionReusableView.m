//
//  EYCollectionReusableView.m
//  EYSmart
//
//  Created by Never on 2021/4/19.
//  Copyright © 2021 一应科技. All rights reserved.
//

#import "EYCollectionReusableView.h"

@implementation EYCollectionReusableView

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    frame.size.height = frame.size.height + 80 + 20;
}

@end
