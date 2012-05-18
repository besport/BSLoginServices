_This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version._

_This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details._

_You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>._

# What is BSLoginServices?

While learning how to use the new iOS 5 Storyboards, I quickly found myself in need of something : I wanted to have a Segue that would log the user in -- or verify an already existing one, _before_ it pushed the view. The `BSLoginServices` library is the result of my work.

![Image](https://github.com/besport/BSLoginServices/raw/master/_Images/CustomSegue.png)

At the moment, only Twitter, Facebook, LinkedIn and RunKeeper are supported, but it should be easy to make other APIs behave the same way.

# How to use?

First, you have to run the following commands in a terminal, at the base directory :

```
$ git submodule init
$ git submodule update
```

This will update and download the submodules (at the moment, Facebook and MKNetworkKit) from GitHub.

`BSLoginServices` uses the third-party Facebook SDK, as well as the iOS 5 Twitter Framework and others, so there is quite a number of things to setup before you can use it.

If you want to test it, you should use the `LoginServices.workspace` workspace file, as it should be already set up, aside from your App's IDs and secret keys.

  1. Copy everything under the `Vendor` subdirectory to your project's base directory. Don't add them yet to your project.
  2. Add the projects found in the root directory of this project to your workspace, namely `Facebook.xcodeproj`, `LinkedIn.xcodeproj`, `MKNetworkKit.xcodeproj` and `OAuth2.xcodeproj`.
  3. Set up your project's search paths to include the `Vendor` subdirectory : ![Image](https://github.com/besport/BSLoginServices/raw/master/_Images/SearchPaths.png)
  4. You will find 3 files you also need to add to your main project : `Vendor/OAuth2/GTMOAuth2ViewTouch.xib`, `Vendor/LinkedIn/OAuthStarterKit/OAuthLoginView.xib` and `Vendor/close.png`.
  5. Set up your main project to depend upon the previously added projects and add the generated libraries
  6. Set up your App delegate to initialize each login service : see the `FXAppDelegate` class for an example.
  7. For Facebook login, you also need to edit your app's `Info.plist` to add the `URL Schemes` entry. See the Facebook documentation for more information.

At this point, you should be done (phew!), and you can start adding custom segues with classes `BSFacebookLoginSegue` and `BSTwitterLoginSegue`.

# Custom Login Services

You can use your own login service the same way.
  
  1. Create your login service class, inheriting from the base class `BSLoginService`.
  2. The methods you can override are :
     * `login` : Checks whether the user can login.
     * `logout` : Logs the user out
     * `save` : Save session (to `NSUserDefaults`, usually)
     * `restore` : Restore session
     * You _should_ use `[self succeed]` and `[self failWithError:error]` to notify the delegate that everything is done.
     
  3. Create a custom segue, subclass of `BSLoginSegue`, and override the `service` method to point towards your custom login service (check out the code in `BSTwitterLoginSegue` for instance)
  
Now you can directly use the segue in your storyboard!

# Here be dragons!

This code is still very new, so there might be bugs! If you find one, create a GitHub issue and tell me what happened!
