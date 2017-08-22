//
//  StaticCFunctionVCViewController.m
//  AnalysisAFN
//
//  Created by apple on 17/7/17.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "StaticCFunctionVCViewController.h"
#import "ViewController.h"

@interface StaticCFunctionVCViewController ()

@end

@implementation StaticCFunctionVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myFunction(@"name");
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
