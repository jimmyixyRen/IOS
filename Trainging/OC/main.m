#import <Foundation/Foundation.h>
#import "Car.h"//跟include的区别
#import "NSString+Print.h"

int main(int argc, char const *argv[])
{
	
	printf("Hello Objective-c\n");


	NSLog(@"Hello from NSLog");
	NSString *str = [[NSString alloc] initWithFormat:@"Hello %@", @"NSString"];
	NSLog(@"%@", str);

	
    @autoreleasepool
    {
        //打印
        NSLog(@"Hello, World from framwork!");
        printf("Hello worl from c\n");
        
        
        //类
        Car  *c;
        c = [[Car alloc] init];
        c.name = @"别克";
        c.price = 100000;
        c.production = @"通用";
        
        [c printCarInfo];
        
        
        //内存管理
//        __strong NSString *mStr = [[NSString alloc] initWithFormat:@"Good"];
//        __weak NSString *str = mStr;
//        NSLog(@"mStr:%@  str:%@", mStr, str);
//        
//        
//        mStr = nil;
//        NSLog(@"mStr:%@  str:%@", mStr, str);
//        
//        printf("\n\n");
        
        
        //类目
        NSString *str = @"Hello world!";
        [str print];
        
        //block用法
        int (^myblock)(int, int);
        myblock = ^(int a, int b){return  a + b;};
        NSLog(@"%d",myblock(1, 2));
        
        //blcok的闭包
        int value = 100;
        int (^changeValue)();
        changeValue = ^()
        {
            //value = 200;
            return value;
        };
        NSLog(@"change value:%d value:%d", changeValue(), value);
        
        //block的常见用法
        [c gotoMall:@"银座" callback:^NSString *(BOOL hasCigartte) {
            if (hasCigartte)
            {
               return @"买一条";
            }
            else
            {
                return @"好吧,不用买了";
            }
        }];
        
        //block实际使用
        NSArray *array = @[@"a", @"b", @"c"];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"obj:%@  idx:%ld", obj, idx);
        }];
    }


	return 0;
}