//
//  PDFReaderSlideController.h
//  PDFReader
//
//  Created by  atide on 16/6/7.
//  Copyright © 2016年  atide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFReaderSlideController : UIViewController <UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    
    UIScrollView *_prevPageView;
    UIScrollView *_currentPageView;
    UIScrollView *_nextPageView;
    
    NSInteger _currentPageIndex;
    CGFloat offset;
    UILabel *_labelPage;
}
@property float scale_;
-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center;
-(void) skip: (NSInteger) num;
@property (weak, nonatomic) IBOutlet UIView *pdfView;

@end
