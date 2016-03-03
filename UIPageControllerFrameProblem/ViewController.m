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
@property (weak, nonatomic) IBOutlet UIView *backgroundView; //添加了约束的背景视图作为主视图

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

    /*creat a view to have the same frame to the pageContrl, to see what happend*/
    UIView *viewB = [[UIView alloc]init];
    frame.origin.y = 95;
    viewB.frame = frame;
    viewB.backgroundColor = [UIColor orangeColor];
    [self.backgroundView addSubview:viewB];

    /*let's use the size we have got to creat a new parent view for pageContrl*/
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
