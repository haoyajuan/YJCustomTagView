//
//  TagsView.h
//  Demo-CustomTags
//
//  Created by haoyajuan on 2018/1/2.
//  Copyright © 2018年 haoyajuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define TagsTitleFont [UIFont systemFontOfSize:13]
//// 最小内边距
//#define MinPadding 20
//// 标签间距
//#define TagsMargin 10
//// 标签行间距
//#define TagsLineMargin 10

@interface TagsViewFrame : NSObject
/** 标签名字数组 */
@property (nonatomic, strong) NSArray *tagsArray;
/** 标签frame数组 */
@property (nonatomic, strong) NSMutableArray *tagsFrames;
/** 全部标签的高度 */
@property (nonatomic, assign) CGFloat tagsHeight;
/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMargin;
/** 标签行间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsLineSpacing;
/** 标签最小内边距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMinPadding;
@end


@interface TagsView : UIView
@property (nonatomic, strong) TagsViewFrame *tagsFrame;

@end
