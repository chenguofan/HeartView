
//
//  HeartView.m
//  WP-809
//
//  Created by C.G.M on 2018/1/8.
//  Copyright © 2018年 muhlenXi. All rights reserved.
//

#import "HeartView.h"

#define FRAME(x,y,width,height)  CGRectMake(x,y,width,height)

@interface HeartView ()

@property (nonatomic,strong) UIBezierPath * path;
@property (nonatomic,strong) CAShapeLayer * shapLayer;
@property (nonatomic,assign) CGFloat  beiginX;
@property (nonatomic,assign) NSInteger  selectTag;

@property (nonatomic,assign) CGFloat  HColun;

@end

@implementation HeartView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.clipsToBounds = YES;
        self.space = 2;
        self.datas = [NSMutableArray array];
        [self setUp];
    }
    return self;
}

-(void)setUp{
     CGFloat  ViewWidth = self.frame.size.width;
     CGFloat  ViewHeight = self.frame.size.height;
     self.beiginX = 30;

    self.HColun = (ViewWidth-30)/6.5;
    
    for (int i = 0; i<7; i++) {
        UILabel *line1 = [[UILabel alloc] init];
        line1.frame = FRAME(0,(ViewHeight - 30 - self.HColun * i), ViewWidth, 1);
        line1.backgroundColor = [UIColor lightGrayColor];
        line1.tag = 10 + i;
//        line1.backgroundColor = [UIColor redColor];
        [self addSubview:line1];
    }
    
    for (int i = 0; i<8; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = FRAME(self.HColun * i-15, ViewHeight -20, 30, 20);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%d",20*i];
//        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        
         self.selectTag = 20 + i;  //18
        
        NSLog(@"label.frame.origin.x: %f",label.frame.origin.x);
        
        UILabel *line2 = [[UILabel alloc] init];
        line2.frame = FRAME(self.HColun * i,0,1,ViewHeight-30);
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        
        if (i==0) {
            label.frame = CGRectMake(0, ViewHeight-20,15, 20);
            label.textAlignment = NSTextAlignmentLeft;
        }
    }

}

-(void)addDataToArr:(NSInteger )heartValue{

    CGPoint point;
    point.x = self.datas.count * self.space;
    if (point.x > self.frame.size.width) {
        //移动x轴
        self.contentOffset = CGPointMake(point.x-self.frame.size.width, 0);
    
        NSInteger x1 = (NSInteger)point.x;
        NSInteger x2 = (NSInteger)((self.selectTag -20 + 1) * self.HColun);
        NSLog(@"x1:%ld   x2:%ld",(long)x1,x2);
        
        if ((x1 - x2) <= 5 && (x1-x2)>= -30) {
            UILabel *labe = [[UILabel alloc] initWithFrame:FRAME((self.selectTag-20 + 1) * self.HColun-15,self.frame.size.height-20, 30, 20)];
//           labe.backgroundColor = [UIColor blueColor];
            labe.font = [UIFont systemFontOfSize:12];
            labe.textAlignment = NSTextAlignmentCenter;
            labe.textColor = [UIColor blackColor];
            labe.text = [NSString stringWithFormat:@"%ld",20*(self.selectTag-20+1)];
            [self addSubview:labe];
            
            self.selectTag += 1;
            
            //划线
            UILabel *line3 = [[UILabel alloc] init];
            line3.frame = FRAME(labe.center.x,0,1,self.frame.size.height-30);
            line3.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line3];
            
            if (self.selectTag>30) {
                UILabel *tempLab = [self viewWithTag:self.selectTag-10];
                [tempLab removeFromSuperview];
                tempLab = nil;
            }
        }
        //增长所有的横线的长度
        for (int i = 0; i<7; i++) {
            UILabel *la = [self viewWithTag:i + 10];
            CGRect frame = la.frame;
            frame.size.width += self.space;
            la.frame = CGRectMake(la.frame.origin.x, la.frame.origin.y,frame.size.width, frame.size.height);
        }
    }
    point.y = self.frame.size.height - 30 - heartValue/350.0 * (self.frame.size.height-30);
    [self.datas addObject:[NSData dataWithBytes:&point length:sizeof(CGPoint)]];
    
    [self.layer addSublayer:self.shapLayer];
    [self reCreateView];

    self.contentSize = CGSizeMake(point.x, 0);
}

-(void)reCreateView{
    if (self.datas.count>0) {
        NSInteger index = self.datas.count;
        CGPoint pp[2];
        [self.datas[index-1] getBytes:&pp[0] length:sizeof(CGPoint)];
        [self.path addLineToPoint:CGPointMake(pp[0].x,pp[0].y)];
        self.shapLayer.path = self.path.CGPath;
    }
}

-(UIBezierPath *)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(0,self.frame.size.height-30)];
    }
    return _path;
}

-(CAShapeLayer *)shapLayer{
    if (!_shapLayer) {
        _shapLayer = [CAShapeLayer layer];
        _shapLayer.lineWidth = 2;
        _shapLayer.strokeColor = [UIColor redColor].CGColor;
        _shapLayer.fillColor =  [UIColor clearColor].CGColor;
        _shapLayer.lineCap =  kCALineCapRound;
        _shapLayer.lineJoin = kCALineJoinRound;
        _shapLayer.contentsScale = [[UIScreen mainScreen] scale];
        self.path = [self path];
    }
    return _shapLayer;
}

-(void)dealloc{
    [self.shapLayer removeFromSuperlayer];
    self.shapLayer = nil;
}
@end
