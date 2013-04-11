//
//  MLViewController.h
//  MLPopupMenu
//
//  Created by Javier Figueroa on 4/10/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPViewController : UIViewController<UITableViewDelegate, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *popItDownButton;

@property (weak, nonatomic) IBOutlet UIButton *popItUpButton;

-(IBAction)didSelectPopitUp:(id)sender event:(UIEvent*)event;

-(IBAction)didSelectPopitDown:(id)sender event:(UIEvent*)event;

-(IBAction)didSelectPopitDownFromNavBar:(id)sender event:(UIEvent *)event;

@end
