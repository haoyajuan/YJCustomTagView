//
//  YJTagsView.m
//  Demo-CustomTags
//
//  Created by haoyajuan on 2018/2/2.
//  Copyright © 2018年 haoyajuan. All rights reserved.
//

#import "YJTagsView.h"

@implementation TagView
- (UIButton *)tagButton{
    if (!_tagButton) {
        _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_tagButton];
    }
    return _tagButton;
}
- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}
@end

@interface YJTagsView ()
@property (nonatomic, weak) UICollectionView *tagListView;
@property (nonatomic, strong) NSMutableArray *tagViewsArray;
@end

@implementation YJTagsView

- (NSMutableArray *)tagViewsArray
{
    if (_tagViewsArray == nil) {
        _tagViewsArray = [NSMutableArray array];
    }
    return _tagViewsArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - 初始化
- (void)setup
{
    _tagMargin = 10;
    _tagColor = [UIColor redColor];
    _tagButtonMargin = 5;
    _tagCornerRadius = 3;
    _tagBorderWidth = 0;
    _tagBorderColor = _tagColor;
    _scaleTagInSort = 1;
    _tagInnerXMargin = 5;
    _tagInnerYMargin = 5;
    _isFitTagListH = YES;
    _tagFont = [UIFont systemFontOfSize:13];
    self.clipsToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tagListView.frame = self.bounds;
}

- (void)setScaleTagInSort:(CGFloat)scaleTagInSort
{
    if (_scaleTagInSort < 1) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"(scaleTagInSort)缩放比例必须大于1" userInfo:nil];
    }
    _scaleTagInSort = scaleTagInSort;
}

- (CGFloat)tagListH
{
    if (self.tagViewsArray.count <= 0) return 0;
    return CGRectGetMaxY([self.tagViewsArray.lastObject frame]) + _tagMargin;
}

#pragma mark - 操作标签方法
// 添加多个标签
- (void)addTags:(NSArray *)tagStrs
{
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    if (_reverseOrder) {
        tagStrs = [[tagStrs reverseObjectEnumerator]allObjects];
    }
    for (NSString *tagStr in tagStrs) {
        [self addTag:tagStr];
    }
}
// 添加多个标签
- (void)reloadTags:(NSArray *)tagStrs
{
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    if (_reverseOrder) {
        tagStrs = [[tagStrs reverseObjectEnumerator]allObjects];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonFrame:0];
    }];
}

- (void)configTagView:(TagView*)tagView tagString:(NSString*)tagStr{
    
    tagView.layer.cornerRadius = _tagCornerRadius;
    tagView.layer.borderWidth = _tagBorderWidth;
    tagView.layer.borderColor = _tagBorderColor.CGColor;
    [tagView setBackgroundColor:_tagBackgroundColor];
    tagView.clipsToBounds = YES;
    [tagView.tagButton setTitle:tagStr forState:UIControlStateNormal];
    [tagView.tagButton setTitleColor:_tagColor forState:UIControlStateNormal];
    tagView.tagButton.titleLabel.font = _tagFont;
    CGSize size = [self getLableSize:tagStr Font:_tagFont];
    tagView.tagButton.frame = CGRectMake(_tagInnerXMargin, _tagInnerYMargin-1, size.width, size.height);
    [tagView.tagButton addTarget:self action:@selector(clickTag:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_tagDeleteimage) {
        [tagView.deleteButton setImage:_tagDeleteimage forState:UIControlStateNormal];
        [tagView.deleteButton addTarget:self action:@selector(clickDeleteTag:) forControlEvents:UIControlEventTouchUpInside];
        tagView.deleteButton.frame = CGRectMake(CGRectGetMaxX(tagView.tagButton.frame)+_tagButtonMargin, _tagInnerYMargin, tagView.tagButton.frame.size.height, tagView.tagButton.frame.size.height);
        CGRect rect = CGRectMake(tagView.frame.origin.x, tagView.frame.origin.y, tagView.tagButton.frame.size.width+_tagButtonMargin+tagView.deleteButton.frame.size.width+1.5*_tagInnerXMargin, tagView.tagButton.frame.size.height+2*_tagInnerYMargin);
        tagView.frame = rect;
    }else{
        CGRect rect = CGRectMake(tagView.frame.origin.x, tagView.frame.origin.y, tagView.tagButton.frame.size.width+2*_tagInnerXMargin, tagView.tagButton.frame.size.height+2*_tagInnerYMargin);
        tagView.frame = rect;
    }
    
    if (_isSort) {
        // 添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [tagView addGestureRecognizer:pan];
    }
}
// 添加标签
- (void)addTag:(NSString *)tagStr
{
    // 创建标签按钮
    TagView *tagView = [[TagView alloc]init];
    [self addSubview:tagView];
    
    [self configTagView:tagView tagString:tagStr];
    
    // 保存到数组
    tagView.tag = self.tagViewsArray.count;
    [self.tagViewsArray addObject:tagView];
    // 设置位置
    [self updateTagButtonFrame:tagView.tag];
    
    // 更新自己的高度
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}
- (void)addSingleTag:(NSString *)tagStr{
    // 创建标签按钮
    TagView *tagView = [[TagView alloc]init];
    [self addSubview:tagView];
    
    [self configTagView:tagView tagString:tagStr];
    
    // 保存到数组
    if (_reverseOrder) {
        [self.tagViewsArray insertObject:tagView atIndex:0];
        [self updateTag];
        [UIView animateWithDuration:0.25 animations:^{
            [self updateLaterTagButtonFrame:0];
        }];
    }else{
        tagView.tag = self.tagViewsArray.count;
        [self.tagViewsArray addObject:tagView];
        // 设置位置
        [self updateTagButtonFrame:tagView.tag];
    }
    
    // 更新自己的高度
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

// 点击标签
- (void)clickTag:(UIButton *)button
{
    TagView *tagView = (TagView*)button.superview;
    NSInteger index = tagView.tag;
    if (_reverseOrder) {
        index = self.tagViewsArray.count-tagView.tag-1;
    }
    if (_clickTagBlock) {
        _clickTagBlock([NSString stringWithFormat:@"%ld",(long)index]);
    }
}
// 点击删除标签
- (void)clickDeleteTag:(UIButton *)button
{
    TagView *tagView = (TagView*)button.superview;
    NSInteger index = tagView.tag;
    if (_reverseOrder) {
        index = self.tagViewsArray.count-tagView.tag-1;
    }
    if (_clickDeleteBlock) {
        _clickDeleteBlock([NSString stringWithFormat:@"%ld",(long)index]);
    }
}
// 拖动标签
- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取偏移量
    CGPoint transP = [pan translationInView:self];
    
    TagView *tagView = (TagView *)pan.view;
    
    // 开始
    if (pan.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:-.25 animations:^{
            tagView.transform = CGAffineTransformMakeScale(_scaleTagInSort, _scaleTagInSort);
        }];
        [self addSubview:tagView];
    }
    
    CGPoint center = tagView.center;
    center.x += transP.x;
    center.y += transP.y;
    tagView.center = center;
    
    // 改变
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        // 获取当前按钮中心点在哪个按钮上
        TagView *otherView = [self buttonCenterInButtons:tagView];
        
        if (otherView) { // 插入到当前按钮的位置
            // 获取插入的角标
            NSInteger i = otherView.tag;
            
            // 获取当前角标
            NSInteger curI = tagView.tag;
            
            // 排序
            [self.tagViewsArray removeObject:tagView];
            [self.tagViewsArray insertObject:tagView atIndex:i];
            
            // 更新tag
            [self updateTag];
            
            if (curI > i) { // 往前插
                // 更新终点之后标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateLaterTagButtonFrame:i];
                }];
            } else { // 往后插
                // 更新起点之后标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateLaterTagButtonFrame:curI];
                }];
            }
        }
    }
    
    // 结束
    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25 animations:^{
            tagView.transform = CGAffineTransformIdentity;
            // 更新终点之后标签frame
            [UIView animateWithDuration:0.25 animations:^{
                [self updateLaterTagButtonFrame:tagView.tag];
            }];
        }];
    }
    [pan setTranslation:CGPointZero inView:self];
}

- (void)dragViewfrom:(NSInteger)start to:(NSInteger)end{
    
    end = end > self.tagViewsArray.count-1 ? self.tagViewsArray.count-1 : end;
    end = end < 0 ? 0 : end;
    //获取当前按钮
    TagView *tagView = self.tagViewsArray[start];
    [self.tagViewsArray removeObject:tagView];
    [self.tagViewsArray insertObject:tagView atIndex:end];
    [self updateTag];
    if (start > end) {
        [UIView animateWithDuration:0.25 animations:^{
            [self updateLaterTagButtonFrame:end];
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            [self updateLaterTagButtonFrame:start];
        }];
    }
}

// 看下当前按钮中心点在哪个按钮上
- (TagView *)buttonCenterInButtons:(TagView *)curView
{
    for (TagView *view in self.tagViewsArray) {
        if (curView == view) continue;
        if (CGRectContainsPoint(view.frame, curView.center)) {
            return view;
        }
    }
    return nil;
}

// 删除标签
- (void)deleteTag:(NSString *)tagStr
{
    NSInteger index = tagStr.intValue;
    if (_reverseOrder) {
        index = self.tagViewsArray.count-tagStr.intValue-1;
    }
    // 获取对应的标题按钮
    TagView *tagView = self.tagViewsArray[index];
    // 移除按钮
    [tagView removeFromSuperview];
    
    // 移除数组
    [self.tagViewsArray removeObject:tagView];
    
    // 更新tag
    [self updateTag];
    
    // 更新后面按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonFrame:tagView.tag];
    }];
    
    // 更新自己的frame
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

// 更新标签
- (void)updateTag
{
    NSInteger count = self.tagViewsArray.count;
    for (int i = 0; i < count; i++) {
        TagView *tagView = self.tagViewsArray[i];
        tagView.tag = i;
    }
}

// 更新以后按钮
- (void)updateLaterTagButtonFrame:(NSInteger)laterI
{
    for (NSInteger i = laterI; i < self.tagViewsArray.count; i++) {
        // 更新按钮
        [self updateTagButtonFrame:i];
    }
}

- (void)updateTagButtonFrame:(NSInteger)i
{
    // 获取上一个按钮
    NSInteger preI = i - 1;
    
    // 定义上一个按钮
    TagView *preView;
    
    // 过滤上一个角标
    if (preI >= 0) {
        preView = self.tagViewsArray[preI];
    }
    
    // 获取当前按钮
    TagView *curView = self.tagViewsArray[i];
    // 判断是否设置标签的尺寸
    if (_tagSize.width == 0) {
        //没有设置标签尺寸 自适应标签尺寸 标签按钮frame（自适应）
        [self setupTagButtonCustomFrame:curView preButton:preView];
    } else {
        // 按规律排布 计算标签按钮frame（regular）
        [self setupTagButtonRegularFrame:curView];
    }
}

// 计算标签按钮frame（按规律排布）
- (void)setupTagButtonRegularFrame:(TagView *)curView
{
    _tagListCols = (self.bounds.size.width-_tagMargin)/(_tagSize.width+_tagMargin);
    // 获取角标
    NSInteger i = curView.tag;
    NSInteger col = i % _tagListCols;
    NSInteger row = i / _tagListCols;
    CGFloat viewW = _tagSize.width;
    CGFloat viewH = _tagSize.height;
    NSInteger margin = ((self.bounds.size.width-_tagListCols*_tagSize.width)/(_tagListCols+1));
    CGFloat viewX = margin*(col+1) +_tagSize.width*col;
    CGFloat viewY = _tagMargin + row * (viewH + _tagMargin);
    curView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    //
    CGFloat buttonW = curView.tagButton.frame.size.width;
    CGFloat buttonX = (viewW-buttonW)/2.0;
    CGFloat buttonY = (viewH-curView.tagButton.frame.size.height)/2.0;
    if (_tagDeleteimage) {
        buttonX = (viewW-buttonW-curView.deleteButton.frame.size.width-_tagButtonMargin)/2.0;
        curView.tagButton.frame = CGRectMake(buttonX, buttonY, buttonW, curView.tagButton.frame.size.height);
        curView.deleteButton.frame = CGRectMake(buttonX+buttonW+_tagButtonMargin, buttonY, curView.deleteButton.frame.size.width, curView.deleteButton.frame.size.height);
    }else{
        curView.tagButton.center = CGPointMake(curView.frame.size.width/2.0, curView.frame.size.height/2.0);
    }
}

// 设置标签按钮frame（自适应）
- (void)setupTagButtonCustomFrame:(TagView *)curView preButton:(TagView *)preView
{
    // 等于上一个按钮的最大X + 间距
    CGFloat btnX = CGRectGetMaxX(preView.frame) + _tagMargin;
    // 等于上一个按钮的Y值,如果没有就是标签间距
    CGFloat btnY = preView? preView.frame.origin.y : _tagMargin;
    
    CGFloat btnW = curView.frame.size.width;
    CGFloat btnH = curView.frame.size.height;
    
    // 判断当前按钮是否足够显示
    CGFloat rightWidth = self.bounds.size.width - _tagMargin - btnX;
    
    if (rightWidth < btnW) {// 不够显示，显示到下一行
        btnX = _tagMargin;
        btnY = CGRectGetMaxY(preView.frame) + _tagMargin;
    }
    
    curView.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (CGSize)getLableSize:(NSString*)str Font:(UIFont *)font{
    CGSize constrainedToSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGRect rect = [str boundingRectWithSize:constrainedToSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return rect.size;
}
@end

