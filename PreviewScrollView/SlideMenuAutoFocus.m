//
//  SlideMenuAutoFocus.m
//  PreviewScrollView
//
//  Created by Chau Chu on 3/6/15.
//  Copyright (c) 2015 zuehlke. All rights reserved.
//

#import "SlideMenuAutoFocus.h"

@implementation SlideMenuAutoFocus
@synthesize scrollView, delegate;

-(id) initWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor  listView:(NSMutableArray*)views{
    if (self = [super initWithFrame:frame]) {
        if (views.count==0) {
            return self;
        }
        listViews = views;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.scrollView.backgroundColor = bgColor;
        self.scrollView.showsHorizontalScrollIndicator = FALSE;
        self.scrollView.showsVerticalScrollIndicator = FALSE;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.bounces = FALSE;
        self.scrollView.delegate = self;
        float totalWidth = 0.0f;
        for(int i = 0; i < [views count]; i++)
        {
            UIView *item = [views objectAtIndex:i];
            item.tag = i;
            CGRect itemRect = item.frame;
            itemRect.origin.y+=5;
            itemRect.size.height -=10;
            if(i != 0){
                item.alpha = 0.5f;
                itemRect.size.height-=10;
                itemRect.origin.y +=5;
            }
            itemRect.origin.x = totalWidth;
            item.frame = itemRect;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            [item addGestureRecognizer:tapGestureRecognizer];
            [self.scrollView addSubview:item];
            totalWidth += item.frame.size.width+10;
        }
        UIView *lastView = [views objectAtIndex:views.count-1];
        widthItem = lastView.frame.size.width;
        totalWidth =lastView.frame.origin.x + lastView.frame.size.width + 10;
        [self.scrollView setContentSize:CGSizeMake(totalWidth+frame.size.width-widthItem, self.frame.size.height)];
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)handleTapGesture:(UIGestureRecognizer*)sender{
    [self.scrollView setContentOffset:CGPointMake(sender.view.tag*widthItem+(10*sender.view.tag), 0) animated:YES];
    [self animatePageForCurrentPage:sender.view.tag];
}

- (void)animatePageForCurrentPage:(int)page
{
    for(UIView *view in listViews){
        if(view.tag == page){
            [self fadeInView:view];
        } else {
            [self fadeOutView:view];
        }
    }
    [self didFocusSelectedItem:page];
}

-(void)didFocusSelectedItem:(int)index{
    if([self.delegate respondsToSelector:@selector(SlideMenuAutoFocus:indexSelected:)]){
        [self.delegate SlideMenuAutoFocus:self indexSelected:index];
    }
}

- (void)fadeInView:(UIView*)view
{
    CGRect frames = view.frame;
    frames.size.height = self.scrollView.frame.size.height-10;
    frames.origin.y =5;
    [UIView animateWithDuration:0.2f animations:^{
        view.alpha = 1.0f;
        view.frame = frames;
    }];
}

- (void)fadeOutView:(UIView*)view
{
    CGRect frames = view.frame;
    frames.size.height = self.scrollView.frame.size.height-20;
    frames.origin.y =10;
    [UIView animateWithDuration:0.2f animations:^{
        view.alpha = 0.5f;
        view.frame = frames;
    }];
}

#pragma mark ScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview
{
    // calculate current page
    int page = scrollview.contentOffset.x / widthItem;
    [self.scrollView setContentOffset:CGPointMake(page*widthItem+(10*page), 0) animated:YES];
    [self animatePageForCurrentPage:page];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollview willDecelerate:(BOOL)decelerate{
    int page = scrollview.contentOffset.x / widthItem;
    [self.scrollView setContentOffset:CGPointMake(page*widthItem+(10*page), 0) animated:YES];
    [self animatePageForCurrentPage:page];
}

@end
