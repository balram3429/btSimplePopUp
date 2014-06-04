//
//  btSimplePopUP.m
//  btCustomPopUP
//
//  Created by Balram Tiwari on 02/06/14.
//  Copyright (c) 2014 Balram Tiwari. All rights reserved.
//

#define SCREEN_SIZE [UIScreen mainScreen].bounds
#define POPUP_WIDTH 300.0
#define POP_HEIGHT 300.0

typedef void (^completion)(BOOL success);

#import "btSimplePopUP.h"

#pragma mark - BTPopUpItemView
#pragma mark - @interface
@interface BTPopUpItemView : UIView

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, copy) dispatch_block_t action;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title action:(dispatch_block_t)action;
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
- (instancetype)initWithImage:(UIImage *)image;

@end

#pragma mark - BTPopUpItemView
#pragma mark - @implementation
@implementation BTPopUpItemView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title action:(dispatch_block_t)action {
    if ((self = [super init])) {
        _title = [title copy];
        _imageView = [[UIImageView alloc]initWithImage:image];
        _action = [action copy];
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    return [self initWithImage:image title:title action:nil];
}

- (instancetype)initWithImage:(UIImage *)image {
    return [self initWithImage:image title:nil action:nil];
}


- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[BTPopUpItemView class]]) {
        return NO;
    }
    
    return ((self.title == [object title] || [self.title isEqualToString:[object title]]) &&
            (self.image == [object image]));
}

- (NSUInteger)hash {
    return self.title.hash;
}

- (BOOL)isEmpty {
    //    return [self isEqual:[[self class] emptyItem]];
    return YES;
}

@end

#pragma mark - btRippleButtton
#pragma mark - @interface

@interface btRippleButtton : UIView{
@private
    UIImageView *imageView;
    UILabel *title;
    UITapGestureRecognizer *gesture;
    SEL methodName;
    id superSender;
    UIColor *rippleColor;
    NSArray *rippleColors;
    BOOL isRippleOn;
}

@property (nonatomic, copy) completion block;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame andTarget:(SEL)action andID:(id)sender;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completion)completionBlock;

-(instancetype)initWithImage:(UIImage *)image andTitle:(NSString *)aTitle andFrame:(CGRect)frame onCompletion:(completion)completionBlock;

-(void)setRippleEffectWithColor:(UIColor *)color;
-(void)setRippeEffect:(BOOL)effect;

@end

#pragma mark - btRippleButtton
#pragma mark - @implementation
@implementation btRippleButtton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)commonInitWithImage:(UIImage *)image andTitle:(NSString *)aTitle andFrame:(CGRect) frame{
    
    imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    imageView.layer.borderColor = [UIColor clearColor].CGColor;
    imageView.layer.borderWidth = 3;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.layer.cornerRadius = self.frame.size.height/2;
    gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(-10, frame.size.height+1, frame.size.width+20, 20)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Avenir Next" size:12];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.numberOfLines = 0;
    title.text = aTitle;
    [self addSubview:title];
}

-(instancetype)initWithImage:(UIImage *)image
                    andFrame:(CGRect)frame
                   andTarget:(SEL)action
                       andID:(id)sender {
    self = [super initWithFrame:frame];
    
    if(self){
        [self commonInitWithImage:image andTitle:nil andFrame:frame];
        methodName = action;
        superSender = sender;
    }
    
    return self;
}

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completion)completionBlock {
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInitWithImage:image andTitle:nil andFrame:frame];
        self.block = completionBlock;
    }
    
    return self;
}

-(instancetype)initWithImage:(UIImage *)image andTitle:(NSString *)aTitle andFrame:(CGRect)frame onCompletion:(completion)completionBlock {
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInitWithImage:image andTitle:aTitle andFrame:frame];
        self.block = completionBlock;
    }
    
    return self;
}


-(void)setRippleEffectWithColor:(UIColor *)color {
    rippleColor = color;
}

-(void)setRippeEffect:(BOOL)effect {
    isRippleOn = effect;
}

-(void)handleTap:(id)sender {
    
    if (isRippleOn) {
        UIColor *stroke = rippleColor ? rippleColor : [UIColor colorWithWhite:0.8 alpha:0.8];
        
        CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
        
        // accounts for left/right offset and contentOffset of scroll view
        CGPoint shapePosition = [self convertPoint:self.center fromView:self.superview];
        
        CAShapeLayer *circleShape = [CAShapeLayer layer];
        circleShape.path = path.CGPath;
        circleShape.position = shapePosition;
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.opacity = 0;
        circleShape.strokeColor = stroke.CGColor;
        circleShape.lineWidth = 3;
        
        [self.layer addSublayer:circleShape];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 0.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [circleShape addAnimation:animation forKey:nil];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 0.4;
        self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.9].CGColor;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            imageView.alpha = 1;
            self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.9].CGColor;
        }completion:^(BOOL finished) {
            if([superSender respondsToSelector:methodName]){
                [superSender performSelectorOnMainThread:methodName withObject:nil waitUntilDone:NO];
            }
            
            if(_block) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BT_POP_UP_ITEM_PRESSED" object:nil];
                BOOL success= YES;
                _block(success);
            }
        }];
        
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end

#pragma mark - btSimplePopUP
#pragma mark - @implementation
@implementation btSimplePopUP

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(instancetype)initWithItemImage:(NSArray *)items andActionArray:(NSArray *)actionArray addToViewController:(UIViewController *)sender  {
    return [self initWithItemImage:items andTitles:nil andActionArray:actionArray addToViewController:sender];
}

-(instancetype)initWithItemImage:(NSArray *)items andTitles:(NSArray *)titleArray andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender {
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"BT_POP_UP_ITEM_PRESSED" object:nil];
        // initialize with the blur effect as background
        CGRect screenSize = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
        UIImage *screenShot = [sender.view screenshot];
        UIImage *blurImage  = [screenShot blurredImageWithRadius:10.5 iterations:2 tintColor:nil];
        backGroundBlurr = [[UIImageView alloc]initWithImage:blurImage];
        backGroundBlurr.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
        backGroundBlurr.alpha = 0;
        [self addSubview:backGroundBlurr];
        
        UITapGestureRecognizer *tapOnBackground = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tapOnBackground.numberOfTapsRequired = 1;
        [backGroundBlurr addGestureRecognizer:tapOnBackground];
        [backGroundBlurr setUserInteractionEnabled:YES];
        
        // initialize the main content of the menu
        contentView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-150, screenSize.size.height, POPUP_WIDTH, POP_HEIGHT)];
        contentView.layer.cornerRadius = 40;
        contentView.clipsToBounds = YES;
        contentView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        [self addSubview:contentView];
        self.alpha = 0;
        
        // set default properties
        self.popUpStyle = BTPopUpStyleDefault;
        self.popUpBorderStyle = BTPopUpBorderStyleDefaultNone;
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height)];
        scrollView.alwaysBounceHorizontal=YES;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        [contentView addSubview:scrollView];
        
        pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0, 5, contentView.frame.size.width, 25);
        pageControl.backgroundColor = [UIColor clearColor];
        [contentView addSubview:pageControl];
        
        // initialize Items
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:items.count];
        if(([items count] == [titleArray count]) && ([items count]== [actionArray count])){
            // create items with Image, Title & Actions
            int index = 0;
            for (UIImage *image in items) {
                BTPopUpItemView *item = [[BTPopUpItemView alloc] initWithImage:image title:[titleArray objectAtIndex:index] action:[actionArray objectAtIndex:index]];
                [itemArray addObject:item];
                index++;
            }
        }else if([items count] == [actionArray count]){
            int index = 0;
            for (UIImage *image in items) {
                BTPopUpItemView *item = [[BTPopUpItemView alloc] initWithImage:image title:nil action:[actionArray objectAtIndex:index]];
                [itemArray addObject:item];
                index++;
            }
            
        }
        popItems = itemArray;
        [self setUpPopItems];
    }
    return self;

}

-(void)setUpPopItems {
    
    itemSize = CGSizeMake(50.0f, 50.0f);
    itemTextColor = [UIColor whiteColor];
    itemFont = [UIFont boldSystemFontOfSize:14.f];
    highlightColor = [UIColor colorWithRed:.02f green:.549f blue:.961f alpha:1.f];
    backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
   
    CGFloat xAxis = 37.0;
    CGFloat yAxis = 40.0;
    CGFloat xFactor = 37.0;
    CGFloat pages =  (([popItems count] % 9) == 0) ? [popItems count]/9 : ([popItems count]/9) +1;
    
    pageControl.numberOfPages = pages;
    pageControl.currentPage = 0;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pages, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat pageFactor = 0;
    int lastCount = 0;
    int count = 0;
    int counter = 0;
    for(int i =0; i< pages; i++){
        if(i > 0){
            pageFactor = 300*i;
            count = 0;
            yAxis = 40.0;
            xAxis = pageFactor +xFactor;
        }
        counter = lastCount;
        for(; counter< [popItems count]; counter++) {
            BTPopUpItemView *item = [popItems objectAtIndex:counter];
            if(count < 9){
                if(count < 3){
                    [self addButton:item xAxis:xAxis yAxis:yAxis];
                    xAxis += itemSize.width + xFactor;
                    
                    if(count == 2){
                        xAxis = pageFactor + xFactor;
                        yAxis += itemSize.height+ xFactor;
                    }
                }
                
                if(count > 2 && count < 6){
                    [self addButton:item xAxis:xAxis yAxis:yAxis];
                    xAxis += itemSize.width+ xFactor;
                    
                    if(count == 5){
                        xAxis = pageFactor + xFactor;
                        yAxis += itemSize.height+ xFactor;
                    }
                }
                
                if(count > 5 && count < 9){
                    [self addButton:item xAxis:xAxis yAxis:yAxis];
                    xAxis += itemSize.width+ xFactor;
                    
                    if(count == 8){
                       xAxis = pageFactor + xFactor;
                        yAxis += itemSize.height+ xFactor;
                    }
                }
                count++;
            }else {
                lastCount = counter;
                break;
            }
            lastCount = counter;
        }
    }
    
}


-(void)addButton:(BTPopUpItemView*) item xAxis:(CGFloat)x yAxis:(CGFloat)y {
    btRippleButtton *button = [[btRippleButtton alloc]initWithImage:item.imageView.image andTitle:item.title andFrame:CGRectMake(x, y, itemSize.width, itemSize.height) onCompletion:[item.action copy]];
    [button setRippeEffect:YES];
    [scrollView addSubview:button];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGFloat pageWidth = scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page; // you need to have a **iVar** with getter for pageControl
}

-(void)setPopUpStyle:(BTPopUpStyle)popUpStyle {
    if(_popUpStyle == popUpStyle){
        return;
    }
    
    if(popUpStyle == BTPopUpStyleMinimalRoundedCorner){
        contentView.layer.cornerRadius = 10;
    }
    
    if(popUpStyle == BTPopUpStyleDefault){
        contentView.layer.cornerRadius = 40;
    }
}

-(void)setPopUpBackgroundColor:(UIColor *)popUpBackgroundColor {
    contentView.backgroundColor = popUpBackgroundColor;
}

-(void)setPopUpBorderStyle:(BTPopUpBorderStyle)popUpBorderStyle {
    if(_popUpBorderStyle == popUpBorderStyle)
        return;
    
    
    if(popUpBorderStyle == BTPopUpBorderStyleDefaultNone){
        contentView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    }
    
    if(popUpBorderStyle == BTPopUpBorderStyleLightContent){
        contentView.layer.borderWidth = 5;
        contentView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    }
    
    if(popUpBorderStyle == BTPopUpBorderStyleDarkContent){
        contentView.layer.borderWidth = 5;
        contentView.layer.borderColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    }
}

-(void)show {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
        backGroundBlurr.alpha = 1;
        contentView.center = CGPointMake(self.center.x, self.center.y-15);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.002 animations:^{
            contentView.center = self.center;
        }];
    }];
}

-(void)dismiss {
    [UIView animateWithDuration:0.1 animations:^{
        contentView.frame = CGRectMake(self.frame.size.width/2-150, SCREEN_SIZE.size.height, POPUP_WIDTH, POP_HEIGHT);
        backGroundBlurr.alpha = 0;
    }completion:^(BOOL finished) {
        self.alpha = 0;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

@implementation UIView (bt_screenshot)
-(UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), NO, [UIScreen mainScreen].scale);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        
        NSInvocation* invoc = [NSInvocation invocationWithMethodSignature:
                               [self methodSignatureForSelector:
                                @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invoc setTarget:self];
        [invoc setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invoc setArgument:&arg2 atIndex:2];
        [invoc setArgument:&arg3 atIndex:3];
        [invoc invoke];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIImage (bt_blurrEffect)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor
{
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = self.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    //free buffers
    free(buffer2.data);
    free(tempBuffer);
    
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    //    UIImage *image = [[UIImage alloc]init];
    return image;
}

@end

