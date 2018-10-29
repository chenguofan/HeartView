//
//  ViewController.m
//  HeartView
//
//  Created by ChenFan on 2018/10/26.
//  Copyright © 2018年 steven. All rights reserved.
//

#import "ViewController.h"
#import "HeartView.h"

@interface ViewController ()
@property (nonatomic,strong) NSTimer * testTimer;
@property (nonatomic,strong) NSMutableArray * mutDatas;
@property (nonatomic,strong) HeartView *heartView;
@end

@implementation ViewController

-(NSMutableArray *)mutDatas{
    if (!_mutDatas) {
        _mutDatas = [NSMutableArray array];
    }
    return _mutDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.testTimer = [NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(testMethod) userInfo:nil repeats:YES];
    
    self.heartView = [[HeartView alloc] initWithFrame:CGRectMake(0, 100,self.view.frame.size.width, 300)];
    [self.view addSubview:self.heartView];
    
    self.heartView.space = 2.f;
}

-(void)testMethod{
    NSInteger rate = arc4random()%200;
    [self.heartView addDataToArr:rate];
}

@end
