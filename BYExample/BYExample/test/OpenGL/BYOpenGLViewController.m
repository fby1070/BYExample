//
//  BYOpenGLViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2019/2/22.
//  Copyright © 2019 付宝阳. All rights reserved.
//

#import "BYOpenGLViewController.h"
#import <GLKit/GLKit.h>

@interface BYOpenGLViewController ()

@end

@implementation BYOpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupConfig {
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView *)self.view;
    view.context = context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:context];
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.1, 0.2, 0.3, 1);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
@end
