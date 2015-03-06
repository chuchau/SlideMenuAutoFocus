//
//  ViewController.m
//  PreviewScrollView
//
//  Created by Andreas Ettisberger on 21.04.13.
//  Copyright (c) 2013 zuehlke. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* items = [[NSMutableArray alloc] init];
    float currentOffset =0.0f;
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake(currentOffset, 0.0f, 120, 90);
        UIView* content = [[UIView alloc] init];
        
        content.frame = frame;
        [content setBackgroundColor:[UIColor whiteColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:content.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        content.tag = i;
        NSString* image_name = @"";
        if (i==0) {
            image_name = @"mobifone.png";
        }
        else if (i==1){
            image_name = @"viettel.png";
        }
        else if (i==2){
            image_name = @"vinaphone.png";
        }
        else if (i==3){
            image_name = @"gate.png";
        }
        else if (i==4){
            image_name = @"gmobi.png";
        }
        imageView.image = [UIImage imageNamed:image_name];
        [content addSubview:imageView];
        
        [items addObject:content];
        
    }
    
    SlideMenuAutoFocus* autoFocus = [[SlideMenuAutoFocus alloc] initWithFrame:CGRectMake(0, 290, 320, 90) backgroundColor:[UIColor grayColor] listView:items];
    autoFocus.delegate = self;
    [self.view addSubview:autoFocus];
}

-(void)SlideMenuAutoFocus:(UIView *)slideMenuAutoFocus indexSelected:(int)index{
    NSLog(@"selected: %d", index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
