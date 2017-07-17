//
//  LZXViewController.m
//  引导页
//
//  Created by twzs on 16/6/23.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import "LZXViewController.h"
#import "LZXCollectionViewCell.h"
#import "MainViewController.h"
#import "LeftSortViewController.h"

@interface LZXViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation LZXViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;//隐藏标题栏
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置cell 大小
    layout.itemSize = self.view.bounds.size;
    
    // 设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    layout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    // 隐藏滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置分页效果
    collectionView.pagingEnabled = YES;
    
    // 设置弹簧效果
    collectionView.bounces =  NO;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[LZXCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageviewbg.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        
        GuideView *guide = [GuideView new];
        [guide showInView:[UIApplication sharedApplication].keyWindow maskBtn:nil];
        
        
        MainViewController * mainVC = [[MainViewController alloc]init];
        self.mainNC = [[RootNavigationController alloc]initWithRootViewController:mainVC];
        LeftSortViewController * leftSoutVC = [[LeftSortViewController alloc]init];
        UINavigationController * leftNC = [[UINavigationController alloc]initWithRootViewController:leftSoutVC];
        self.leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftNC andMainView:self.mainNC];
        [self.navigationController pushViewController:self.leftSlideVC animated:YES];
    }
}
@end
