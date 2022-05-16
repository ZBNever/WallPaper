//
//  PDFPageModel.m
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import "PDFPageModel.h"
#import "PDFPageController.h"

@implementation PDFPageModel
-(id) initWithPDFDocument:(CGPDFDocumentRef) pdfDoc {
    self = [super init];
    if (self) {
        pdfDocument = pdfDoc;
    }
    return self;
}

- (PDFPageController *)viewControllerAtIndex:(NSUInteger)pageNO {
    // Return the data view controller for the given index.
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    if (pageSum== 0 || pageNO >= pageSum+1) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    PDFPageController *pageController = [[PDFPageController alloc] init];
    pageController.pdfDocument = pdfDocument;
    pageController.pageNO  = pageNO;
    return pageController;
}

- (NSUInteger)indexOfViewController:(PDFPageController *)viewController {
    return viewController.pageNO;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (PDFPageController *)viewController];
    if ((index == 1) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (PDFPageController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    if (index >= pageSum+1) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
@end
