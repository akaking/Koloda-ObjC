//
//  ViewController.m
//  Koloda-ObjC
//
//  Created by Vong on 15/8/17.
//  Copyright (c) 2015年 Vong. All rights reserved.
//

#import "ViewController.h"
#import "SwipeView.h"
#import "CustomOverlayView.h"

@interface ViewController ()<SwipeDelegate,SwipeViewDataSource>
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (assign, nonatomic) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 10;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)revertAction:(id)sender {
    [self.swipeView reloadData];
}
- (IBAction)likeAction:(id)sender {
    [self.swipeView swipeDirection:SwipeDirectionRight];
}
- (IBAction)ignoreAction:(id)sender {
    [self.swipeView swipeDirection:SwipeDirectionLeft];
}

- (NSUInteger)swipeViewNumberOfCards:(SwipeView *)swipeView
{
    return self.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView
          cardAtIndex:(NSUInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"Card_like_%@",@(index%6 + 1)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    return imageView;
}

- (OverlayView *)swipeView:(SwipeView *)swipeView
        cardOverlayAtIndex:(NSUInteger)index
{
    CustomOverlayView *overlay = [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil][0];
    return overlay;
}

- (void)swipeView:(SwipeView *)swipeView didSwipeCardAtIndex:(NSUInteger)index inDirection:(SwipeDirection)direction
{
//    if (index >= 3) {
//        self.count = 6;
//        [self.swipeView reloadData];
//    }
}

- (void)swipeViewDidRunOutOfCards:(SwipeView *)swipeView
{
    // TO DO load data
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.count = 10;
        [swipeView resetCurrentCardNumber];
    });
}

- (void)swipeView:(SwipeView *)swipeView didSelectCardAtIndex:(NSUInteger)index
{
    NSLog(@"点击");
}

- (BOOL)swipeViewShouldApplyAppearAnimation:(SwipeView *)swipeView
{
    return YES;
}

- (BOOL)swipeViewShouldMoveBackgroundCard:(SwipeView *)swipeView
{
    return YES;
}

- (BOOL)swipeViewShouldTransparentizeNextCard:(SwipeView *)swipeView
{
    return YES;
}

- (POPPropertyAnimation *)swipeViewBackgroundCardAnimation:(SwipeView *)swipeView
{
    return nil;
}

- (void)swipeView:(SwipeView *)swipeView cardSwipingPercent:(CGFloat)percent
{
    NSLog(@"dragged percent:%f", percent);
}


@end
