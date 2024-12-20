#include "macos_utils.h"
#import <Cocoa/Cocoa.h>


void merge_title_bar_and_content_area(QWindow* window) {
    NSView *nsview = (NSView *)window->winId();  // Cast winId to NSView pointer
    if (!nsview) {
        NSLog(@"Error: nsview is nullptr.");
        return; // Handle the error
    }

    NSWindow *nswin = [nsview window];  // Get NSWindow from the NSView
    if (!nswin) {
        NSLog(@"Error: nswin is nullptr.");
        return; // Handle the error
    }


    // Proceed with setting the style masks
    NSWindowStyleMask currentStyleMask = [nswin styleMask];
    NSWindowStyleMask newStyleMask = currentStyleMask |
                                     NSWindowStyleMaskFullSizeContentView |
                                     NSWindowStyleMaskClosable |
                                     NSWindowStyleMaskMiniaturizable |
                                     NSWindowStyleMaskResizable;

    [nswin setStyleMask:newStyleMask];
    [nswin setTitlebarAppearsTransparent:YES];
}
