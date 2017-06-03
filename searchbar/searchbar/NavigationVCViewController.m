//
//  NavigationVCViewController.m
//  searchbar
//
//  Created by Mory on 2017/6/3.
//  Copyright © 2017年 Mory. All rights reserved.
///已在 storyboard 里面 关联此类
#import "NavigationVCViewController.h"

@interface NavigationVCViewController ()

@property(nonatomic, strong) NSMutableArray *imagesArr;//图片数组
@property(nonatomic, strong) UIImageView *lastVc;//图片容器
@property(nonatomic, strong) UIView *cover;//遮罩

@end

@implementation NavigationVCViewController


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    [self creatScreenShot];//自动截取一张图
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lastVc = [[UIImageView alloc] initWithFrame:self.view.frame];
    _cover = [[UIView alloc] initWithFrame:self.view.frame];
    _cover.backgroundColor = [UIColor darkGrayColor];
    _cover.alpha = 0.4;
    _imagesArr = [NSMutableArray arrayWithCapacity:0];
    
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [self.view addGestureRecognizer:recognizer];
    
}

-(void)dragging:(UIPanGestureRecognizer *)recognizer{

    if (self.childViewControllers.count <= 1) return;
    
    
    //在 x 轴上面滑动的距离
    CGFloat tx = [recognizer translationInView:self.view].x;
    
    //在 y 轴上面滑动的距离
    CGFloat ty = [recognizer translationInView:self.view].y;
    
    
    NSLog(@"%f,%f",tx,ty);
    

    //停止拖动
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state ==UIGestureRecognizerStateCancelled) {
//        界定 pop 还是还原
        CGFloat x = self.view.frame.origin.x;
        CGFloat y = self.view.frame.origin.y;
        
        //滑动超过一半
        if (ABS(x) >= self.view.frame.size.width*0.35 || ABS(y) >= self.view.frame.size.height*0.35) {
            
            [UIView animateWithDuration:0.5 animations:^{
               
                //判断是左、右，并且移到左，右边，再 pop.     写的一般自己优化吧
                if (x>0 &&y>0) {
                    
                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, self.view.frame.size.height);
                }else if(x>0 && y<0){
                
                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, -self.view.frame.size.height);
                }else if (x<0 && y>0){
                
                     self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, self.view.frame.size.height);
                }else if (x<0 && y<0){
                    
                     self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, -self.view.frame.size.height);
                    
                }
                
                
            }completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                [self.lastVc removeFromSuperview];
                [self.cover removeFromSuperview];
                [self.imagesArr removeLastObject];
                self.view.transform = CGAffineTransformIdentity;
                
            }];
            
        }else{
        
            [UIView animateWithDuration:0.5 animations:^{
               
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
    
        
    }
    //正在拖拽
    else{
    
        self.view.transform = CGAffineTransformMakeTranslation(tx, ty);
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //将截图添加到最后面
        
        self.lastVc.image = self.imagesArr[self.imagesArr.count - 2];
        [window insertSubview:self.lastVc atIndex:0];
        
        //添加遮盖
        [window insertSubview:self.cover aboveSubview:self.lastVc];
        
    }
    
    
}


/**
 截图
 */
-(void)creatScreenShot{

    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.imagesArr addObject:image];
}



-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [super pushViewController:viewController animated:YES];
    [self creatScreenShot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
