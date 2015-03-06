//
//  SlideMenuAutoFocus.h
//  PreviewScrollView
//
//  Created by Chau Chu on 3/6/15.
//  Copyright (c) 2015 zuehlke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideMenuAutoFocusDelegate;

@interface SlideMenuAutoFocus : UIView<UIScrollViewDelegate>{
    float widthItem;
    NSArray* listViews;
}
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) id<SlideMenuAutoFocusDelegate> delegate;
-(id) initWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor  listView:(NSMutableArray*)views;
@end

@protocol SlideMenuAutoFocusDelegate <NSObject>
@optional
-(void)SlideMenuAutoFocus:(UIView*)slideMenuAutoFocus indexSelected:(int)index;

@end
