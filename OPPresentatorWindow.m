// OPPresentatorWindow
//
// Copyright (c) 2012 Brandon Williams (http://www.opetopic.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "OPPresentatorWindow.h"
#import <QuartzCore/QuartzCore.h>

@interface OPPresentatorWindow (/**/)
@property (nonatomic, strong) NSMutableDictionary *touchViewsByTouch;
-(BOOL) hasMirroredScreen;
@end

@implementation OPPresentatorWindow

-(void) sendEvent:(UIEvent *)event {
  [super sendEvent:event];

  // early out if there is no mirrored screen connected
  if (! [self hasMirroredScreen]) {
    return ;
  }

  NSSet *touches = [event allTouches];

  // lazily create views that will be placed underneath touches
  self.touchViewsByTouch = self.touchViewsByTouch ?: [NSMutableDictionary new];
  for (UITouch *touch in touches) {
    NSValue *touchValue = [NSValue valueWithPointer:(__bridge const void *)(touch)];
    self.touchViewsByTouch[touchValue] = self.touchViewsByTouch[touchValue] ?: ({
      UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 50.0f)];
      v.layer.cornerRadius = v.frame.size.width/2.0f;
      v.layer.masksToBounds = YES;
      v.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.9f].CGColor;
      v.layer.borderWidth = 2.0f;
      v.alpha = 0.75f;
      v.backgroundColor = [UIColor grayColor];
      [self addSubview:v];
      v;
    });
  }

  // move the touch views to be underneath the touches
  for (UITouch *touch in touches) {
    NSValue *touchValue = [NSValue valueWithPointer:(__bridge const void *)(touch)];

    UIView *v = self.touchViewsByTouch[touchValue];
    CGPoint p = [touch locationInView:self];
    v.center = p;
    [v.superview bringSubviewToFront:v];

    if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
      [v removeFromSuperview];
      [self.touchViewsByTouch removeObjectForKey:touchValue];
    }
  }
}

-(BOOL) hasMirroredScreen {

  if ([[UIScreen screens] count] == 1) {
    return NO;
  }

  for (UIScreen *screen in [UIScreen screens]) {
    if (screen.mirroredScreen) {
      return YES;
    }
  }

  return NO;
}

@end
