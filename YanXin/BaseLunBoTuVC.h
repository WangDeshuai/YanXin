//
//  BaseLunBoTuVC.h
//  LunBoTu
//
//  Created by Macx on 16/7/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PageCountrolPosition){
    PageControlPositionDownLeft=1,
    PageControlPositionDownCenter=2,
    PageControlPositionDownRight=3
};

@interface BaseLunBoTuVC : UIView
/*
 *  定时间的时间(默认是2秒)
 */
@property (nonatomic,assign)NSInteger  indexTime;
/*
 *  占位图片(必须要设置的)
 */
@property (nonatomic,copy)UIImage * placeholderImage;
/**
 *  当前被点击的图片索引
 */
@property(nonatomic,copy)void(^currentIndexDidTapBlock)(NSInteger index);
/**
 *  PageControl的位置
 */
@property (nonatomic, assign) PageCountrolPosition pageType;

/**
 *  显示图片标题的数组
 */
@property(nonatomic,retain)NSMutableArray * titleArray;
/**
 *  初始化
 */
-(id)initWithFrame:(CGRect)frame imageArray:(NSMutableArray*)imageArr;
@end
