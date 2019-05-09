//
//  BYSQLLiteViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/23.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYSQLLiteViewController.h"
#import <sqlite3.h>

@interface BYSQLLiteViewController ()

@end

@implementation BYSQLLiteViewController {
    sqlite3 *database;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //打开数据库
    int databaseResult = sqlite3_open([[self path] UTF8String], &database);
    if (databaseResult == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据失败，%d", databaseResult);
    }
    
    
}

//生成路径
- (NSString *)path {
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArr firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/crylown.db",documentPath];
    NSLog(@"%@",path);
    return path;
}

//创建表
- (IBAction)createTable:(UIButton *)sender {
    char *error;
    
    //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
    const char *creatSQL = "create table if not exists haha(id integer primary key autoincrement, name char,sex char)";
    int databaseResult = sqlite3_exec(database, creatSQL, NULL, NULL, &error);
    if (databaseResult == SQLITE_OK) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败，%d", databaseResult);
    }
}

//添加数据
- (IBAction)addData:(UIButton *)sender {
    //stmt是一个数据位置指针，标记查询到数库的数据位置
    sqlite3_stmt *stmt;
    const char *insertSQL = "insert into haha (name,sex) values ('IOSRunner', 'male')";
    
    //sqlite3_prepare_v2()方法进行数据库查询的准备工作，第一个参数为成功打开的数据库指针，第二个参数为要执行的查询语句，第三个参数为sqlite3_stmt指针的地址，这个方法也会返回一个int值，作为标记状态是否成功。
    int insertResult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, nil);
    
    if (insertResult == SQLITE_OK) {
        sqlite3_step(stmt);
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败，%d", insertResult);
    }
    
//    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
//    int result = sqlite3_exec(database, insertSQL, nil, nil, &error);
//    if (result == SQLITE_OK) {
//        NSLog(@"添加数据成功");
//    } else {
//        NSLog(@"添加数据失败");
//    }
}

//查询数据
- (IBAction)queryData:(UIButton *)sender {
    sqlite3_stmt *stmt;
    
    const char *searchSQL = "select * from haha";
    int searchResult = sqlite3_prepare_v2(database, searchSQL, -1, &stmt, nil);
    if (searchResult == SQLITE_OK) {
        NSLog(@"查询数据成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int idWord = sqlite3_column_int(stmt, 0);
            char *nameWord = (char *)sqlite3_column_text(stmt, 1);
            char *sexWord = (char *)sqlite3_column_text(stmt, 2);
            NSLog(@" %d , %s , %s ", idWord, nameWord, sexWord);
            
        }
    } else {
        NSLog(@"查询数据失败，%d", searchResult);
    }
}

//修改数据
- (IBAction)update:(UIButton *)sender {
    sqlite3_stmt *stmt;
    const char *changeSQL = "update haha set name = 'xiugai' where name = 'IOSRunner'";
    int updateResult = sqlite3_prepare_v2(database, changeSQL, -1, &stmt, nil);
    
    if (updateResult == SQLITE_OK) {
        sqlite3_step(stmt);
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败，%d", updateResult);
    }
}

//删除数据
- (IBAction)deleteData:(UIButton *)sender {
    sqlite3_stmt *stmt;
    const char *deleteSQL = "delete from haha where name = 'xiugai'";
    int deleteResult = sqlite3_prepare_v2(database, deleteSQL, -1, &stmt, nil);
    if (deleteResult == SQLITE_OK) {
        sqlite3_step(stmt);
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败，%d", deleteResult);
    }
}




- (IBAction)goback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
