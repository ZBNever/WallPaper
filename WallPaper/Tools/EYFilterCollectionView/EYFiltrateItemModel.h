//
//  EYFiltrateItemModel.h
//  EYSmart
//
//  Created by Never on 2021/4/26.
//  Copyright © 2021 一应科技. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EYFiltrateItemModel : NSObject
/** 标题文字 */
@property (nonatomic, strong) NSString *titleStr;
/** 是否选中 */
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end


