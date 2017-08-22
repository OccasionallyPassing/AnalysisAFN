//
//  ViewController.m
//  AnalysisAFN
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

// static函数与普通函数有什么区别？
//static函数与普通函数作用域不同,仅在本文件。只在当前源文件中使用的函数应该说明为内部函数(static修饰的函数)，内部函数应该在当前源文件中说明和定义。对于可在当前源文件以外使用的函数，应该在一个头文件中说明，要使用这些函数的源文件要包含这个头文件.
BOOL myFunction(NSString *name) {
    if (name == nil || [name isEqualToString:@""] || [name isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *afnImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     1.无论NSUrlConnection还是NSUrlSession 整个网络请求过程怎么进行的？
     请求链接--->组织请求参数--->发出请求--->接收响应数据--->组织响应数据
     */
    /*
     2.请求报文和响应报文格式？
            协议版本号 规定传输数据的协议版本  请求方式
     请求行    1.1/HTTP/POST
     请求头（包含客户端的基本信息） 	          
          HOST    主机地址
          ACCEPT  支持的数据格式
          COOKIE  缓存信息
          USER-AGENT  客户端的基本信息
          ACCEPT-Language  支持的语言
          ACCept-encoding   编码格式
          connection    连接方式
     请求空行 相当于请求头结束符
     请求体  请求的具体内容 和请求方式有关
     
     
            协议版本号  响应状态码
     响应行   HTTP/1.1 302 Moved Temporarily
     响应头   
          date   响应时间
          content-length   内容长度
     keep-alive  连接状态
     响应空行  响应头结束
     响应体  所请求的数据
     */
    /*
     3.post和get请求的区别？
     请求内容位置的不同
     get请求内容追加在URL后面，post请求内容放在请求体中，相对于get更加安全
     */
    /*
     4.同步和异步请求的区别？为什么要有同步请求嘞？
     同步——使用者通过单个线程调用服务；该线程发送请求，在服务运行时阻塞，并且等待响应。
     异步——使用者通过两个线程调用服务；一个线程发送请求，而另一个单独的线程接收响应。
     
     */
    /*
     5.缓存策略 NSURLRequestCachePolicy 有什么用？
     　  NSURLRequestCachePolicy指定缓存逻辑。URL加载系统提供了一个磁盘和内存混合的缓存，来相应网络请求。这个缓存允许一个应用减少对网络连接的依赖，并且增加性能。使用缓存的目的是为了使用的应用程序能更快速的响应用户输入，是程序高效的运行。有时候我们需要将远程web服务器获取的数据缓存起来，减少对同一个url多次请求。
     
     　　NSURLRequestUseProtocolCachePolicy = 0, 默认缓存策略。具体工作：如果一个NSCachedURLResponse对于请求并不存在，数据将会从源端获取。如果请求拥有一个缓存的响应，那么URL加载系统会检查这个响应来决定，如果它指定内容必须重新生效的话。假如内容必须重新生效，将建立一个连向源端的连接来查看内容是否发生变化。假如内容没有变化，那么响应就从本地缓存返回数据。如果内容变化了，那么数据将从源端获取
     　　NSURLRequestReloadIgnoringLocalCacheData = 1, URL应该加载源端数据，不使用本地缓存数据
     　　NSURLRequestReloadIgnoringLocalAndRemoteCacheData =4, 本地缓存数据、代理和其他中介都要忽视他们的缓存，直接加载源数据
     　　NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData, 两个的设置相同
     　　NSURLRequestReturnCacheDataElseLoad = 2, 指定已存的缓存数据应该用来响应请求，不管它的生命时长和过期时间。如果在缓存中没有已存数据来响应请求的话，数据从源端加载。
     　　NSURLRequestReturnCacheDataDontLoad = 3, 指定已存的缓存数据用来满足请求，不管生命时长和过期时间。如果在缓存中没有已存数据来响应URL加载请求的话，不去尝试从源段加载数据，此时认为加载请求失败。这个常量指定了一个类似于离线模式的行为
     　　NSURLRequestReloadRevalidatingCacheData = 5 指定如果已存的缓存数据被提供它的源段确认为有效则允许使用缓存数据响应请求，否则从源段加载数据。
     　　只有响应http和https的请求会被缓存。ftp和文件协议当被缓存策略允许的时候尝试接入源段。自定义的NSURLProtocol类能够保护缓存，如果它们被选择使用的话。
     
     　　小结：NSURLRequestReturnCacheDataDontLoad是用于离线模式的，我为了能让用户在离线下面阅读，我就设计了当没有网络的时候的策略为NSURLRequestReturnCacheDataDontLoad。
     */
    self.view.backgroundColor = [UIColor orangeColor];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    manager.securityPolicy = policy;
    
    [manager POST:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [self staticVar];
    if (myFunction(@"wang")) {
        NSLog(@"有值");
    }else{
        NSLog(@"值为空");
    }
    [self compareRespondMethod:[UIView class] selctor:@selector(backgroundColor)];
    [self compareRespondMethod:self.view selctor:@selector(backgroundColor)];
    [self compareRespondMethod:[UIView class] selctor:@selector(layerClass)];
    [self compareRespondMethod:self.view selctor:@selector(layerClass)];

    [self.afnImage setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"] placeholderImage:[UIImage imageNamed:@"sns_icon_6"]];
    
    [self.afnImage setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"] placeholderImage:[UIImage imageNamed:@"sns_icon_6"]];

    [self.afnImage setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"] placeholderImage:[UIImage imageNamed:@"sns_icon_6"]];

    //同步执行串并行队列，任务是在哪条线程中执行嘞？
    //在哪条线程同步执行串行或者并行队列，其任务就是在哪条线程中执行。
    dispatch_queue_t serialQueue = dispatch_queue_create("com.wangyu.viewcontroller.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"serialQueue = %@",[NSThread currentThread]);
    });
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.wangyu.viewcontroller.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"concurrentQueue = %@",[NSThread currentThread]);

    });
    dispatch_queue_t subConcurrentQueue = dispatch_queue_create("com.wangyu.viewcontroller.subconcurrentqueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(subConcurrentQueue, ^{
        dispatch_sync(serialQueue, ^{
            NSLog(@"serialQueue = %@",[NSThread currentThread]);
        });
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"concurrentQueue = %@",[NSThread currentThread]);
            
        });
    });
    
    
    for (NSInteger i = 0; i < 500; i ++) {
        [self.afnImage setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"] placeholderImage:[UIImage imageNamed:@"sns_icon_6"]];
        
        [self.afnImage setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"] placeholderImage:[UIImage imageNamed:@"sns_icon_6"]];
    }
}
/*
 
 
 */

- (void)staticVar{
    NSInteger tempNum = 0;
    for (NSInteger i = 0; i < 5;  i ++) {
        NSLog(@"qianzhe %ld",tempNum);
        static NSInteger num = 0;
        NSLog(@"houzhe %ld",num++);
        tempNum = num;
    }
    
    void *total = &total;
}

- (void)compareRespondMethod:(id)object selctor:(SEL)selctor{
    BOOL isClassRespond = NO,isInstanceRespond = NO;
    if ([object isKindOfClass:[UIView class]]) {
        if ([object respondsToSelector:selctor]) {
            isInstanceRespond = YES;
        }
        NSLog(@"instance respondsToSelector %@ ",isInstanceRespond?@"YES":@"NO");
    }else{
        if ([object respondsToSelector:selctor]) {
            isClassRespond = YES;
        }
        if ([object instancesRespondToSelector:selctor]) {
            isInstanceRespond = YES;
        }
        NSLog(@"class respondsToSelector %@ \n class instancesRespondToSelector %@",isClassRespond?@"YES":@"NO",isInstanceRespond?@"YES":@"NO");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
