//
//  AddImageCCell.m
//  Technology
//
//  Created by user on 25/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "AddImageCCell.h"
@interface AddImageCCell()
@end
@implementation AddImageCCell


-(void)awakeFromNib{
    [super awakeFromNib];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    self.imageView = imageView;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        self.imageView = imageView;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
      UILongPressGestureRecognizer*  tapp=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tappClick:)];
        [self.contentView addGestureRecognizer:tapp];
        
        _picContainerView=[SDWeiXinPhotoContainerView new];
        [self addSubview:_picContainerView];
        _picContainerView.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0);
    }
    return self;
}
-(void)tappClick:(UILongPressGestureRecognizer*)tpp{
    self.TapBlock(tpp);
    
}
-(void)setStrUrl:(NSString *)strUrl{
    _strUrl=strUrl;
     _picContainerView.picPathStringsArray=@[strUrl];
    
}

@end
