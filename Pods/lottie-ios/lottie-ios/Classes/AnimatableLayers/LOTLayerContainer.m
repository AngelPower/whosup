//
//  LOTLayerContainer.m
//  Lottie
//
//  Created by brandon_withrow on 7/18/17.
//  Copyright © 2017 Airbnb. All rights reserved.
//

#import "LOTLayerContainer.h"
#import "LOTTransformInterpolator.h"
#import "LOTNumberInterpolator.h"
#import "CGGeometry+LOTAdditions.h"
#import "LOTRenderGroup.h"
#import "LOTHelpers.h"
#import "LOTMaskContainer.h"
#import "LOTAsset.h"

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import "LOTCacheProvider.h"
#endif

@implementation LOTLayerContainer {
  LOTTransformInterpolator *_transformInterpolator;
  LOTNumberInterpolator *_opacityInterpolator;
  NSNumber *_inFrame;
  NSNumber *_outFrame;
  CALayer *DEBUG_Center;
  LOTRenderGroup *_contentsGroup;
  LOTMaskContainer *_maskLayer;
  NSDictionary *_valueInterpolators;
}

@dynamic currentFrame;

- (instancetype)initWithModel:(LOTLayer *)layer
                 inLayerGroup:(LOTLayerGroup *)layerGroup {
  self = [super init];
  if (self) {
    _wrapperLayer = [CALayer new];
    [self addSublayer:_wrapperLayer];
    DEBUG_Center = [CALayer layer];
    
    DEBUG_Center.bounds = CGRectMake(0, 0, 20, 20);
    DEBUG_Center.borderColor = [UIColor blueColor].CGColor;
    DEBUG_Center.borderWidth = 2;
    DEBUG_Center.masksToBounds = YES;
    
    if (ENABLE_DEBUG_SHAPES) {
      [_wrapperLayer addSublayer:DEBUG_Center];
    } 
    self.actions = @{@"hidden" : [NSNull null], @"opacity" : [NSNull null], @"transform" : [NSNull null]};
    _wrapperLayer.actions = [self.actions copy];
    [self commonInitializeWith:layer inLayerGroup:layerGroup];
  }
  return self;
}

- (void)commonInitializeWith:(LOTLayer *)layer
                inLayerGroup:(LOTLayerGroup *)layerGroup {
  if (layer == nil) {
    return;
  }
  _layerName = layer.layerName;
  if (layer.layerType == LOTLayerTypeImage ||
      layer.layerType == LOTLayerTypeSolid ||
      layer.layerType == LOTLayerTypePrecomp) {
    _wrapperLayer.bounds = CGRectMake(0, 0, layer.layerWidth.floatValue, layer.layerHeight.floatValue);
    _wrapperLayer.anchorPoint = CGPointMake(0, 0);
    _wrapperLayer.masksToBounds = YES;
    DEBUG_Center.position = LOT_RectGetCenterPoint(self.bounds);
  }
  
  if (layer.layerType == LOTLayerTypeImage) {
    [self _setImageForAsset:layer.imageAsset];
  }
  
  _inFrame = [layer.inFrame copy];
  _outFrame = [layer.outFrame copy];
  _transformInterpolator = [LOTTransformInterpolator transformForLayer:layer];
  if (layer.parentID) {
    NSNumber *parentID = layer.parentID;
    LOTTransformInterpolator *childInterpolator = _transformInterpolator;
    while (parentID != nil) {
      LOTLayer *parentModel = [layerGroup layerModelForID:parentID];
      LOTTransformInterpolator *interpolator = [LOTTransformInterpolator transformForLayer:parentModel];
      childInterpolator.inputNode = interpolator;
      childInterpolator = interpolator;
      parentID = parentModel.parentID;
    }
  }
  _opacityInterpolator = [[LOTNumberInterpolator alloc] initWithKeyframes:layer.opacity.keyframes];
  if (layer.layerType == LOTLayerTypeShape &&
      layer.shapes.count) {
    [self buildContents:layer.shapes];
  }
  if (layer.layerType == LOTLayerTypeSolid) {
    _wrapperLayer.backgroundColor = layer.solidColor.CGColor;
  }
  if (layer.masks.count) {
    _maskLayer = [[LOTMaskContainer alloc] initWithMasks:layer.masks];
    _wrapperLayer.mask = _maskLayer;
  }
  
  NSMutableDictionary *interpolators = [NSMutableDictionary dictionary];
  interpolators[@"Transform.Opacity"] = _opacityInterpolator;
  interpolators[@"Transform.Anchor Point"] = _transformInterpolator.anchorInterpolator;
  interpolators[@"Transform.Scale"] = _transformInterpolator.scaleInterpolator;
  interpolators[@"Transform.Rotation"] = _transformInterpolator.scaleInterpolator;
  if (_transformInterpolator.positionXInterpolator &&
      _transformInterpolator.positionYInterpolator) {
    interpolators[@"Transform.X Position"] = _transformInterpolator.positionXInterpolator;
    interpolators[@"Transform.Y Position"] = _transformInterpolator.positionYInterpolator;
  } else if (_transformInterpolator.positionInterpolator) {
    interpolators[@"Transform.Position"] = _transformInterpolator.positionInterpolator;
  }
  _valueInterpolators = interpolators;
}

- (void)buildContents:(NSArray *)contents {
  _contentsGroup = [[LOTRenderGroup alloc] initWithInputNode:nil contents:contents keyname:_layerName];
  [_wrapperLayer addSublayer:_contentsGroup.containerLayer];
}


#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

- (void)_setImageForAsset:(LOTAsset *)asset {
    
    
    if (asset.imageName) {
        UIImage *image;
        
        
        
        if(([asset.imageName isEqualToString:@"img_1.png"]) || ([asset.imageName isEqualToString:@"img_5.png"])){
            
            NSArray *components = [asset.imageName componentsSeparatedByString:@"."];
            image = [UIImage imageNamed:components.firstObject];
            
            
        }else {
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              [NSString stringWithString: asset.imageName]];
            
            image = [UIImage imageWithContentsOfFile:path];
            //image.size.height = image.size.height/2
            NSLog(@"%@", path);
        }
        
        
        /*  if (asset.rootDirectory.length > 0) {
         NSString *rootDirectory  = asset.rootDirectory;
         if (asset.imageDirectory.length > 0) {
         rootDirectory = [rootDirectory stringByAppendingPathComponent:asset.imageDirectory];
         }
         NSString *imagePath = [rootDirectory stringByAppendingPathComponent:asset.imageName];
         
         id<LOTImageCache> imageCache = [LOTCacheProvider imageCache];
         
         
         if (imageCache) {
         image = [imageCache imageForKey:imagePath];
         if (!image) {
         image = [UIImage imageWithContentsOfFile:imagePath];
         [imageCache setImage:image forKey:imagePath];
         }
         } else {
         image = [UIImage imageWithContentsOfFile:imagePath];
         }
         }else{
         NSArray *components = [asset.imageName componentsSeparatedByString:@"."];
         image = [UIImage imageNamed:components.firstObject inBundle:asset.assetBundle compatibleWithTraitCollection:nil];
         }
         */
        
        
        
        
        if (image) {
            
            if(([asset.imageName isEqualToString:@"img_1.png"]) || ([asset.imageName isEqualToString:@"img_5.png"])){
                
                _wrapperLayer.contents = (__bridge id _Nullable)(image.CGImage);
                
                
            }else {
                
                UIColor *borderSport = [UIColor colorWithRed:1.00 green:0.19 blue:0.38 alpha:1.0];
                UIColor *borderSoiree =[UIColor colorWithRed:0.63 green:0.04 blue:0.68 alpha:1.0];
                UIColor *borderChill = [UIColor colorWithRed:0.46 green:0.76 blue:1.00 alpha:1.0];
                UIColor *borderGame = [UIColor colorWithRed:0.31 green:0.23 blue:0.87 alpha:1.0];
                UIColor *borderOther = [UIColor colorWithRed:0.95 green:0.72 blue:0.00 alpha:1.0];
                UIColor *borderFood = [UIColor colorWithRed:0.00 green:0.93 blue:0.82 alpha:1.0];
                
                
                
                //UIImage* image = [image CGSizeMake(image.size.height/2., image.size.height/2.)];
                
                _wrapperLayer.contents = (__bridge id _Nullable)(image.CGImage);
               
                _wrapperLayer.cornerRadius = _wrapperLayer.frame.size.width / 2;
                _wrapperLayer.masksToBounds = YES;
                _wrapperLayer.borderWidth = 3.0f;
                _wrapperLayer.transform = CATransform3DMakeScale(.65, .65, 1);
                
                if( ([asset.imageName isEqualToString:@"img_0.png"]) || [asset.imageName isEqualToString:@"img_2.png"] ){
                    
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_0"];
                    //NSLog(@"je passe dans setimageforasset if: %@", val);
                    
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];} }
                
                
                if([asset.imageName isEqualToString:@"img_2.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_2"];
                    //NSLog(@"je passe dans setimageforasset if: %@", val);
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                }
                if([asset.imageName isEqualToString:@"img_3.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_3"];
                    // NSLog(@"je passe dans setimageforasset if: %@", val);
                    
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                if([asset.imageName isEqualToString:@"img_4.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_4"];
                    //NSLog(@"je passe dans setimageforasset if: %@", val);
                    
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                if([asset.imageName isEqualToString:@"img_6.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_6"];
                    //NSLog(@"je passe dans setimageforasset if: %@", val);
                    
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                if([asset.imageName isEqualToString:@"img_7.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_7"];
                    // NSLog(@"je passe dans setimageforasset if: %@", val);
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                if([asset.imageName isEqualToString:@"img_8.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_8"];
                    //NSLog(@"je passe dans setimageforasset if: %@", val);
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                if([asset.imageName isEqualToString:@"img_9.png"]){
                    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:@"img_9"];
                    // NSLog(@"je passe dans setimageforasset if: %@", val);
                    
                    if( [val isEqualToString:@"SPORT"]) {[_wrapperLayer setBorderColor:borderSport.CGColor];}
                    if( [val isEqualToString:@"SOIREE"]) {[_wrapperLayer setBorderColor:borderSoiree.CGColor];}
                    if( [val isEqualToString:@"CHILL"])  {[_wrapperLayer setBorderColor:borderChill.CGColor];}
                    if( [val isEqualToString:@"GAME"])  {[_wrapperLayer setBorderColor:borderGame.CGColor];}
                    if( [val isEqualToString:@"OTHER"]) {[_wrapperLayer setBorderColor:borderOther.CGColor];}
                    if( [val isEqualToString:@"FOOD"])  {[_wrapperLayer setBorderColor:borderFood.CGColor];}
                    
                }
                
            }
   
            
        } else {
            
            
            NSLog(@"%s: Warn: image not found: %@", __PRETTY_FUNCTION__, asset.imageName);
        }
    }
}

#else

- (void)_setImageForAsset:(LOTAsset *)asset {
  if (asset.imageName) {
    NSArray *components = [asset.imageName componentsSeparatedByString:@"."];
    NSImage *image = [NSImage imageNamed:components.firstObject];
    if (image) {
      NSWindow *window = [NSApp mainWindow];
      CGFloat desiredScaleFactor = [window backingScaleFactor];
      CGFloat actualScaleFactor = [image recommendedLayerContentsScale:desiredScaleFactor];
      id layerContents = [image layerContentsForContentsScale:actualScaleFactor];
      _wrapperLayer = layerContents;
    }
  }
  
}

#endif

// MARK - Animation

+ (BOOL)needsDisplayForKey:(NSString *)key {
  BOOL needsDisplay = [super needsDisplayForKey:key];
  
  if ([key isEqualToString:@"currentFrame"]) {
    needsDisplay = YES;
  }
  
  return needsDisplay;
}

-(id<CAAction>)actionForKey:(NSString *)event {
  if([event isEqualToString:@"currentFrame"]) {
    CABasicAnimation *theAnimation = [CABasicAnimation
                                      animationWithKeyPath:event];
    theAnimation.fromValue = [[self presentationLayer] valueForKey:event];
    return theAnimation;
  }
  return [super actionForKey:event];
}

- (void)display {
  LOTLayerContainer *presentation = (LOTLayerContainer *)self.presentationLayer;
  if (presentation == nil) {
    presentation = self;
  }
  [self displayWithFrame:presentation.currentFrame];
}

- (void)displayWithFrame:(NSNumber *)frame {
  [self displayWithFrame:frame forceUpdate:NO];
}

- (void)displayWithFrame:(NSNumber *)frame forceUpdate:(BOOL)forceUpdate {
  if (ENABLE_DEBUG_LOGGING) NSLog(@"View %@ Displaying Frame %@", self, frame);
  BOOL hidden = NO;
  if (_inFrame && _outFrame) {
    hidden = (frame.floatValue < _inFrame.floatValue ||
              frame.floatValue > _outFrame.floatValue);
  }
  self.hidden = hidden;
  if (hidden) {
    return;
  }
  if (_opacityInterpolator && [_opacityInterpolator hasUpdateForFrame:frame]) {
    self.opacity = [_opacityInterpolator floatValueForFrame:frame];
  }
  if (_transformInterpolator && [_transformInterpolator hasUpdateForFrame:frame]) {
    _wrapperLayer.transform = [_transformInterpolator transformForFrame:frame];
  }
  [_contentsGroup updateWithFrame:frame withModifierBlock:nil forceLocalUpdate:forceUpdate];
  _maskLayer.currentFrame = frame;
}

- (void)addAndMaskSublayer:(nonnull CALayer *)subLayer {
  [_wrapperLayer addSublayer:subLayer];
}

- (BOOL)setValue:(nonnull id)value
      forKeypath:(nonnull NSString *)keypath
         atFrame:(nullable NSNumber *)frame {
  NSArray *components = [keypath componentsSeparatedByString:@"."];
  NSString *firstKey = components.firstObject;
  if ([firstKey isEqualToString:self.layerName]) {
    NSString *nextPath = [keypath stringByReplacingCharactersInRange:NSMakeRange(0, firstKey.length + 1) withString:@""];
    LOTValueInterpolator *interpolator = _valueInterpolators[nextPath];
    if (interpolator) {
      return [interpolator setValue:value atFrame:frame];
    } else {
      return [_contentsGroup setValue:value forKeyAtPath:keypath forFrame:frame];
    }
  }
  return NO;
}

- (void)setViewportBounds:(CGRect)viewportBounds {
  _viewportBounds = viewportBounds;
  if (_maskLayer) {
    CGPoint center = LOT_RectGetCenterPoint(viewportBounds);
    viewportBounds.origin = CGPointMake(-center.x, -center.y);
    _maskLayer.bounds = viewportBounds;
  }
}

- (void)logHierarchyKeypathsWithParent:(NSString * _Nullable)parent {
  [_contentsGroup logHierarchyKeypathsWithParent:parent
   ];
}

@end
