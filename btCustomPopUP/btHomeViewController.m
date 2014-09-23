//
//  btHomeViewController.m
//  btCustomPopUP
//
//  Created by Balram Tiwari on 02/06/14.
//  Copyright (c) 2014 Balram Tiwari. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#import "btHomeViewController.h"
#import "btSimplePopUP.h"

@interface btHomeViewController ()
@property(nonatomic, retain) btSimplePopUP *popUp;
@end

@implementation btHomeViewController
@synthesize popUp;

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
    // Do any additional setup after loading the view.
//    if([self respondsToSelector:@selector(edgesForExtendedLayout)]){
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    imageView.frame = self.view.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UIScrollView* scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollview.alwaysBounceVertical=YES;
    [self.view addSubview:scrollview];
    
    UIImageView *author = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"author.png"]];
    author.frame = CGRectMake(120, 30, 95, 95);
    author.alpha = 0.4;
    [scrollview addSubview:author];
    author.layer.borderColor = [UIColor whiteColor].CGColor;
    author.layer.borderWidth = 3;
    author.clipsToBounds = YES;
    author.layer.cornerRadius =  author.frame.size.width/2;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 70, 200, 40);
    button.center = self.view.center;
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"DIN Condensed" size:65]];
    [button setTitle:@"PopUp" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(showPopUP:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:button];
    
    popUp = [[btSimplePopUP alloc]initWithItemImage:@[
                                                      [UIImage imageNamed:@"alert.png"],
                                                      [UIImage imageNamed:@"attach.png"],
                                                      [UIImage imageNamed:@"cloudUp.png"],
                                                      [UIImage imageNamed:@"facebook.png"],
                                                      [UIImage imageNamed:@"camera.png"],
                                                      [UIImage imageNamed:@"dropBox.png"],
                                                      [UIImage imageNamed:@"mic.png"],
                                                      [UIImage imageNamed:@"wi-Fi.png"],
                                                      [UIImage imageNamed:@"curved.png"],
                                                      [UIImage imageNamed:@"stacks.png"],
                                                      [UIImage imageNamed:@"share.png"],
                                                      [UIImage imageNamed:@"twitter.png"],
                                                      [UIImage imageNamed:@"search.png"],
                                                      [UIImage imageNamed:@"whatsApp.png"],
                                                      [UIImage imageNamed:@"settings.png"],
                                                      ]
                                          andTitles:    @[
                                                          @"Alert", @"Attach",@"Upload", @"Facebook", @"Camera", @"Dropbox",
                                                          @"Recording", @"Wi-Fi", @"Icon", @"Stacks", @"Share", @"Twitter", @"Search", @"WhatsApp", @"Settings"
                                                          ]

                                     andActionArray:@[
                                                      ^{
        
        __block UIViewController *temp = [[UIViewController alloc]init];
        temp.view.backgroundColor = [UIColor blueColor];
        [self.navigationController presentViewController:temp
                                                animated:YES
                                              completion:^{
                                                  
                                                  [temp dismissViewControllerAnimated:YES completion:nil];
                                              }];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    },
                                                       ^{
        [self showAlert];
    }]
                                addToViewController:self];
    
    [self.view addSubview:popUp];
    [popUp setPopUpStyle:BTPopUpStyleDefault];
    [popUp setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
//    [popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.6 alpha:0.7]];

}

-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"PopItem" message:@" iAM from Block" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)showPopUP:(id)sender {
    [popUp show:BTPopUPAnimateNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
