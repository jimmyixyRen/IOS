#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Room.h"
#import <FMDB.h>
#define DB_FULL_PATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"/order.db"]
@interface Util : NSObject

/**
 *  初始化数据库
 */
-(void)initDB;

-(BOOL)deleteOneOrderByOrderID:(NSString *)orderID;

/**
 *  插入一条记录
 *
 *  @param aOrderID     order id
 *  @param aRoomName    room name
 *  @param aPersonCount 预订人数
 *
 *  @return 是否插入成功
 */
-(BOOL)insertOneOrder:(NSString *)aOrderID
             roomName:(NSString *)aRoomName
          personCount:(NSString *)aPersonCount;
-(BOOL)updateOneOrderByOrderID:(NSString *)aOrderID
                          deal:(NSString *)aDeal;

-(NSMutableArray *)getAllOrder;

-(void)saveValueToProfile:(id)value key:(id)key;
-(id)getValueFromProfileByKey:(id)key;

@property(nonatomic, strong) FMDatabase *dataBase;
@property(nonatomic, strong)AFHTTPRequestOperationManager *httpManager;
@property(nonatomic, copy) NSString *userid;
@property(nonatomic, copy)NSString *username;
@property(nonatomic, assign)BOOL  isLogined;
@property(nonatomic, strong)Room *selectRoom;
@property(nonatomic, strong) NSMutableArray *foodList;
@property(nonatomic, copy)NSString *orderUUID;
@property(nonatomic, assign)int orderLeftMinutes;
@property(nonatomic, assign)int orderPreCount;

+(Util *)SharedInstance;

@end
#define MAIN_SCREEN_WIDTH           [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_HTIGHT          [[UIScreen mainScreen] bounds].size.height
#define DEFAULT_LOGIN_NAME          @"default_login_name"
#define DEFAULT_LOGIN_PWD           @"default_lgoin_pwd"
#define NOTIFY_LOGIN                @"notify_login"


