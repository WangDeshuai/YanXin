//
//  BaseLunBoTuVC.m
//  LunBoTu
//
//  Created by Macx on 16/7/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseLunBoTuVC.h"
#import "UIImageView+WebCache.h"
@interface BaseLunBoTuVC ()<UIScrollViewDelegate>
{
    int offset_x;
    int tagg;
}
@property(nonatomic,retain)UIPageControl * pageControl;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)NSTimer * timer;
@property(nonatomic,retain)NSArray * arrImage;
@end
@implementation BaseLunBoTuVC

-(id)initWithFrame:(CGRect)frame imageArray:(NSMutableArray*)imageArr{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self CreatScrollerViewImage:imageArr];
        _arrImage=imageArr;
    }
    return self;
}
-(void)CreatScrollerViewImage:(NSArray*)imageArr{
     offset_x = self.frame.size.width;
    _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
    for (int i =0; i<imageArr.count; i++)
    {
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        UIImageView * imageview =[[UIImageView alloc]init];
        [imageview sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:_placeholderImage];
        imageview.userInteractionEnabled=YES;
        imageview.frame=CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.bounds.size.height);
        [imageview addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageview];
       
    }
    
    _scrollView.contentSize = CGSizeMake(imageArr.count*self.frame.size.width, self.bounds.size.height);
    // 水平指示器,默认为YES
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 垂直指示器,默认为YES
    _scrollView.showsVerticalScrollIndicator = NO;
    // 设置分页滑动,默认为NO
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    if (imageArr.count>1) {
        [self CreatpageControlView:imageArr];
        [self dingShiQi];
    }
   
   
    
}
-(void)setPageType:(PageCountrolPosition)pageType
{
    _pageType=pageType;
    switch (pageType) {
        case PageControlPositionDownLeft:
            _pageControl.frame=CGRectMake(10, _scrollView.frame.size.height-20,15*_arrImage.count, 20);
            break;
        case PageControlPositionDownCenter:
            _pageControl.frame=CGRectMake(0, _scrollView.frame.size.height-20, self.frame.size.width, 20);
            break;
        case PageControlPositionDownRight:
             _pageControl.frame=CGRectMake(self.frame.size.width-10-15*_arrImage.count, _scrollView.frame.size.height-20,15*_arrImage.count, 20);
            break;
            
        default:
            break;
    }
    
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray=titleArray;
    for (int i = 0; i<titleArray.count; i++) {
        UIView * view =[[UIView alloc]init];
        view.frame=CGRectMake(i*self.frame.size.width, self.frame.size.height-30, self.frame.size.width, 30);
        view.alpha=.7;
        view.backgroundColor=[UIColor lightGrayColor];
        [_scrollView addSubview:view];
        
        UILabel * lable =[[UILabel alloc]init];
        lable.text=titleArray[i];
        lable.textColor=[UIColor whiteColor];
        lable.frame=CGRectMake(20+i*self.frame.size.width, self.frame.size.height-30, self.frame.size.width, 30);
        [_scrollView addSubview:lable];
    }
    
}

-(void)tap:(UITapGestureRecognizer*)tap{
    self.currentIndexDidTapBlock(tagg);
    
}
-(void)CreatpageControlView:(NSArray*)imageArr{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.frame.size.height-20, self.frame.size.width, 20)];
    //_pageControl.backgroundColor=[UIColor yellowColor];
    // 设置指示器点的个数
    _pageControl.numberOfPages = imageArr.count;
    // 设置指示器点的颜色
  //  _pageControl.pageIndicatorTintColor = _pageColor;
    // 设置当前指示器点的颜色
    //_pageControl.currentPageIndicatorTintColor = _isPageColor;
    // 设置当前指示器所在的点位置
    _pageControl.currentPage = 0;
   
    [self addSubview:_pageControl];
}

-(void)changeImage{
    if (_scrollView.contentOffset.x == self.frame.size.width*(_arrImage.count-1))
    {
        offset_x =  -self.frame.size.width;
    }
    // 判断scrollView是否到达边界位置
    if (_scrollView.contentOffset.x == 0) {
        offset_x = self.frame.size.width;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x+offset_x, 0);
    _pageControl.currentPage = _scrollView.contentOffset.x/self.frame.size.width;
    [UIView commitAnimations];
    
}
-(void)dingShiQi{
    if (_indexTime) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_indexTime target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
}
#pragma mark -- UIScrollViewDelegate
// 代理方法,写在哪个类,就是哪个类的方法
// 滚动视图滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tagg=scrollView.contentOffset.x/self.frame.size.width;
    if (_timer == nil) {
        [self dingShiQi];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_timer == nil) {
        [self dingShiQi];
    }
    // 根据滚动视图的偏移量,计算当前所在的点
    int index = scrollView.contentOffset.x/self.frame.size.width;
    // 设置pageControl当前所在的点
    _pageControl.currentPage = index;
}
@end
