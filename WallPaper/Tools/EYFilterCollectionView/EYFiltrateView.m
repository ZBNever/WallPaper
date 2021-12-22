//
//  EYFiltrateView.m
//  EYSmart
//
//  Created by Never on 2021/4/25.
//  Copyright © 2021 一应科技. All rights reserved.
//

#import "EYFiltrateView.h"
#import "EYFiltrateItemCell.h"
#import "EYCollectionReusableView.h"
#import "EYFiltrateItemModel.h"

@interface EYFiltrateView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<NSMutableArray< EYFiltrateItemModel *> *> *dataMA;
@property (nonatomic, strong) NSMutableArray *selectedMA;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation EYFiltrateView

+(instancetype)initUI{
    return [[[NSBundle mainBundle] loadNibNamed:@"EYFiltrateView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"EYFiltrateItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EYFiltrateItemCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"EYCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:@"EYCollectionReusableViewHeader" withReuseIdentifier:@"EYCollectionReusableView"];
    
}
-(void)configData:(NSArray<NSArray *> *)dataArr
         titleArr:(NSArray<NSString *> *)titleArr
selectedIndexPath:(NSArray *)indexPathArr{
    _titleArr = titleArr;
    if (dataArr.count!=0) {
        [self.dataMA removeAllObjects];
        for (NSArray *rowArr in dataArr) {
            NSMutableArray *rowMA = NSMutableArray.array;
            for (NSString *titleArr in rowArr) {
                EYFiltrateItemModel *model = EYFiltrateItemModel.new;
                model.titleStr = titleArr;
                [rowMA addObject:model];
            }
            [self.dataMA addObject:rowMA];
        }
    }
    if (indexPathArr.count != 0) {
        for (NSIndexPath *indexPath in indexPathArr) {
            if (indexPath.section<self.dataMA.count&&indexPath.row<self.dataMA[indexPath.section].count) {
                self.dataMA[indexPath.section][indexPath.row].isSelected = YES;
                self.dataMA[indexPath.section][indexPath.row].indexPath = indexPath;
            }
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataMA.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataMA[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EYFiltrateItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EYFiltrateItemCell" forIndexPath:indexPath];
    cell.itemModel = self.dataMA[indexPath.section][indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataMA[indexPath.section] enumerateObjectsUsingBlock:^(EYFiltrateItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = NO;
        obj.indexPath = nil;
        if (indexPath.row == idx) {
            obj.isSelected = YES;
            obj.indexPath = indexPath;
        }
    }];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    EYCollectionReusableView *reusableView = nil;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        EYCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:@"EYCollectionReusableView" withReuseIdentifier:@"EYCollectionReusableView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor clearColor];
        reusableView = headerView;
        
    }
    if (indexPath.section<self.titleArr.count) {
        reusableView.titleLab.text = self.titleArr[indexPath.section];
    }else{
        reusableView.titleLab.text = @"-";
    }
    
    return reusableView;
}


- (IBAction)cancelBtnAction:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock(sender);
    }
}
- (IBAction)resetBtnAction:(UIButton *)sender {
    for (NSMutableArray *sectionMA in self.dataMA) {
        for (EYFiltrateItemModel *model in sectionMA) {
            model.isSelected = NO;
            model.indexPath = nil;
        }
    }
    [self.collectionView reloadData];
}
- (IBAction)confirmBtnAction:(UIButton *)sender {
    if (self.confirmBtnBlock) {
        NSMutableArray *indexPathMA = NSMutableArray.array;
        for (NSMutableArray*sectionMA in self.dataMA) {
            for (EYFiltrateItemModel *model in sectionMA) {
                if (model.indexPath) {
                    [indexPathMA addObject:model.indexPath];
                    break;
                }
            }
        }
        self.confirmBtnBlock(sender, indexPathMA);
    }
}
#pragma mark - getter
-(NSMutableArray *)dataMA{
    if (!_dataMA) {
        _dataMA = NSMutableArray.array;
    }
    return _dataMA;
}
@end
