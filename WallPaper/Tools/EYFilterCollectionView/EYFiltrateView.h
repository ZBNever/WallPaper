//
//  EYFiltrateView.h
//  EYSmart
//
//  Created by Never on 2021/4/25.
//  Copyright © 2021 一应科技. All rights reserved.
//  筛选视图

#import <UIKit/UIKit.h>
#import "EYFiltrateItemModel.h"
NS_ASSUME_NONNULL_BEGIN

//typedef enum : NSUInteger {
//    EYFiltrateViewCancelBtn,
//    EYFiltrateViewResetBtn,
//    EYFiltrateViewConfirmBtn,
//} EYFiltrateViewBtnType;

typedef void(^CancelBtnBlock)(UIButton *sender);
typedef void(^ConfirmBtnBlock)(UIButton *sender,NSArray <NSIndexPath *> *selectedIndexPathArr);

@interface EYFiltrateView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *titleView;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

@property (strong, nonatomic) IBOutlet UIButton *resetBtn;

@property (nonatomic, strong) NSMutableArray <NSString *> *titleStrArr;

@property (nonatomic, strong) CancelBtnBlock cancelBlock;

@property (nonatomic, strong) ConfirmBtnBlock confirmBtnBlock;

///
+ (instancetype)initUI;

#pragma mark - data
///字符串二维数组
//@property (nonatomic, strong) NSArray <NSArray *> *dataArr;

/// 数据流入
/// @param dataArr 数据源
/// @param indexPathArr 数据源中选中item
-(void)configData:(NSArray<NSArray<NSString *> *> *)dataArr
         titleArr:(NSArray<NSString *> *)titleArr
selectedIndexPath:(NSArray<NSIndexPath *> *)indexPathArr;
@end

NS_ASSUME_NONNULL_END
