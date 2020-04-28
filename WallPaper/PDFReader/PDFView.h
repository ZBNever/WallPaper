//
//  PDFView.h
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView{
    CGPDFDocumentRef pdfDocument;
    int pageNO;
}

-(id)initWithFrame:(CGRect)frame atPage:(long)index withPDFDoc:(CGPDFDocumentRef) pdfDoc;


@end
