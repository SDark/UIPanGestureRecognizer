//
//  ViewController.m
//  searchbar
//
//  Created by Mory on 2017/6/3.
//  Copyright © 2017年 Mory. All rights reserved.
//

#import "ViewController.h"
#import "DiySearchBar.h"
#import "secondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    DiySearchBar *_searchBar = [[DiySearchBar alloc] initWithFrame:CGRectMake(20, 150, self.view.frame.size.width - 40, 50)];
    _searchBar.placeholder = @"请输入查询内容";
//    _searchBar.delegate = self;
    
    //添加一些阴影
    _searchBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _searchBar.layer.shadowOpacity = 0.5;
    _searchBar.layer.shadowRadius = 2.0;
    _searchBar.layer.shadowOffset = CGSizeMake(0, 2);
    _searchBar.clipsToBounds = NO;
    
    //设置背景图是为了去掉背景色
    _searchBar.backgroundImage = [UIImage imageNamed:@"kk"];
//    会限制搜索框的高度
//    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"kk"];
    
    
    [self.view addSubview:_searchBar];
    
    [self addBtnPushView];

}

-(void)addBtnPushView{

    
    UIButton *btb = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, self.view.frame.size.width - 40, 50)];
    btb.backgroundColor = [UIColor blueColor];
    [btb addTarget:self action:@selector(pushGGG) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btb];
}


-(void)pushGGG{

    [self.navigationController pushViewController:[[secondViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
