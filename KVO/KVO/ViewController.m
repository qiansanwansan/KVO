//
//  ViewController.m
//  KVO
//
//  Created by 冯宇的Mac mini on 2019/6/20.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import "ViewController.h"
#import "FYModel.h"
@interface ViewController ()
@property(nonatomic, strong) FYModel *model;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _model.name = @"chenwenting";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _model = [FYModel new];
    _model.name = @"fengyu";
    [_model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(@{@"englishName":@"hh"})];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"name"])
    {
        NSLog(@"当前--%@",_model.name);
        NSLog(@"New--%@",change[@"new"]);
        NSLog(@"Old--%@",change[@"old"]);
#warning-------这里会报错，如果 context 传字符串是 OK 的，也无需桥接。
        /*
         context：
         Arbitrary data that is passed to observer in observeValue(forKeyPath:of:change:context:).
         */
        
        id dic = (__bridge id)(context);
        NSLog(@"context--%@",dic);
    }
}
- (void)dealloc{
    [_model removeObserver:self forKeyPath:@"name"];
}

@end
