//
//  HeartView.h
//  WP-809
//
//  Created by C.G.M on 2018/1/8.
//  Copyright © 2018年 muhlenXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartView : UIScrollView

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,assign) CGFloat  space;

-(void)addDataToArr:(NSInteger )heartValue;

@end
