//
//  MLViewController.m
//  MLPopupMenu
//
//  Created by Javier Figueroa on 4/10/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPViewController.h"
#import "MLPPopupMenu.h"
#import "MLPPopupMenuDataSource.h"
#import <QuartzCore/QuartzCore.h>

@interface MLPViewController ()

@property (nonatomic, strong) MLPPopupMenuDataSource *dataSource;
@property (nonatomic, strong) MLPPopupMenu *menuUp;
@property (nonatomic, strong) MLPPopupMenu *menuDown;

@end

@implementation MLPViewController

- (MLPPopupMenuDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[MLPPopupMenuDataSource alloc] init];
    }
    
    return _dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addShadow:self.popItDownButton];
    [self addShadow:self.popItUpButton];    
    
    self.menuUp = [[MLPPopupMenu alloc] initWithDataSource:self.dataSource andDelegate:self];
    self.menuUp.direction = MLPopupMenuUp; 
    
    self.menuDown = [[MLPPopupMenu alloc] initWithDataSource:self.dataSource andDelegate:self];
    self.menuDown.direction = MLPopupMenuDown;
}

- (void)addShadow:(UIButton*)button
{
    [button.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [button.layer setShadowOffset:CGSizeMake(0, 3)];
    [button.layer setShadowOpacity:0.125];
    [button.layer setCornerRadius:3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MLPopupMenu Actions


-(IBAction)didSelectPopitUp:(id)sender event:(UIEvent*)event
{
    if ([self.menuUp isPopped]) {
        [self.menuUp hide];
    }else{
        [self.menuUp popInView:sender];
    }
}

-(IBAction)didSelectPopitDown:(id)sender event:(UIEvent *)event
{
    if ([self.menuDown isPopped]) {
        [self.menuDown hide];
    }else{
        [self.menuDown popInView:sender];
    }
}

-(IBAction)didSelectPopitDownFromNavBar:(id)sender event:(UIEvent *)event
{
    if ([self.menuDown isPopped]) {
        [self.menuDown hide];
    }else{
        [self.menuDown popInWithEvent:event];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([self.menuUp isPopped]) {
        [self.menuUp hide];
    }else{
        [self.menuUp popInTabBar:tabBar forItemAtIndex:item.tag];
    }
}

@end
