//
//  SKWaterFlowLayout.m
//  SKWaterFlowDemo
//
//  Created by Alexander on 2017/9/23.
//  Copyright © 2017年 alexander. All rights reserved.
//

#import "SKWaterFlowLayout.h"

@implementation SKWaterFlowLayout
/**
	1 初始化

*/
- (void)prepareLayout{
	[super prepareLayout];

}
/**
	 2此方法决定了cell是如何排布的
*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
	return nil;

}
/**
	3 返回indexPath cell 对应布局属性
*/
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
	return nil;
}

/**
	4 返回collection contentSize 实现滚动
*/
- (CGSize)collectionViewContentSize
{
	return CGSizeMake(0, 900);
}

@end

