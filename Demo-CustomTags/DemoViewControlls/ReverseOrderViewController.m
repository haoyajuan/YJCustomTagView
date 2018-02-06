//
//  ReverseOrderViewController.m
//  Demo-CustomTags
//
//  Created by haoyajuan on 2018/2/2.
//  Copyright © 2018年 haoyajuan. All rights reserved.
//

#import "ReverseOrderViewController.h"
#import "YJTagsView.h"

@interface ReverseOrderViewController ()
@property (nonatomic,strong) NSArray *tagsArray;
@property (nonatomic,strong) YJTagsView *tagsView;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ReverseOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.index = 0;
    
    [self tagview];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height-40, 80, 30)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"添加待调试" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)tagview{
    self.tagsArray = @[@"全部",@"钢琴",@"吉他",@"电吉他",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD"];
    // 创建标签列表
    YJTagsView *tagList = [[YJTagsView alloc] init];
    self.tagsView = tagList;
    // 高度可以设置为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 设置排序时，缩放比例
    tagList.scaleTagInSort = 1.3;
    tagList.tagMargin = 15;
    tagList.tagFont = [UIFont systemFontOfSize:20];
    // 需要排序
    tagList.isSort = YES;
    // 标签尺寸
    //    tagList.tagSize = CGSizeMake(110, 30);
    // 不需要自适应标签列表高度
    tagList.isFitTagListH = YES;
    [self.view addSubview:tagList];
    tagList.tagDeleteimage = [UIImage imageNamed:@"close"];
    // 设置标签背景色
    tagList.tagBackgroundColor = [UIColor yellowColor];
    // 设置标签颜色
    tagList.tagColor = [UIColor blackColor];
    tagList.reverseOrder = YES;
    // 点击标签，就会调用,点击标签，删除标签
    __weak typeof(tagList) weakTagList = tagList;
    tagList.clickTagBlock = ^(NSString *tag){
        [weakTagList dragViewfrom:tag.integerValue to:0];
    };
    tagList.clickDeleteBlock = ^(NSString *tag){
        [weakTagList deleteTag:tag];
    };
}
- (void)addTag{
//    NSString *tagStr = [NSString stringWithFormat:@"%@ (%d)",self.tagsArray[arc4random_uniform(3)],index];
    NSString *tagStr = [NSString stringWithFormat:@"%@",self.tagsArray[arc4random_uniform(self.tagsArray.count-1)]];
    self.index++;
//    [self.tagsView addSingleTag:tagStr];
    [self.tagsView addTag:tagStr];

}
@end

