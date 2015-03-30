//
//  EventDataTool.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/3/1.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "EventDataTool.h"
#import "FMDatabase.h"
#import "remainModel.h"

#import "CurrentToken.h"
#import "AccessTokenTool.h"
#import "MJExtension.h"

@interface EventDataTool ()


@end

@implementation EventDataTool

static FMDatabase * _db;

+(void)initialize
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"EventRemind.sqlite"];
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open])
    {
        BOOL result = [_db executeUpdate:@"create table if not exists t_event (id integer primary key autoincrement,text2 text,music text,date blob,idenity text,new text,handOff text,times text,groupInfo text,access_token text,uniqueID text);"];
        
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

+(void)addDBModel:(remainModel *)model
{
    
    NSLog(@"%@",model);
    
    BOOL result = [_db executeUpdate:@"insert into t_event (text2,idenity,music,date,access_token,new,handOff,times,groupInfo,uniqueID) values (?,?,?,?,?,?,?,?,?,?)",model.text,model.idenity,model.music,model.date,model.access_token,[NSString stringWithFormat:@"%d",model.New],[NSString stringWithFormat:@"%d",model.handOff],[NSString stringWithFormat:@"%d",model.timesNum],model.groupInfo,model.uniqueID];

    if (!result)
    {
        NSLog(@"add failure");
    }
    
}

+(void)removeDBModel:(remainModel *)model
{
    BOOL result = [_db executeUpdate:@"delete from t_event where uniqueID = ? and access_token = ? ",model.uniqueID,model.access_token];
    
    if (!result)
    {
        NSLog(@"delete failure");
    }

}

+(void)modifyDBModel:(remainModel *)model
{
    NSLog(@"%@",model);
    
    BOOL result = [_db executeUpdate:@"update t_event set text2 = ?,idenity = ? ,music = ? ,date = ?, new = ?, handOff = ? ,times = ? ,groupInfo = ?  where access_token = ? and uniqueID = ? ",model.text,model.idenity,model.music,model.date,[NSString stringWithFormat:@"%d",model.New],[NSString stringWithFormat:@"%d",model.handOff],[NSString stringWithFormat:@"%d",model.timesNum],model.groupInfo,model.access_token,model.uniqueID];
    
    if (!result)
    {
        NSLog(@"modify failure");
    }
}

+(NSArray *)allremainModel
{
    /**
     *  判断给出对应账号的access_token
     */
    
    FMResultSet *rs = [_db executeQuery:@"select * from t_event where access_token = ?;",[AccessTokenTool getCurrentTokenFromFile].current_access_token];
    
    NSMutableArray *modelArray =  [NSMutableArray array];
    
    while (rs.next)
    {
        remainModel *model = [[remainModel alloc]init];
        model.access_token = [rs stringForColumn:@"access_token"];
        model.text = [rs stringForColumn:@"text2"];
        model.date = [rs dateForColumn:@"date"];
        model.music = [rs stringForColumn:@"music"];
        model.handOff = [[rs stringForColumn:@"handOff"] boolValue];
        model.New = [[rs stringForColumn:@"new"] boolValue];
        model.timesNum = [[rs stringForColumn:@"times"]intValue];
        model.idenity = [rs stringForColumn:@"idenity"];
        model.groupInfo =[rs stringForColumn:@"groupInfo"];
        model.uniqueID = [rs stringForColumn:@"uniqueID"];
        
        [modelArray addObject:model];
        
    }
    
    return modelArray;

    
}

@end
