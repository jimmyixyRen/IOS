#import "ViewController.h"
@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t customQueue = dispatch_queue_create("mQueue", nil);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 10; i++)
        {
            usleep(10);
            NSLog(@"a");
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 10; i++)
        {
            usleep(10);
            NSLog(@"b");
        }
    });
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 10; i++)
        {
            usleep(10);
            NSLog(@"c");
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
    });
}

//GCD 并行计算
//1.main queue 串行线程队列
//2.global queue 并行线程池
    //2.1 有三种并行等级
//3.create queue 串行

//dispatch_async(customQueue, ^{
//    //       //下载图片
//    //        if (下载完毕)
//    //        {
//    //            dispatch_async(dispatch_get_main_queue(), ^{
//    //               填充UIImageView
//    //            });
//    //        }
//});
//
//dispatch_async(queue, ^{
//    for (int i = 0; i < 10; i++)
//    {
//        usleep(10);
//        NSLog(@"a");
//    }
//});
//dispatch_async(queue, ^{
//    for (int i = 0; i < 10; i++)
//    {
//        usleep(10);
//        NSLog(@"b");
//    }
//});

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
