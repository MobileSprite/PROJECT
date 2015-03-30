//
//  ModelDataTool.m
//  WRDate
//
//  Created by zjsruxxxy3 on 15/2/4.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "ModelDataTool.h"
#import "FMDatabase.h"
#import "DateModel.h"

#import "CurrentToken.h"
#import "AccessTokenTool.h"


@interface ModelDataTool ()
{
    
}

@end
@implementation ModelDataTool

static FMDatabase * _db;

+(void)initialize
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"dateCount.sqlite"];
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open])
    {
        BOOL result = [_db executeUpdate:@"create table if not exists t_time (id integer primary key autoincrement,identity text,dateText text,date text,fireDate text,access_token text);"];
        
        //,access_token text
        
        if (!result)
        {
            NSLog(@"create table failure");
            
        }
        
    }else
    {
        NSLog(@"open failure");
    }

}

+(void)addTimeData:(DateModel *)dateModel
{
    BOOL result = [_db executeUpdate:@"insert into t_time (identity,dateText,date,fireDate,access_token) values (?,?,?,?,?)",dateModel.identity,dateModel.dateText,dateModel.date,dateModel.fireDate,dateModel.access_token];
    
    if (!result)
    {
        NSLog(@"add failure");
    }

}

+(void)removeTimeData:(DateModel *)dateModel
{
    
    BOOL result = [_db executeUpdate:@"delete from t_time where identity = ? and access_token = ? ",dateModel.identity,dateModel.access_token];
    
    if (!result)
    {
        NSLog(@"delete failure");
    }

}

#warning 给模型添加唯一标示，accesss_token

+(NSArray *)allDateModel
{
    
    /**
     *  判断给出对应账号的access_token
     */
    
    FMResultSet *rs = [_db executeQuery:@"select * from t_time where access_token = ?;",[AccessTokenTool getCurrentTokenFromFile].current_access_token];
    
    NSMutableArray *modelArray =  [NSMutableArray array];
    
    while (rs.next)
    {
        DateModel *model = [[DateModel alloc]init];
        
        model.identity = [rs stringForColumn:@"identity"];
        
        model.dateText = [rs stringForColumn:@"dateText"];
        
        model.date = [rs stringForColumn:@"date"];
        
        model.fireDate = [rs stringForColumn:@"fireDate"];
        
        model.access_token = [rs stringForColumn:@"access_token"];
        
        [modelArray addObject:model];
        
    }
    
    return modelArray;
}
@end
