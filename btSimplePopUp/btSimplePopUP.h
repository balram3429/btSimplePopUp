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

typedef NS_ENUM(NSInteger, BTPopUPStyle) {
   BTPopUPStyleDefault,
   BTPopUPStyleMinimalRoundedCorner
};

typedef NS_ENUM(NSInteger, BTPopUPAnimation) {
   BTPopUPAnimateWithFade,
   BTPopUPAnimateNone
};

typedef NS_ENUM(NSInteger, BTPopUPBorderStyle) {
   BTPopUPBorderStyleDefaultNone,
   BTPopUPBorderStyleLightContent,
   BTPopUPBorderStyleDarkContent
};


@class BTSimplePopUP;

@protocol BTSimplePopUPDelegate <NSObject>

@optional
-(void)btSimplePopUP:(BTSimplePopUP *)popUp didSelectItemAtIndex:(NSInteger)index;

@end

@interface BTSimplePopUP : UIView <UIScrollViewDelegate>{
   UIImageView *backGroundBlurr;
   UIView *contentView;
   CGSize itemSize;
   UIColor *itemColor, *itemTextColor, *highlightColor, *backgroundColor;
   UIFont *itemFont;
   NSArray *popItems;
   UIScrollView *scrollView;
   UIPageControl * pageControl;
}
@property (nonatomic, assign) BTPopUPStyle popUpStyle;
@property (nonatomic, assign) BTPopUPBorderStyle popUpBorderStyle;
@property (nonatomic, assign) UIColor *popUpBackgroundColor;
@property (nonatomic, assign) BTPopUPAnimation animationStyle;
@property(nonatomic, weak) id <BTSimplePopUPDelegate> delegate;
@property (nonatomic) BOOL setShowRipples;

-(instancetype)initWithItemImage:(NSArray *)items andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;
-(instancetype)initWithItemImage:(NSArray *)items andTitles:(NSArray *)titleArray andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;

-(instancetype)initWithItemImage:(NSArray *)items andTitles:(NSArray *)titleArray addToViewController:(UIViewController*)sender;

-(void)setPopUPBackgroundColor:(UIColor *)popUpBackgroundColor;
-(void)show:(BTPopUPAnimation)animation;

@end


@interface UIView (bt_screenshot)
- (UIImage *)screenshot;

@end

@interface UIImage (bt_blurrEffect)
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end