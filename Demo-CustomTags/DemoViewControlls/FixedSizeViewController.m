//
//  FixedSizeViewController.m
//  Demo-CustomTags
//
//  Created by haoyajuan on 2018/2/2.
//  Copyright © 2018年 haoyajuan. All rights reserved.
//
#import "YJTagsView.h"

#import "FixedSizeViewController.h"

@interface FixedSizeViewController ()
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;
@end

@implementation FixedSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView1];
    [self addView2];
    [self addView3];
}
- (void)addView1{
    NSArray *tags = @[@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"武士桑",@"触手猴",@"BGM",@"口琴",@"贝斯",@"卡祖笛"];
    // 创建标签列表
    YJTagsView *tagList = [[YJTagsView alloc] init];
    self.view1 = tagList;
    // 高度可以设置为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 设置排序时，缩放比例
    tagList.scaleTagInSort = 1.3;
    tagList.tagMargin = 15;
    // 需要排序
    tagList.isSort = YES;
    // 标签尺寸
    tagList.tagSize = CGSizeMake(80, 30);
    // 不需要自适应标签列表高度
    tagList.isFitTagListH = YES;
    [self.view addSubview:tagList];
    // 设置标签背景色
    tagList.tagBackgroundColor = [UIColor yellowColor];
    // 设置标签颜色
    tagList.tagFont = [UIFont systemFontOfSize:18];
    tagList.tagColor = [UIColor darkGrayColor];
//    tagList.tagDeleteimage = [UIImage imageNamed:@"close2"];
//    tagList.tagBorderColor = [UIColor darkGrayColor];
//    tagList.tagBorderWidth = 0.5;

    // 点击标签，就会调用,点击标签，删除标签
    __weak typeof(tagList) weakTagList = tagList;
    tagList.clickTagBlock = ^(NSString *tag){
        [weakTagList dragViewfrom:tag.integerValue to:0];
    };
    tagList.clickDeleteBlock = ^(NSString *tag){
        [weakTagList deleteTag:tag];
    };
    /**这里一定先设置标签列表属性，然后最后去添加标签*/
    [tagList addTags:tags];

}
- (void)addView2{
    NSArray *tags = @[@"全部",@"钢琴",@"吉他",@"电吉他",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"武士桑",@"触手猴"];
    // 创建标签列表
    YJTagsView *tagList = [[YJTagsView alloc] init];
    self.view2 = tagList;
    // 高度可以设置为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, self.view1.frame.origin.y+self.view1.frame.size.height+10, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 设置排序时，缩放比例
    tagList.scaleTagInSort = 1.3;
    tagList.tagMargin = 15;
    tagList.tagFont = [UIFont systemFontOfSize:18];
    // 需要排序
    tagList.isSort = YES;
    // 标签尺寸
    tagList.tagSize = CGSizeMake(100, 30);
    // 不需要自适应标签列表高度
    tagList.isFitTagListH = YES;
    [self.view addSubview:tagList];
    // 设置标签背景色
    tagList.tagBackgroundColor = [UIColor yellowColor];
    // 设置标签颜色
    tagList.tagColor = [UIColor blackColor];
    
    // 点击标签，就会调用,点击标签，删除标签
    __weak typeof(tagList) weakTagList = tagList;
    //    __block NSArray *blockArray = tags;
    tagList.clickTagBlock = ^(NSString *tag){
        //        [weakTagList reloadTags:tags];
        [weakTagList dragViewfrom:tag.integerValue to:0];
    };
    tagList.clickDeleteBlock = ^(NSString *tag){
        [weakTagList deleteTag:tag];
    };
    /**
     *  这里一定先设置标签列表属性，然后最后去添加标签
     */
    [tagList addTags:tags];

}
- (void)addView3{
    NSArray *tags = @[@"千本樱",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"ACG指弹",@"武士桑",@"LAUNCHPAD"];
    // 创建标签列表
    YJTagsView *tagList = [[YJTagsView alloc] init];
    self.view3 = tagList;
    // 高度可以设置为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, self.view2.frame.origin.y+self.view2.frame.size.height+10, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 设置排序时，缩放比例
    tagList.scaleTagInSort = 1.3;
    tagList.tagMargin = 15;
    tagList.tagFont = [UIFont systemFontOfSize:20];
    // 需要排序
    tagList.isSort = YES;
    // 标签尺寸
    tagList.tagSize = CGSizeMake(150, 30);
    // 不需要自适应标签列表高度
    tagList.isFitTagListH = YES;
    [self.view addSubview:tagList];
    // 设置标签背景色
    tagList.tagBackgroundColor = [UIColor yellowColor];
    // 设置标签颜色
    tagList.tagColor = [UIColor blackColor];
    
    // 点击标签，就会调用,点击标签，删除标签
    __weak typeof(tagList) weakTagList = tagList;
    tagList.clickTagBlock = ^(NSString *tag){
        [weakTagList dragViewfrom:tag.integerValue to:0];
    };
    tagList.clickDeleteBlock = ^(NSString *tag){
        [weakTagList deleteTag:tag];
    };
    /**
     *  这里一定先设置标签列表属性，然后最后去添加标签
     */
    [tagList addTags:tags];
    
}

@end
