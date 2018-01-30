//
//  ViewController.m
//  Demo-CustomTags
//
//  Created by haoyajuan on 2018/1/2.
//  Copyright © 2018年 haoyajuan. All rights reserved.
//

#import "ViewController.h"

#import "TagsView.h"

#import "TagsList.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *tagsArray;

@property (nonatomic, strong) NSMutableArray *tagsFrames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    _tagsArray = @[@"全部",@"钢琴",@"吉他",@"电吉他",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD"];
//
//    TagsViewFrame *frame = [[TagsViewFrame alloc] init];
////    frame.tagsMinPadding = 5;
////    frame.tagsMargin = 20;
////    frame.tagsLineSpacing = 10;
//    frame.tagsArray = _tagsArray;
//
////    TagsView *cell = [[TagsView alloc]init];
//    TagsView *cell = [[TagsView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, frame.tagsHeight)];
////    TagsView *cell = [[TagsView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 0)];
//    cell.backgroundColor = [UIColor yellowColor];
//
//    cell.tagsFrame = frame;
//    [self.view addSubview:cell];
    
    
    
    
//    NSArray *tags = @[@"测试测试1",@"测试测试2",@"测试测试3",@"小测试测试4",@"iOS学院0",@"iOS学院1",@"iOS学院2",@"iOS学院3",@"测试000",@"测试001",@"测试002",@"测试003"];
    NSArray *tags = @[@"全部",@"钢琴",@"吉他",@"电吉他",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD"];
    // 创建标签列表
    TagsList *tagList = [[TagsList alloc] init];
    // 高度可以设置为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 设置排序时，缩放比例
    tagList.scaleTagInSort = 1.3;
    tagList.tagMargin = 15;
    tagList.tagFont = [UIFont systemFontOfSize:20];
    //    tagList.scaleTagInSort = 2;
    // 需要排序
    tagList.isSort = YES;
    // 标签尺寸
//    tagList.tagSize = CGSizeMake(80, 30);
    // 不需要自适应标签列表高度
    tagList.isFitTagListH = YES;
    [self.view addSubview:tagList];
    tagList.tagDeleteimage = [UIImage imageNamed:@"close"];
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



@end
