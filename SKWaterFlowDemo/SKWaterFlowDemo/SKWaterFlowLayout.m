//
//  SKWaterFlowLayout.m
//  SKWaterFlowDemo
//
//  Created by Alexander on 2017/9/23.
//  Copyright © 2017年 alexander. All rights reserved.
//

#import "SKWaterFlowLayout.h"
// 瀑布流默认的列数
static const NSInteger DefaultCols = 3;
//列间距
static const CGFloat ColMargin = 10;
//行间距
static const CGFloat RowMargin = 10;
//边缘间距
static const UIEdgeInsets DefaultEdgeInset = {10,10,10,10};

@interface SKWaterFlowLayout()
	//存放所有的布局属性
@property (nonatomic,strong)NSMutableArray *attrsArray;
// 用于存放所有列的最大高度
@property (nonatomic,strong)NSMutableArray *maxColHeights;

@end

@implementation SKWaterFlowLayout

- (NSMutableArray *)maxColHeights
{
	if (!_maxColHeights) {
		_maxColHeights = [NSMutableArray array];
	}
	return _maxColHeights;
}

- (NSMutableArray *)attrsArray
{
	if (!_attrsArray) {
		_attrsArray = [NSMutableArray array];
		
	}
	return _attrsArray;
}

/**
	1 初始化

*/
- (void)prepareLayout{
	[super prepareLayout];
	[self.attrsArray removeAllObjects];
	// 每次刷新 从零开始算一遍 清楚以前计算的所有高度
	[self.maxColHeights removeAllObjects];
	for (NSInteger i = 0; i < DefaultCols; i ++ ) {
		[self.maxColHeights addObject:@(DefaultEdgeInset.top)];
	}
	
	// 开始创建每一个cell
	NSInteger  count = [self.collectionView numberOfItemsInSection:0];
	for (NSInteger i = 0 ; i < count; i++) {
		// 创建每一个cell的位置属性
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
		// 创建布局属性
		UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
		
		// 添加到数组中去
		[self.attrsArray addObject:attrs];
		
	}

}
/**
	 2此方法决定了cell是如何排布的
*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

	return self.attrsArray;

}
/**
	3 返回indexPath cell 对应布局属性
*/
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
		// 创建布局属性
	UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
	// 设置布局属性的frame 核心计算方法
	
	// 计算宽度
	
	CGFloat collectionW = self.collectionView.frame.size.width;
	CGFloat w = (collectionW - DefaultEdgeInset.left - DefaultEdgeInset.right - (DefaultCols - 1) * ColMargin) / DefaultCols;
	
	CGFloat h = 80 + arc4random_uniform(100);
	// x 值的计算 只要确定列数 就可以知道x值，就要找出最短的一列，就可以确定x值，同时也可以确定y 值
	
	// 找出高度最短的那一列
	__block NSUInteger destCols =0;
	__block CGFloat minColsHeight = MAXFLOAT;
	// 遍历数组 求出最短的那一列
	[self.maxColHeights enumerateObjectsUsingBlock:^(NSNumber *colHeight, NSUInteger idx, BOOL * _Nonnull stop) {
		CGFloat columnHeight = colHeight.doubleValue;
		if (columnHeight < minColsHeight) {
			minColsHeight = columnHeight;
			destCols = idx;
		}
		
	}];
	
	CGFloat x = DefaultEdgeInset.left + (w + ColMargin) * destCols;

	CGFloat y = minColsHeight ;
	if (y != DefaultEdgeInset.top) {
		y += DefaultEdgeInset.top;
	}
	attrs.frame = CGRectMake(x, y, w, h);
	
	// 更新数组中最短那一列高度
	self.maxColHeights[destCols] = @(CGRectGetMaxY(attrs.frame));
	
	// 设置布局属性
	return attrs;
}

/**
	4 返回collection contentSize 实现滚动
*/
- (CGSize)collectionViewContentSize
{	//  算出其contentSize
	//  取得最长的一列就可以知道
	CGFloat maxColHeight = [self.maxColHeights[0] doubleValue];
	for (NSInteger i = 1; i < self.maxColHeights.count; i++) {
		// 获取第i列的高度 进行比较
		CGFloat columnHeight = [self.maxColHeights[i] doubleValue];
		if (columnHeight > maxColHeight) {
			maxColHeight = columnHeight;
		}
	}

	return CGSizeMake(0, maxColHeight + DefaultEdgeInset.bottom);
}

@end

