//
//  SZHeroPickerCollectionViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/21.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZHeroPickerCollectionViewController.h"
#import "SZHeroCollectionViewCell.h"
#import "SZHero.h"

@interface SZHeroPickerCollectionViewController ()
@property (nonatomic, strong) NSArray *heroArray;
@end

@implementation SZHeroPickerCollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择阵容";
    
    // Do any additional setup after loading the view.
    _heroArray = [SZHero all];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.collectionView.allowsMultipleSelection = YES;
    
    if (!_selectedHeroArray) {
        _selectedHeroArray = [[NSMutableArray alloc] init];
    } else {
        for (SZHero *hero in _selectedHeroArray) {
            NSInteger index = [_heroArray indexOfObject:hero];
            if (index != NSNotFound) {
                [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
        }
    }
}

- (void)doneAction
{
    [_selectedHeroArray removeAllObjects];
    NSArray *array = [self.collectionView indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in array) {
        [_selectedHeroArray addObject:[_heroArray objectAtIndex:indexPath.row]];
    }
    !_selectedBlock?:_selectedBlock(_selectedHeroArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _heroArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SZHeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SZHero *hero = _heroArray[indexPath.row];
        // 耗时的操作
        UIImage *image = [UIImage imageNamed:hero.imageName];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [cell.heorImage setImage:image];
        });
    });
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [collectionView indexPathsForSelectedItems];
    NSInteger index = [array indexOfObject:indexPath];
    if (index == NSNotFound) {
        if (array.count >= 5) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
