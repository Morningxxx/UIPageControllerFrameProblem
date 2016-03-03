//
//  ViewController.m
//  UIPageControllerFrameProblem
//
//  Created by Morning on 2016/03/03.
//  Copyright © 2016年 Morning. All rights reserved.
//

#import "ViewController.h"

#define COUNT 7

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundView;

@end

@implementation ViewController

/*
    This demo shows that how the UIPageControl's frame will be strange when it is on an parent view which has contracts.
    When the parent view has contracts, UIPageControl will occur an unknown err that make us somehow lose control to its frame.
    This demo shows some trying to kill the bug and re-control the frame.
 
    **NOTICE: If UIPageControl's parent doesn't have contracts or autoresizing, the problew would not occur.(Actually we will solve this problem in this way).
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
        My goal is to locate the pageContrl in the middle horizontally.
     */
    
    /*first try, make the width of pageContrl equal to the self.view's width.*/
    UIPageControl *pageContrlA = [[UIPageControl alloc]init];
    pageContrlA.numberOfPages = COUNT;
    CGRect frame = CGRectMake(0, 20, self.view.frame.size.width, 30);
    pageContrlA.frame = frame;
    pageContrlA.backgroundColor = [UIColor blackColor];
    pageContrlA.currentPageIndicatorTintColor = [UIColor redColor];
    pageContrlA.pageIndicatorTintColor = [UIColor greenColor];
    [self.backgroundView addSubview:pageContrlA];
    NSLog(@"pageContrlA's width = %lf",pageContrlA.frame.size.width);
    
    /*then, get the size the pageContrl should be be the offical-offered method*/
    UIPageControl *pageContrlB = [[UIPageControl alloc]init];
    pageContrlB.numberOfPages = COUNT;
    CGSize size = [pageContrlB sizeForNumberOfPages:COUNT];
    frame.size = size;
    frame.origin = CGPointMake((self.view.frame.size.width-size.width)/2, 55);
    pageContrlB.frame = frame;
    pageContrlB.backgroundColor = [UIColor blackColor];
    pageContrlB.currentPageIndicatorTintColor = [UIColor redColor];
    pageContrlB.pageIndicatorTintColor = [UIColor greenColor];
    [self.backgroundView addSubview:pageContrlB];
    NSLog(@"pageContrlB's width = %lf",pageContrlB.frame.size.width);
    NSLog(@"pageContrlB's origin.x = %lf",pageContrlB.frame.origin.x);

    /*creat a view to have the same frame to the pageContrl, to see what happend.*/
    UIView *viewB = [[UIView alloc]init];
    frame.origin.y = 95;
    viewB.frame = frame;
    viewB.backgroundColor = [UIColor orangeColor];
    [self.backgroundView addSubview:viewB];

    /*let's use the size we have got to creat a new parent view for pageContrl.*/
    UIPageControl *pageContrlC = [[UIPageControl alloc]init];
    pageContrlC.numberOfPages = COUNT;
    pageContrlC.backgroundColor = [UIColor blackColor];
    pageContrlC.currentPageIndicatorTintColor = [UIColor redColor];
    pageContrlC.pageIndicatorTintColor = [UIColor greenColor];

    UIView *viewC = [[UIView alloc]init];
    size = [pageContrlC sizeForNumberOfPages:COUNT];
    frame = CGRectMake((self.view.frame.size.width-size.width)/2, 185, size.width, size.height);
    viewC.frame = frame;
    viewC.backgroundColor = [UIColor blueColor];
    [self.backgroundView addSubview:viewC];

    pageContrlC.frame = CGRectMake(0, 0, size.width, size.height);
    [viewC addSubview:pageContrlC];

    /*why we have to get the size? No, we DON'T!*/
    UIPageControl *pageContrlD = [[UIPageControl alloc]init];
    pageContrlD.numberOfPages = COUNT;
    pageContrlD.backgroundColor = [UIColor blackColor];
    pageContrlD.currentPageIndicatorTintColor = [UIColor redColor];
    pageContrlD.pageIndicatorTintColor = [UIColor greenColor];
    
    UIView *viewD = [[UIView alloc]init];
    frame = CGRectMake(0, 225, self.view.frame.size.width, 35);
    viewD.frame = frame;
    viewD.backgroundColor = [UIColor blueColor];
    [self.backgroundView addSubview:viewD];
    
    pageContrlD.frame = viewD.bounds;
    [viewD addSubview:pageContrlD];

    
    /*Ok, honestly, i have made a trap before. Now let's back to the begin and use the self.backgroundView's width instead of self.view's width*/
    UIPageControl *pageContrlE = [[UIPageControl alloc]init];
    pageContrlE.numberOfPages = COUNT;
    size = [pageContrlE sizeForNumberOfPages:COUNT];
    frame.size = size;
    frame.origin = CGPointMake((self.backgroundView.frame.size.width-size.width)/2, 300);
    pageContrlE.frame = frame;
    pageContrlE.backgroundColor = [UIColor blackColor];
    pageContrlE.currentPageIndicatorTintColor = [UIColor redColor];
    pageContrlE.pageIndicatorTintColor = [UIColor greenColor];
    [self.backgroundView addSubview:pageContrlE];
    NSLog(@"pageContrlE's width = %lf",pageContrlE.frame.size.width);
    NSLog(@"pageContrlE's origin.x = %lf",pageContrlE.frame.origin.x);
    
    /*It seems work but just for the pageControl.*/
    UIView *viewE = [[UIView alloc]init];
    frame.origin.y = 340;
    viewE.frame = frame;
    viewE.backgroundColor = [UIColor orangeColor];
    [self.backgroundView addSubview:viewE];
/*
    It can strill be strange. The reason is unknown. 
    By notising the NSLog before, I geuss it maybe because of the basic-realize layer for auto layout by Apple.
    We should be careful when we using something which is similar to things in this demo, and hope Apple will give a detail explaination.
 */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
