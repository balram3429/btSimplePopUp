//
//  btSimplePopUP.h
//  btCustomPopUP
//
//  Created by Balram Tiwari on 02/06/14.
//  Copyright (c) 2014 Balram Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

typedef NS_ENUM(NSInteger, BTPopUpStyle) {
    BTPopUpStyleDefault,
    BTPopUpStyleMinimalRoundedCorner
};

typedef NS_ENUM(NSInteger, BTPopUpBorderStyle) {
    BTPopUpBorderStyleDefaultNone,
    BTPopUpBorderStyleLightContent,
    BTPopUpBorderStyleDarkContent
};

@interface btSimplePopUP : UIView <UIScrollViewDelegate>{
    UIImageView *backGroundBlurr;
    UIView *contentView;
    CGSize itemSize;
    UIColor *itemColor, *itemTextColor, *highlightColor, *backgroundColor;
    UIFont *itemFont;
    NSArray *popItems;
    UIScrollView *scrollView;
    UIPageControl * pageControl;
}
@property (nonatomic, assign) BTPopUpStyle popUpStyle;
@property (nonatomic, assign) BTPopUpBorderStyle popUpBorderStyle;
@property (nonatomic, assign) UIColor *popUpBackgroundColor;

@property (nonatomic) BOOL setShowRipples;

-(instancetype)initWithItemImage:(NSArray *)items andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;
-(instancetype)initWithItemImage:(NSArray *)items andTitles:(NSArray *)titleArray andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;

-(void)setPopUpBackgroundColor:(UIColor *)popUpBackgroundColor;
-(void)show;
-(void)dismiss;
@end


@interface UIView (bt_screenshot)
- (UIImage *)screenshot;

@end

@interface UIImage (bt_blurrEffect)
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end