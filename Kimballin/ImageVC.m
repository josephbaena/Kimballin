//
//  ImageVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end

@implementation ImageVC

#pragma mark Properties

- (void)setPhoto:(Photo *)photo
{
    [self.spinner startAnimating];
    _photo = photo;
    UIImage *img = [UIImage imageNamed:photo.imageName];
    [self setImage:img];
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    // self.scrollView could be nil here if outlet-setting has not happened yet
    self.scrollView.zoomScale = 1.0;
    self.scrollView.contentSize = image ? image.size : CGSizeZero;
    
    self.imageView.image = image; // does not change the frame of the UIImageView
    [self.imageView sizeToFit];   // update the frame of the UIImageView
    
    //maximize screen space
    CGFloat svHeight = self.scrollView.bounds.size.height;
    CGFloat svWidth = self.scrollView.bounds.size.width;
    
    CGFloat ivHeight = self.imageView.bounds.size.height;
    CGFloat ivWidth = self.imageView.bounds.size.width;
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat statusBarWidth = [UIApplication sharedApplication].statusBarFrame.size.width;
    CGFloat statusBarDimension = MIN(statusBarWidth, statusBarHeight);
    double actualHeight = ivHeight - statusBarDimension - navBarHeight - tabBarHeight;
    
    double scaleWidth = svWidth/ivWidth;
    double scaleHeight = svHeight/actualHeight;
    
    if (scaleHeight > scaleWidth) {
        self.scrollView.zoomScale = scaleHeight;
    } else {
        self.scrollView.zoomScale = scaleWidth;
    }
    
    [self.spinner stopAnimating];
}

#pragma mark Outlets

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

#pragma mark View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
