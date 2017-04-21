//
//  TableViewController.m
//  RealmProject
//
//  Created by 蜂巢网络科技 on 2017/4/20.
//  Copyright © 2017年 fc. All rights reserved.
//

#import "TableViewController.h"
#import "BlogObject.h"
#import "BlogPostTableViewCell.h"
@interface TableViewController ()
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation TableViewController


- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据库存入的地址
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    
    //  将数据写入数据库
    [BlogObject loadBlogData];
    
    self.title = @"Blogs";
    self.tableView.estimatedRowHeight = 88.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"BlogPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"blogCell"];
    
   
    // 读取数据库数据并添加到数组中
    RLMResults *results = [BlogObject allObjects];
    for (BlogObject *blog in results) {
        [self.dataList addObject:blog];
    }

    NSLog(@"%@",self.dataList);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BlogPostTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"blogCell"];
    BlogObject *blog = self.dataList[indexPath.row];
    cell.titleLabel.text = [blog.title capitalizedString];
    cell.emojiLabel.text = blog.emoji;
    cell.contentLabel.text = blog.content;
    
    return cell;
}


@end
