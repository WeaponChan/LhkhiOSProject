#import "SceneDelegate.h"
#import "LhkhKeyWindowManager.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window API_AVAILABLE(ios(13.0))
{
    if (self.fullScreen == YES) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

//使用此方法可以有选择地配置UIWindow窗口并将其附加到提供的UIWindowScene场景
//如果使用情节提要，则`window`属性将自动初始化并附加到场景中
//此委托并不意味着连接场景或会话是新的（请参阅`application：configurationForConnectingSceneSession`）
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
 API_AVAILABLE(ios(13.0))
{
    if (scene) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self initWithKeyWindow];
        //最好先加载完UI代码[self.window makeKeyAndVisible];
        //通用链接相关代码，用于App被杀死后一键拉起后传递动态参数
        for (NSUserActivity *userActivity in connectionOptions.userActivities) {
            
        }
    }
}

//在系统释放场景时调用
//这是在场景进入背景后不久或会话被丢弃时发生的
//释放与此场景关联的所有资源，这些资源可在场景下次连接时重新创建
//场景可能稍后会重新连接，因为它的会话没有必要被丢弃（请参阅`application：didDiscardSceneSessions`）
- (void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0))
{
    
}

//当场景从非活动状态转换为活动状态时调用
//使用此方法重新启动场景处于非活动状态时已暂停（或尚未开始）的所有任务
- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0))
{
    
}

//当场景从活动状态转换为非活动状态时调用
//这可能是由于临时中断（例如打入电话）而发生的
- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0))
{

}

//当场景从后台过渡到前台时调用
//使用此方法撤消在进入后台时所做的更改
- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0))
{
    
}

//当场景从前台过渡到后台时调用
//使用此方法保存数据，释放共享资源，并存储足够的特定于场景的状态信息
//将场景恢复到当前状态
- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0))
{
    
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0))
{
    NSEnumerator *enumerator = [URLContexts objectEnumerator];
    UIOpenURLContext *context;
    while (context = [enumerator nextObject]) {
        DLog(@"context.URL =====%@",context.URL);
    }
}


//通用链接相关代码，用于App退到后台时一键拉起后传递动态参数
 - (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity API_AVAILABLE(ios(13.0))
{
    
}


- (void)initWithKeyWindow
{
    [[LhkhKeyWindowManager sharedWindow] showKeyWindowRootVC:self.window];
}

@end
