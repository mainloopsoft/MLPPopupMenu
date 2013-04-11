//
//  MLPopupMenu.m
//  MLPopupMenu
//
//  Created by Javier Figueroa on 4/10/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPPopupMenu.h"
#define kPadding 15

@implementation MLPPopupMenu

- (BOOL)isPopped
{
    return self.superview != nil;
}

- (id)initWithDataSource:(id<UITableViewDataSource>)dataSource
      andDelegate:(id<UITableViewDelegate>)delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.scrollEnabled = NO;
        self.dataSource = dataSource;
        self.delegate = delegate;
    }
    return self;
}

- (void)popInWithEvent:(UIEvent*)event
{
    UIView *view = [[event.allTouches anyObject] view];
    if ([view.superview isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar *navBar = (UINavigationBar*)view.superview;
        [navBar.superview insertSubview:self belowSubview:navBar];
    }
    
    [self popInView:view];
}

- (void)popInTabBar:(UITabBar*)tabBar forItemAtIndex:(NSInteger)index
{
    UIView *view = [[tabBar subviews] objectAtIndex:index + 1];
    if([view.superview isKindOfClass:[UITabBar class]]){
        UITabBar *navBar = (UITabBar*)view.superview;
        [navBar.superview insertSubview:self belowSubview:navBar];
    }
    
    [self popInView:view];
}

- (void)popInView:(UIView*)view
{
    [self popInView:view andPadding:kPadding];
}

- (void)popInView:(UIView*)view andPadding:(NSInteger)padding
{
    NSAssert(self.dataSource != nil, @"MLPopupMenu data source is required for the control to work");
    
    //Get row height
    CGFloat cellSize = [self rowHeight];
    //Get number of rows
    NSInteger numberOfRows = [self numberOfRowsInSection:0];
    
    //Set frame for menu view
    CGRect frame = view.frame;
    NSInteger menuHeight = cellSize * numberOfRows;
    NSInteger menuWidth = frame.size.width - padding;
    NSInteger menuX = frame.origin.x + padding / 2;
    NSInteger menuY = [view.superview isKindOfClass:[UITabBar class]] ?
                            view.superview.frame.origin.y : frame.origin.y;
    
    if (self.direction == MLPopupMenuUp) {
        self.frame = CGRectMake(menuX,
                               menuY,
                               menuWidth,
                               menuHeight);
    }else{
        self.frame = CGRectMake(menuX,
                                frame.origin.y + frame.size.height - menuHeight,
                                menuWidth,
                                menuHeight);
    }
    if (![self isPopped]){
        //Insert menu below superview
        if ([view.superview isKindOfClass:[UINavigationBar class]]) {
            UINavigationBar *navBar = (UINavigationBar*)view.superview;
            [navBar.superview insertSubview:self belowSubview:navBar];
        }else if([view.superview isKindOfClass:[UITabBar class]]){
            UITabBar *navBar = (UITabBar*)view.superview;
            [navBar.superview insertSubview:self belowSubview:navBar];
        }else{
            [view.superview insertSubview:self belowSubview:view];
        }
    }
    
    //Animate popup
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, (self.direction == MLPopupMenuUp ? -cellSize : cellSize) * numberOfRows));
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             
                         }
                     }];
}


- (void)hide
{
    //Get row height
    CGFloat cellSize = [self rowHeight];
    //Get number of rows
    NSInteger numberOfRows = [self numberOfRowsInSection:0];
    //Animate popup
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, (self.direction == MLPopupMenuUp ?cellSize : -cellSize) * numberOfRows));
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [self removeFromSuperview];
                         }
                     }];
}

@end
