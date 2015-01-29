#import "Util.h"

@implementation Util
@synthesize httpManager, dataBase;

-(BOOL)deleteOneOrderByOrderID:(NSString *)orderID
{
    if (![dataBase open])
    {
        return NO;
    }
    BOOL res = [dataBase executeUpdate:@"delete from order_info where order_id=?", orderID];
    if (res)
    {
        NSLog(@"delete done.");
    }
    else
    {
        NSLog(@"delete error.");
    }
    
    return res;
}

-(NSMutableArray *)getAllOrder
{
    if (![dataBase open])
    {
        return nil;
    }
    NSMutableArray *retArray = [[NSMutableArray alloc] initWithCapacity:0];
    FMResultSet *res =  [dataBase executeQuery:@"select * from order_info"];
    while ([res next])
    {
        NSMutableDictionary *orderDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [orderDict setObject:[res stringForColumn:@"order_room_name"] forKey:@"order_room_name"];
        [orderDict setObject:[res stringForColumn:@"order_id"] forKey:@"order_id"];
        [retArray addObject:orderDict];
    }
    
    return retArray;
}

-(BOOL)updateOneOrderByOrderID:(NSString *)aOrderID
                          deal:(NSString *)aDeal
{
    if (![dataBase open])
    {
        return NO;
    }
    BOOL res = [dataBase executeUpdate:@"update order_info set order_is_deal=? where order_id=?", aDeal, aOrderID];
    if (!res)
    {
        NSLog(@"update error.");
    }
    else
    {
        NSLog(@"update done.");
    }
    
    return res;
}

-(BOOL)insertOneOrder:(NSString *)aOrderID
             roomName:(NSString *)aRoomName
          personCount:(NSString *)aPersonCount
{
    if (![dataBase open])
    {
        return NO;
    }
    
    BOOL res = [dataBase executeUpdate:@"insert into order_info(order_id, order_room_name, order_person_count, order_is_deal) values(?,?,?,?)",aOrderID, aRoomName, aPersonCount,@"0"];
    if (res)
    {
        NSLog(@"insert done.");
    }
    else
    {
        NSLog(@"insert error.");
    }
    return res;
}

-(void)initDB
{
    NSLog(@"%@", DB_FULL_PATH);
    dataBase = [FMDatabase databaseWithPath:DB_FULL_PATH];
    if (![dataBase open])
    {
        NSLog(@"open db error.");
    }
    else
    {
        BOOL res= [dataBase executeUpdate:@"create table if not exists order_info(oid integer primary key autoincrement,order_id text, order_room_name text, order_person_count text, order_is_deal text)"];
        
        if (!res)
        {
            NSLog(@"create table error.");
        }
        else
        {
            NSLog(@"create table done.");
        }
    }
}

-(void)saveValueToProfile:(id)value key:(id)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
}

-(id)getValueFromProfileByKey:(id)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults valueForKey:key];
}




static Util *Instance;
+(Util *)SharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//GCD
        Instance = [[Util alloc] init];
        Instance.foodList = [[NSMutableArray alloc] initWithCapacity:0];
        Instance.httpManager = [AFHTTPRequestOperationManager manager];
        Instance.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        Instance.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        Instance.isLogined = NO;
    });
    return Instance;
}

@end
