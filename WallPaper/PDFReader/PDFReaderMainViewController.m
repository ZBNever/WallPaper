//
//  PDFReaderViewController.m
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//
#import "PDFPageController.h"
#import "CommentNode.h"
#import "PDFReaderMainViewController.h"
#import "ContentsViewController.h"
#import "PDFReader.h"
#import "HWPDFBrowseScrollView.h"

@interface PDFReaderMainViewController ()<UIScrollViewDelegate>{
    CGPDFDocumentRef pdfDocument;
    
}
@property (nonatomic, strong) HWPDFBrowseScrollView *scrollView;
@end

@implementation PDFReaderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"PDF浏览";
   
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)@"Catalog.pdf", NULL, NULL);
    pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    CFRelease(pdfURL);
    
   
    pdfPageModel = [[PDFPageModel alloc] initWithPDFDocument:pdfDocument];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger: UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    pageViewCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                 options:options];
    PDFPageController *initialViewController = [pdfPageModel viewControllerAtIndex:1];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [pageViewCtrl setDataSource:pdfPageModel];
    
    [pageViewCtrl setViewControllers:viewControllers
                           direction:UIPageViewControllerNavigationDirectionReverse
                            animated:NO
                          completion:^(BOOL f){}];
    [self addChildViewController:pageViewCtrl];
//    [self.view addSubview:pageViewCtrl.view];
    
    
    //scrollView
    HWPDFBrowseScrollView *scrollView = [[HWPDFBrowseScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.maximumZoomScale = 3.0;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    [scrollView addSubview:pageViewCtrl.view];
    
    [pageViewCtrl didMoveToParentViewController:self];
    
    UIButton * button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 20, 20);
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        button.frame = CGRectMake(self.view.frame.size.width-30, self.view.frame.size.height-30, 20, 20);
//    }else{
//    button.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50, 35, 35);
//    }
    [button setBackgroundImage:[UIImage imageNamed:@"mainMore"] forState:UIControlStateNormal];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [button addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    [self.view addSubview:button];
   
}

-(void)tapClick: (UITapGestureRecognizer *)gesture{
    NSArray * contents = [self getPDFContents:pdfDocument];
    if (contents && contents.count>0) {
//        ContentsViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContentsViewController"];
        
        ContentsViewController *viewController = [[ContentsViewController alloc] init];
        viewController.contents = contents;
        viewController.title = @"Contents";
        [self.navigationController pushViewController:viewController animated:YES];

    }else{
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此书还没有编辑目录" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }
    
}

-(void) skip:(NSInteger)num{
    PDFPageController *initialViewController = [pdfPageModel viewControllerAtIndex:num];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
   
    
    [pageViewCtrl setViewControllers:viewControllers
                           direction:UIPageViewControllerNavigationDirectionReverse
                            animated:NO
                          completion:^(BOOL f){}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取pdf文件目录
- (NSArray *)getPDFContents: (CGPDFDocumentRef) myDocument
{
   
    CGPDFDictionaryRef mycatalog= CGPDFDocumentGetCatalog(myDocument);
    CommentNode *rootNode = [[CommentNode alloc] initWithCatalog:mycatalog];
    CommentNode *rootOutlineNode = [rootNode childrenForName:@"/Outlines"];
    CommentNode *pagesNode = [rootNode childrenForName:@"/Pages"];
    NSArray *pagesArray = [self getPagesFromPagesNode:pagesNode];
    CommentNode *destsNode = [rootNode childrenForName:@"/Dests"];
    
    return [self getContentsForOutlineNode:rootOutlineNode pages:pagesArray destsNode:destsNode];
}

- (NSArray *)getContentsForOutlineNode:(CommentNode *)rootOutlineNode pages:(NSArray *)pagesArray destsNode:(CommentNode *)destsNode
{
    NSMutableArray *outlineArray = [[NSMutableArray alloc] init];
    CommentNode *firstOutlineNode = [rootOutlineNode childrenForName:@"/First"];
    CommentNode *outlineNode = firstOutlineNode;
    while (outlineNode) {
        NSString *title = [[outlineNode childrenForName:@"/Title"] value];
        CommentNode *destNode = [outlineNode childrenForName:@"/Dest"];
        NSMutableDictionary *outline = [NSMutableDictionary dictionaryWithDictionary:@{@"Title": title}];
        int index = 0;
        if (destNode) {
            if ([[destNode typeAsString] isEqualToString:@"Array"]) {
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[destNode children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            } else if ([[destNode typeAsString] isEqualToString:@"Name"]) {
                NSString *destName = [destNode value];
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[[[destsNode childrenForName:destName] childrenForName:@"/D"] children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            }
        } else {
            CommentNode *aNode = [outlineNode childrenForName:@"/A"];
            if (aNode) {
                CommentNode *dNode = [aNode childrenForName:@"/D"];
                if (dNode) {
                    CommentNode *d0Node = [[dNode children] objectAtIndex:0];
                    if ([[d0Node typeAsString] isEqualToString:@"Dictionary"]) {
                        CGPDFObjectRef dest = (CGPDFObjectRef)[d0Node object];
                        index = [self getIndexInPages:pagesArray forPage:dest];
                    }
                }
            }
        }
        [outline setObject:@(index) forKey:@"Index"];
        NSArray *subOutlines = [self getContentsForOutlineNode:outlineNode pages:pagesArray destsNode:destsNode];
        [outline setObject:subOutlines forKey:@"SubContents"];
        [outlineArray addObject:outline];
        outlineNode = [outlineNode childrenForName:@"/Next"];
    }
    return outlineArray;
}

- (NSArray *)getPagesFromPagesNode:(CommentNode *)pagesNode
{
    NSMutableArray *pages = [NSMutableArray new];
    CommentNode *kidsNode = [pagesNode childrenForName:@"/Kids"];
    for (CommentNode *node in [kidsNode children]) {
        NSString *type = [[node childrenForName:@"/Type"] value];
        if ([type isEqualToString:@"/Pages"]) {
            NSArray *kidsPages = [self getPagesFromPagesNode:node];
            [pages addObjectsFromArray:kidsPages];
        } else {
            [pages addObject:node];
        }
    }
    return pages;
}

- (int)getIndexInPages:(NSArray *)pages forPage:(CGPDFObjectRef)page
{
    for (int k = 0; k < pages.count; k++) {
        CommentNode *node = [pages objectAtIndex:k];
        if ([node object] == page)
            return k+1;
    }
    return 1;
}


@end
