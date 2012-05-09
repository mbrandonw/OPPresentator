OPPresentator
=============

Just a simple subclass of `UIWindow` that will put a small, transparent disk underneath all touches whenever a mirrored screen is connected. It works great for presentations so that the audience can see exactly where you are tapping during a demo.

To use just have your application's window inherit from `OPPresentatorWindow`, and that's it. I also don't want this class in my production code, so I optionally include it, e.g.:

``` objective-c
#ifdef DEBUG
@property (nonatomic, strong) OPPresentatorWindow *window;
#else
@property (nonatomic, strong) UIWindow *window;
#endif
```

I want to give credit to Todd Reed, who created [Touchposé](https://github.com/toddreed/Touchpose), which gave me the inspiration to make this. I just wanted something a little lighter and simpler.

##Installation

We love [CocoaPods](http://github.com/cocoapods/cocoapods), so we recommend you use it.

##Author

Brandon Williams  
[@mbrandonw](http://www.twitter.com/mbrandonw)  
[www.opetopic.com](http://www.opetopic.com)

## License

OPPresentator is available under the MIT license. See the LICENSE file for more info.
