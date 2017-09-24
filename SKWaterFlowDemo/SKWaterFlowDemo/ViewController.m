//
//  ViewController.m
//  SKWaterFlowDemo
//
//  Created by Alexander on 2017/9/23.
//  Copyright © 2017年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "SKWaterFlowLayout.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define collectHeight 230
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectView;
    
@end

@implementation ViewController

 // 定义一个常量
static NSString * const SKID = @"cellID";
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 创建布局
    SKWaterFlowLayout *layout = [[SKWaterFlowLayout alloc]init];
    // 创建collectionView
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,kScreenH ) collectionViewLayout:layout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self.view addSubview:_collectView];
    
    // 注册
    
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SKID];
    
    
}


#pragma mark - 0 懒加载
#pragma mark - 1 数据加载
#pragma mark - 2 界面搭建
#pragma mark - 3 代理方法
// UICollectview Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return 50;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [self.collectView dequeueReusableCellWithReuseIdentifier:SKID forIndexPath:indexPath];
	
	
	UILabel *label = [[UILabel alloc]init];
	label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
	label.textColor = [UIColor redColor];
	[cell.contentView addSubview:label];
	cell.backgroundColor = [UIColor orangeColor];
	return cell;
	
}




    





    
    
    
    
#pragma mark - 4 事件响应
#pragma mark - 5 方法抽取

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
