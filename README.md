While learning how to use the new iOS 5 Storyboards, I quickly found myself in need of something : I wanted to have a Segue that would log the user in -- or verify an already existing one, _before_ it pushed the view. The `BSLoginServices` library is the result of my work.

![Image](https://github.com/besport/BSLoginServices/raw/master/_Images/CustomSegue.png)

At the moment, only Twitter and Facebook are supported, but it should be easy to make other APIs behave the same way.

# How to use?

`BSLoginServices` uses the third-party Facebook SDK, as well as the iOS 5 Twitter Framework, so there is quite a number of things to setup before you can use it.

  1. Add the `Twitter.framework` and `Accounts.framework` to your project.
  2. Add the [Facebook IOS SDK](https://github.com/facebook/facebook-ios-sdk) to your project. If you don't know how, here is the easy way :
  
    1. Create a new **Cocoa Touch Static Library** target (_File > New > Target > Cocoa Touch Static Library_) called `Facebook`, and disable Automatic Reference Counting (ARC).
    2. Clone the Facebook SDK repository. For instance, at the root of your project, run the command : `git submodules add git://github.com/facebook/facebook-ios-sdk.git Vendor/Facebook`
    3. Add the contents of the `src/` folder to your own project. Take care to set the target membership to the `Facebook` target you've just created, and not to your app.
    4. If Xcode complains about ARC, go to the Facebook target's **Build Settings**, search for `Automatic Reference Counting` and set everything to `NO`.
    5. Add the `libFacebook.a` library to your project. It will be automatically built along with your app.
  
  3. Initialize the login services : the app delegate should conform to the `BSFacebookLoginProvider` and `BSTwitterLoginProvier` protocols.
      1. Add the `facebookLoginService` and `twitterLoginService` properties to your app delegate to conform to the `BSFacebookLoginProvider` and `BSTwitterLoginProvider` protocols :
      
          ```
          #import "BSLoginServices.h"
          
          @interface FXAppDelegate : UIResponder <UIApplicationDelegate, BSFacebookLoginProvider, BSTwitterLoginProvider>

          @property (strong, nonatomic) UIWindow *window;
          @property (nonatomic, retain) BSFacebookLoginService *facebookLoginService;
          @property (nonatomic, retain) BSTwitterLoginService *twitterLoginService;

          @end
          ```
      2. Set them up on application start
      
           ```
           @synthesise facebookLoginService;
           @synthesise twitterLoginService;
           
           - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
           {
                self.facebookLoginService = [[BSFacebookLoginService alloc] initWithAppId:@""];
                self.twitterLoginService = [[BSTwitterLoginService alloc] init];
                return YES;
           }
           ```
  
  4. Setup Facebook
	  1. Create your Facebook App, you should get an App ID from them. See [the Facebook docs](https://developers.facebook.com/docs/mobile/ios/build/) for more info.
	  2. Add your custom URL (should be `fb<app id>`, and replace `<app id>` by your own Facebook App ID) to the projects `Info.plist` file. See the `LoginServices-Info.plist` file in this project for an example.
	  4. Add the URL handlers to your application delegate :
	  
	     ```
	     - (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
             return [facebookLoginService.facebook handleOpenURL:url];
         }

         - (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
             return [facebookLoginService.facebook handleOpenURL:url];
         }
	     ```
	     
At this point, you should be done (phew!), and you can start adding custom segues with classes `BSFacebookLoginSegue` and `BSTwitterLoginSegue`.
